Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTFDQox (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 12:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTFDQox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 12:44:53 -0400
Received: from eq11.auctionwatch.com ([66.7.130.106]:34207 "EHLO
	whitestar.auctionwatch.com") by vger.kernel.org with ESMTP
	id S263573AbTFDQov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 12:44:51 -0400
Date: Wed, 4 Jun 2003 09:57:51 -0700
From: Petro <petro@corp.vendio.com>
To: Kevin Jacobs <jacobs@penguin.theopalgroup.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, akpm@digeo.com,
       linux-kernel@vger.kernel.org
Message-ID: <20030604165751.GA19357@corp.vendio.com>
References: <3ED60574.3080308@cyberone.com.au> <Pine.LNX.4.44.0305290923330.11990-100000@penguin.theopalgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305290923330.11990-100000@penguin.theopalgroup.com>
User-Agent: Mutt/1.5.4i
Subject: Re: Ext3 meta-data performance
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 06:09:02AM -0400, Kevin Jacobs wrote:
> On Thu, 29 May 2003, Nick Piggin wrote:
> > Kevin Jacobs wrote:
> > >[...]
> > >Since these rsync backups are done in addition to traditional daily tape
> > >backups, we've taken the system out of production use and opened the door
> > >for experimentation.  So, the next logical step was to try a 2.5 kernel. 
> > >After some work, I've gotten 2.5.70-mm2 booting and it is _much_ better than
> > >the Redhat 2.4 kernels, and the system interactivity is flawless.  However,
> > >the speed of creating hard-links is still three and a half times slower than
> > >with the old 2.2 kernel.  It now takes ~14 minutes to create the links, and
> > >from what I can tell, the bottlenecks is not the CPU or the disk-throughput. 
 
>   SCSI ID 1  3ware 7500-8 ATA RAID Controller
>      * Array Unit 0  Mirror (RAID 1)  40.01 GB   OK
>           + Port 0 WDC WD400BB-00DEA0    40.02 GB   OK
>           + Port 1 WDC WD400BB-00DEA0    40.02 GB   OK
>      * Array Unit 4  Striped with Parity 64K (RAID 5)  555.84 GB   OK
>           + Port 4 IC35L180AVV207-1    185.28 GB   OK
>           + Port 5 IC35L180AVV207-1    185.28 GB   OK
>           + Port 6 IC35L180AVV207-1    185.28 GB   OK
>           + Port 7 IC35L180AVV207-1    185.28 GB   OK

    This isn't on the linux side of things, but since this is a backup
    server, and you've also got tape backups, why not just get rid of
    the RAID5 costs and go with a RAID0. 

    (You'd have to have a double fault to take you "offline" and a
    triple fault to lose the data) 

-- 
"On two occasions, I have been asked [by members of Parliament], 'Pray, 
Mr. Babbage, if you put into the machine wrong figures, will the right 
answers come out?' I am not able to rightly apprehend the kind of confusion 
of ideas that could provoke such a question." -- Charles Babbage 
