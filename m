Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131061AbQKCSAu>; Fri, 3 Nov 2000 13:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130525AbQKCSAf>; Fri, 3 Nov 2000 13:00:35 -0500
Received: from fw.SuSE.com ([202.58.118.35]:33265 "EHLO linux.local")
	by vger.kernel.org with ESMTP id <S131061AbQKCSAG>;
	Fri, 3 Nov 2000 13:00:06 -0500
Date: Fri, 3 Nov 2000 11:11:29 -0800
From: Jens Axboe <axboe@suse.de>
To: David Mansfield <lkml@dm.ultramaster.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: blk-8 oopses at boot (was: blk-7 fails to boot)
Message-ID: <20001103111129.O521@suse.de>
In-Reply-To: <3A02ECEB.B1AE89@dm.ultramaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A02ECEB.B1AE89@dm.ultramaster.com>; from lkml@dm.ultramaster.com on Fri, Nov 03, 2000 at 11:50:51AM -0500
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03 2000, David Mansfield wrote:
> Hi Jens.
> 
> I've tried your blk-8 patch and it oopses during boot.  I only hand
> copied the stack trace, and ran it through ksymoops:
> 
> Call Trace: [<c01310e0>] [<c0131f55>] [<c014c88e>] [<c014c3dc>]
> [<c01b9cea>] [<c014c4ea>] [<c014c456>]
>         [<c01ba3a4>] [<c018c7ab>] [<c0105000>] [<c018c8ae>] [<c01070e7>]
> [<c0108ce3>]
> Warning (Oops_read): Code line not seen, dumping what data is available
> 
> Trace; c01310e0 <__wait_on_buffer+90/c0>
> Trace; c0131f55 <bread+45/70>
> Trace; c014c88e <msdos_partition+8e/3f0>
> Trace; c014c3dc <check_partition+8c/d0>
> Trace; c01b9cea <sd_init_onedisk+75a/770>
> Trace; c014c4ea <grok_partitions+8a/d0>
> Trace; c014c456 <register_disk+26/30>
> Trace; c01ba3a4 <sd_finish+134/1c0>
> Trace; c018c7ab <scsi_register_device_module+eb/110>
> Trace; c0105000 <empty_bad_page+0/1000>
> Trace; c018c8ae <scsi_register_module+4e/60>
> Trace; c01070e7 <init+7/150>
> Trace; c0108ce3 <kernel_thread+23/30>
> 
> I'm going to try taking MSDOS out of my .config to try to work around
> this.  I'll keep you posted as to my progress.

Thanks, I think this is a generic msdos problem though. If it still
oopses without blk-8, could you send the complete oops please?

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
