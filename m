Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752263AbWCFJak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbWCFJak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 04:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbWCFJak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 04:30:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30629 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752263AbWCFJak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 04:30:40 -0500
Date: Mon, 6 Mar 2006 01:28:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: J M Cerqueira Esteves <jmce@artenumerica.com>
Cc: linux-kernel@vger.kernel.org, support@artenumerica.com, ngalamba@fc.ul.pt,
       axboe@suse.de, "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: oom-killer: gfp_mask=0xd1 with 2.6.15.4 on EM64T [previously
 2.6.12]
Message-Id: <20060306012854.581423ec.akpm@osdl.org>
In-Reply-To: <440BFEA8.2080103@artenumerica.com>
References: <4405D383.5070201@artenumerica.com>
	<20060302011735.55851ca2.akpm@osdl.org>
	<440865A9.4000102@artenumerica.com>
	<4409B8DC.9040404@artenumerica.com>
	<20060304161519.6e6fbe2c.akpm@osdl.org>
	<440BFEA8.2080103@artenumerica.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J M Cerqueira Esteves <jmce@artenumerica.com> wrote:
>
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/broken-out/x86_64-mm-blk-bounce.patch.
> >  Could you test that?  (and don't alter the Cc: list!).  The patch is
> > against 2.6.16-rc5.
> 
> I forgot to mention that the DVD drive was not automatically recognized:
> 
> ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x18F0 irq 14
> ata1: dev 0 cfg 49:0f00 82:0218 83:4000 84:4000 85:0218 86:0000 87:4000
> 88:041f
> ata1: dev 0 ATAPI, max UDMA/66
> ata1: dev 0 configured for UDMA/33
> scsi0 : ata_piix
> ata1(0): WARNING: ATAPI is disabled, device ignored.
> 
> Is this still as described in
> http://www.thinkwiki.org/wiki/Problems_with_SATA_and_Linux
> under "DVD drive not recognized"?  Perhaps I'll be able to do some tests
> on that later, too.
> 

I've not been following the saga of atapi-versus-libata at all closely. 
Booting with libata.atapi_enabled=1 might make things work.  I think Randy
should know what happened here?

You were testing 2.6.16-rc5, yes?  What did you expect to see and what were
you seeing in earlier kernels (which versions?)  (IOW: what did we break
this time?)

