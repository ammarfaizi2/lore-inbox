Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbUCRKCb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 05:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbUCRKCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 05:02:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59607 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262508AbUCRKC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 05:02:29 -0500
Date: Thu, 18 Mar 2004 11:02:23 +0100
From: Jens Axboe <axboe@suse.de>
To: Eric Valette <eric.valette@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm2 : Badness in elv_requeue_request at drivers/block/elevator.c:157
Message-ID: <20040318100222.GE22234@suse.de>
References: <40596FC5.3080703@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40596FC5.3080703@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18 2004, Eric Valette wrote:
> I have this message two times as I have two adaptec controllers...
> 
> Attached my .config and the dmesg output
> 
> ksymoops 2.4.9 on i686 2.6.5-rc1-mm2.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.6.5-rc1-mm2/ (default)
>      -m /System.map (specified)
> 
> Error (regular_file): read_ksyms stat /proc/ksyms failed
> No modules in ksyms, skipping objects
> No ksyms, skipping lsmod
> CPU 0 irqstacks, hard=c05f7000 soft=c05f6000
> Call Trace:
>  [<c02b268d>] elv_requeue_request+0x8d/0xa0

Ah damn, requeue through blk_insert_request... Let me think about this
a bit, I'll post a fix for you.

-- 
Jens Axboe

