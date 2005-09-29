Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbVI2WGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbVI2WGP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 18:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVI2WGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 18:06:15 -0400
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:52332 "HELO
	web31806.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751341AbVI2WGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 18:06:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=demT0plqrrquqN8xwAX+u8kZ1XpieWo4S+841+0x0Rv/r526Z5zK/knTpnwj1RA/4baAUI4OZ36zYbm05oqqNMDS3cxnq6/CITs2dv6Pdgo0d/omKP+LR/FZMnoDFgLGBdzQfw92zCpaCMQ93sds3DkBGKHlDudf0OzWcR4aofg=  ;
Message-ID: <20050929220613.78655.qmail@web31806.mail.mud.yahoo.com>
Date: Thu, 29 Sep 2005 15:06:13 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
To: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Cc: Luben Tuikov <luben_tuikov@adaptec.com>,
       Andre Hedrick <andre@linux-ide.org>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Luben Tuikov <ltuikov@yahoo.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <433C3BD7.4090104@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> Luben Tuikov wrote:
> > What you'll see in the code is:
> > 
> >   hardware implementation  (interconnect, SAM 4.15, 1.3)
> >       firmware implementation  (interconnect, SDS, SAM 4.6, 1.3)
> >           LLDD                     (SAM, section 5, 6, 7)
> >              Transport Layer          (SAM 4.15, SAS)
> >                   SCSI Core             (SAM section 4,5,8)
> >                      Commmand Sets        (SAM section 1)
> > 
> > A very nice explanation in latest SAM4r03,
> > section 4.15 The SCSI model for distributed communications.
> 
> BTW, Linux' implementations of transports like USB storage and SBP-2 
> have always been similarly layered. (Actually they come with at least 
> one more layer between LLDD and SCSI core.) Needless to say that these 
> transports need their specific managing infrastructures. So this 
> layering is not at all new to Linux.

True, true.

But those subsystems are shielded from SCSI Core.  Plus SCSI Core
is managed by people unaware of SAM or the layering infrastructure.

    Luben
 
> > Now for MPT based solutions you have:
> > 
> >   LLDD                  (SAM, section 5, 6, 7)
> >      SCSI Core             (SAM section 4,5,8)
> >         Commmand Sets         (SAM section 1)
> > 
> > You see?  No Transport Layer between LLDD and SCSI Core!
> > Why?  Because all this work is done in FIRMWARE!
> 
> -- 
> Stefan Richter
> -=====-=-=-= =--= ===-=
> http://arcgraph.de/sr/
> 

