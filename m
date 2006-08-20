Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422645AbWHTHZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422645AbWHTHZm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 03:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbWHTHZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 03:25:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32404 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751667AbWHTHZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 03:25:42 -0400
Date: Sun, 20 Aug 2006 00:23:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm2
Message-Id: <20060820002340.f313d113.akpm@osdl.org>
In-Reply-To: <44E80B5C.1070300@reub.net>
References: <20060819220008.843d2f64.akpm@osdl.org>
	<44E80B5C.1070300@reub.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2006 19:12:28 +1200
Reuben Farrelly <reuben-lkml@reub.net> wrote:

> 
> 
> On 20/08/2006 5:00 p.m., Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm2/
> > 
> > 
> > - Various random stuff.
> > 
> > - I haven't been pulling Greg's post-2.6.18-rc4 tree due to various git woes
> >   which I haven't gotten around to working out how to fix.  But most of it
> >   will be here anyway.
> > 
> > - The automounter is known to be a bit broken.
> > 
> > - Alpha coredumps won't work right.
> 
> Two problems remain and seem to be continuing to be unfixed and unacknowledged 
> in this release despite maintainers previously been cc'd on the problems.
> 
> 1. Reliably pulling some similar looking oopses on x86_64 when booting up - I 
> wasn't the only reporter of this.  All my traces have complaints about 
> MAX_STACK_TRACE_ENTRIES too low but I'm not sure if that is the cause of the 
> trace or happens as a result of the trace.
> 
> GRE over IPv4 tunneling driver
> NET: Registered protocol family 10
> IPv6 over IPv4 tunneling driver
> BUG: MAX_STACK_TRACE_ENTRIES too low!
> turning off the locking correctness validator.

Ingo is on vacation.  When he resurfaces we can bug him about this.  It
doesn't seem particularly urgent - turn off lockdep?

> 
> 2. Also still having no joy with ATA layer driving my ATAPI cdrom:
> 
> ata5: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x30B0 irq 14
> ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x30B8 irq 15
> scsi4 : ata_piix
> ata5.00: ATAPI, max UDMA/66
> ata5.00: configured for UDMA/66
> scsi5 : ata_piix
> ata6: port disabled. ignoring.
> ATA: abnormal status 0xFF on port 0x177
> ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata5.00: (BMDMA stat 0x24)
> ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata5: soft resetting port
> ata5.00: configured for UDMA/66
> ata5: EH complete
> ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata5.00: (BMDMA stat 0x24)
> ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata5: soft resetting port
> ata5.00: configured for UDMA/66
> ata5: EH complete
> ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata5.00: (BMDMA stat 0x24)
> ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata5: soft resetting port
> ata5.00: configured for UDMA/66
> ata5: EH complete
> ata5.00: limiting speed to UDMA/44
> ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata5.00: (BMDMA stat 0x24)
> ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata5: soft resetting port
> ata5.00: configured for UDMA/44
> ata5: EH complete
> 
> This too, seems to be going unacknowledged and unfixed.  Fair enough, it's new 
> code but I've received no response as to whether it should work, or shouldn't, 
> whether I should persist trying with it or if I can help with fixing/testing it 
> ... ?

pata-over-ata is Alan.  It is important that the right people be cc'ed,
please.  A lot of stuff goes flying by..


