Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTJWGlg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 02:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbTJWGlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 02:41:36 -0400
Received: from linuxhacker.ru ([217.76.32.60]:1961 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S261681AbTJWGlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 02:41:35 -0400
Date: Thu, 23 Oct 2003 09:37:42 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: Badness in as_completed_request at drivers/block/as-iosched.c:919
Message-ID: <20031023063742.GA2011@linuxhacker.ru>
References: <20031022123209.GA2652@linuxhacker.ru> <3F967D66.9090601@cyberone.com.au> <20031022132755.7bfae6a0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031022132755.7bfae6a0.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Oct 22, 2003 at 01:27:55PM -0700, Andrew Morton wrote:
> > The warning should be harmless. I'll remove it once I make sure. I
> > don't think there have been any recent as-iosched changes, so something
> > else must have just triggered it off.
> The smartd failure doesn't look harmless:
> Device: /dev/sdb, SMART Failure: DATA CHANNEL IMPENDING FAILURE DATA ERROR RATE TOO HIGH
> Or does this always happen?

Yes, drive thinks it is. I am aware of this. But kernel looks surprised.
I have another scsi drive in that system whose smart status is OK, and kernel
does not produce this sort of output when smartd is adding /dev/sda to monitor
list.

> I assume we're dealing with a non-fs request here.

I think you are right, though I think filesystems from that drive might be
already mounted by the time smartd is started.

Bye,
    Oleg
