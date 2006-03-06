Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWCFPz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWCFPz0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 10:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWCFPz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 10:55:26 -0500
Received: from xenotime.net ([66.160.160.81]:8834 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751388AbWCFPzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 10:55:23 -0500
Date: Mon, 6 Mar 2006 07:56:48 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: J M Cerqueira Esteves <jmce@artenumerica.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, support@artenumerica.com,
       ngalamba@fc.ul.pt, axboe@suse.de
Subject: Re: oom-killer: gfp_mask=0xd1 with 2.6.15.4 on EM64T [previously
 2.6.12]
Message-Id: <20060306075648.c7e0eeeb.rdunlap@xenotime.net>
In-Reply-To: <440C12DA.6010302@artenumerica.com>
References: <4405D383.5070201@artenumerica.com>
	<20060302011735.55851ca2.akpm@osdl.org>
	<440865A9.4000102@artenumerica.com>
	<4409B8DC.9040404@artenumerica.com>
	<20060304161519.6e6fbe2c.akpm@osdl.org>
	<440BFEA8.2080103@artenumerica.com>
	<20060306012854.581423ec.akpm@osdl.org>
	<440C12DA.6010302@artenumerica.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Mar 2006 10:45:46 +0000 J M Cerqueira Esteves wrote:

> Andrew Morton wrote:
> > I've not been following the saga of atapi-versus-libata at all closely. 
> > Booting with libata.atapi_enabled=1 might make things work.  I think Randy
> > should know what happened here?
> > 
> > You were testing 2.6.16-rc5, yes?  What did you expect to see and what were
> > you seeing in earlier kernels (which versions?)  (IOW: what did we break
> > this time?)
> 
> Yes, this was with 2.6.16-rc5 with the suggested patch.
> 
> I haven't tried libata.atapi_enabled=1 yet (I'll do it on the first
> reboot after this set of tests with Gaussian).

Yes, that should be all you need to do in current kernels.
Maybe Ubuntu already has that enabled for you.  :)


> Under both 2.6.12 (as supplied with Ubuntu Breezy) and 2.6.15 (as
> supplied with the current Ubuntu Dapper, incorporating 2.6.15.4) we had:
> 
> ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x18F0 irq 14
> ata1: dev 0 cfg 49:0f00 82:0218 83:4000 84:4000 85:0218 86:0000 87:4000
> 88:041f
> ata1: dev 0 ATAPI, max UDMA/66
> ata1: dev 0 configured for UDMA/33
> scsi0 : ata_piix
> isa bounce pool size: 16 pages
>   Vendor: ASUS      Model: DRW-1608P2S       Rev: 1.37
>   Type:   CD-ROM                             ANSI SCSI revision: 05
> 
> But we didn't use the drive much until now (mostly just for Linux
> installation, without CD reading problems) so I have no additional data
> on possible issues with previous kernels...
> 
> Best regards
>                    J Esteves
> -- 
> +351 939838775   Skype:jmcerqueira   http://del.icio.us/jmce
> 


---
~Randy
