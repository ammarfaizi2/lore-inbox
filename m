Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWEPSf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWEPSf2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 14:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWEPSf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 14:35:28 -0400
Received: from amdext3.amd.com ([139.95.251.6]:36317 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S932507AbWEPSf1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 14:35:27 -0400
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] i386/x86_64: Force pci=noacpi on HP XW9300
Date: Tue, 16 May 2006 20:33:33 +0200
Message-ID: <2B2475CC03BBA543AF1B9A19AF46443111FFED@sefsexmb1.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] i386/x86_64: Force pci=noacpi on HP XW9300
Thread-Index: AcZ5D+/UbU9OvBiVRXuUFsrCRguSZgABkCbQ
From: "Deguara, Joachim" <joachim.deguara@amd.com>
To: "Jeff Garzik" <jeff@garzik.org>, "Andi Kleen" <ak@suse.de>
cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 16 May 2006 18:34:32.0759 (UTC)
 FILETIME=[5FF2BC70:01C67917]
X-WSS-ID: 6874C4A32K8212611-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jeff Garzik [mailto:jeff@garzik.org] 
> Sent: 16 May 2006 19:25
> To: Andi Kleen
> Cc: Deguara, Joachim; Linux Kernel Mailing List; Linus 
> Torvalds; Andrew Morton
> Subject: Re: [PATCH] i386/x86_64: Force pci=noacpi on HP XW9300
> 
> Andi Kleen wrote:
> > On Tuesday 16 May 2006 19:12, Jeff Garzik wrote:
> >> Andi Kleen wrote:
> >>> Did you test that? I had two persons with that 
> workstation test all 
> >>> combinations and it worked for them.
> >> Not yet, it's queued for my next test run.
> > 
> > You complained without testing anything? 
> 
> When I first got the box, pci=noacpi made mmconfig space go 
> away, or some other breakage.  If your patch forces that, 
> then logically that condition should reappear by default.
> 
> 	Jeff
> 

The fix worked for me.  But as I noted, the lspci output changed and
going back I see the PCI-X bridge went AWOL, though the the SCSI
controller (part of that bug) is PCI-X non-bridge anyway.  Also I tested
this with the SLES kernel which IIRC has mmconfig off by default.  So
Jeff, I am interested to hear how your testing goes.

-joachim

