Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265869AbTF3UX1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 16:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265870AbTF3UX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 16:23:27 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:50121 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265869AbTF3UX0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 16:23:26 -0400
Subject: Re: [BUG] 2.5.73 Scheduling while atomic with taskfile IO and high
	memory
From: Paul Larson <plars@linuxtestproject.org>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0306302052520.22576@skynet>
References: <Pine.LNX.4.53.0306302052520.22576@skynet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Jun 2003 15:37:32 -0500
Message-Id: <1057005453.5264.2964.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-30 at 15:01, Mel Gorman wrote:
> It only appears if high memory and taskfile IO are enabled at configure
> time and I think it is related to kmap_atomic() and kunmap_atomic(). If I
> comment out the lines inc_preempt_count() and dec_preempt_count() in the
> kmap() functions, it boots fine. I also know that preempt_count() shows
> higher and higher values while printing this loop message.

This sounds similar to what I was seeing with bug #800, only I don't
think I had taskfile IO enabled.  Another person I talked to had some
success by enabling PIIX I think, but that did not work for me.  The
only workaround that worked for me was to disable highmem support.  The
link is: http://bugme.osdl.org/show_bug.cgi?id=800.  I havn't tried it
this week, but I don't think it's been fixed yet.

Thanks,
Paul Larson


