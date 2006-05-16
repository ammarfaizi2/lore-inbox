Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752027AbWEPTFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbWEPTFN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 15:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbWEPTFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 15:05:12 -0400
Received: from ns2.suse.de ([195.135.220.15]:31905 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752443AbWEPTEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 15:04:24 -0400
From: Andi Kleen <ak@suse.de>
To: "Deguara, Joachim" <joachim.deguara@amd.com>
Subject: Re: [PATCH] i386/x86_64: Force pci=noacpi on HP XW9300
Date: Tue, 16 May 2006 21:04:15 +0200
User-Agent: KMail/1.9.1
Cc: "Jeff Garzik" <jeff@garzik.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>
References: <2B2475CC03BBA543AF1B9A19AF46443111FFED@sefsexmb1.amd.com>
In-Reply-To: <2B2475CC03BBA543AF1B9A19AF46443111FFED@sefsexmb1.amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605162104.16275.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 May 2006 20:33, Deguara, Joachim wrote:
> > -----Original Message-----
> > From: Jeff Garzik [mailto:jeff@garzik.org] 
> > Sent: 16 May 2006 19:25
> > To: Andi Kleen
> > Cc: Deguara, Joachim; Linux Kernel Mailing List; Linus 
> > Torvalds; Andrew Morton
> > Subject: Re: [PATCH] i386/x86_64: Force pci=noacpi on HP XW9300
> > 
> > Andi Kleen wrote:
> > > On Tuesday 16 May 2006 19:12, Jeff Garzik wrote:
> > >> Andi Kleen wrote:
> > >>> Did you test that? I had two persons with that 
> > workstation test all 
> > >>> combinations and it worked for them.
> > >> Not yet, it's queued for my next test run.
> > > 
> > > You complained without testing anything? 
> > 
> > When I first got the box, pci=noacpi made mmconfig space go 
> > away, or some other breakage.  If your patch forces that, 
> > then logically that condition should reappear by default.
> > 
> > 	Jeff
> > 
> 
> The fix worked for me.  But as I noted, the lspci output changed and
> going back I see the PCI-X bridge went AWOL, though the the SCSI
> controller (part of that bug) is PCI-X non-bridge anyway.  Also I tested
> this with the SLES kernel which IIRC has mmconfig off by default.  So
> Jeff, I am interested to hear how your testing goes.

But PCI-X reappears when you disable the PCI segmentation in the BIOS
right?

-Andi

