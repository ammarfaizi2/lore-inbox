Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbTIBUkm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 16:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264089AbTIBUkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 16:40:42 -0400
Received: from fmr09.intel.com ([192.52.57.35]:3823 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S264088AbTIBUkk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 16:40:40 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: KDB in the mainstream 2.4.x kernels?
Date: Tue, 2 Sep 2003 13:40:31 -0700
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE67A@fmsmsx406.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: KDB in the mainstream 2.4.x kernels?
Thread-Index: AcNu5FguHGBJ41GqSJmCBHiEOBCvIQCq3Heg
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Andi Kleen" <ak@muc.de>, "Greg Stark" <gsstark@mit.edu>,
       "Martin Pool" <mbp@sourcefrog.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Sep 2003 20:40:32.0007 (UTC) FILETIME=[73E53170:01C37192]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > instructions as a forth program that frobbed registers 
> appropriately. The
> > > > kernel would have a small forth interpretor to run it. 
> Then switching
> > > > resolutions could happen safely in the kernel.
> > > 
> > > Did the proposal come with working code?
> > 
> > I've seen workable non forth versions of the proposal yes. It isnt 
> > actually that hard to do for most video cards 
> 
> We could make them use code for ACPI interpretter, that's already in
> and has advantage that graphics people might eventually ship it in
> card roms....

The reason I was asking before was because I've been working on a kernel implementation of the EBC (EFI Byte Code) interpreter so that one could employ the use of the UGA (Universal Graphics Adapter) at OS runtime instead of having to rely on VGA (BIOS or hardware) support.  UGA is essentially an EFI driver (aka option ROM) that is intended to be used in pre-OS boot space as well as during OS runtime.  When built as an EBC image the driver can be interpreted and thus used on any platform. 

The UGA protocols defined in the EFI spec enable the capability to perform the mode switching mentioned above.  I hate to keep pointing at ia64, but Tiger systems currently ship with a minimal UGA driver for the embedded ATI controller (this can be seen with the EFI command drivers) and x86 systems with EFI firmware will as well (in addition to traditional VGA support). 

Although this doesn't resolve the immediate issue, this might provide the support needed in the future... 

matt
