Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265392AbTIDSIK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265401AbTIDSIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:08:10 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:36571 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S265392AbTIDSHi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:07:38 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [UPDATED PATCH] EFI support for ia32 kernels
Date: Thu, 4 Sep 2003 11:07:29 -0700
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB003D42A54@fmsmsx406.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [UPDATED PATCH] EFI support for ia32 kernels
Thread-Index: AcNx9M0k2pBio6HdQEeg1mNTus8qYQBEzpiQ
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Matt Tolentino" <metolent@snoqualmie.dp.intel.com>,
       <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>
X-OriginalArrivalTime: 04 Sep 2003 18:07:30.0394 (UTC) FILETIME=[680DBBA0:01C3730F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Getting EFI drivers in a byte code format would of course be nice.
> But mostly this helps the Itanium, not x86.  I can already get
> standard x86 option roms.

It would be nice.  It is especially nice for vendors because they can reuse a single driver image for multiple architectures assuming there is an interpreter and EFI support.  

> I totally agree that it is reasonable to bypass setup.S.  But 
> to do that reliably requires consensus that the 32bit entry point is 
> stable.  That has not happen yet, and your patch did nothing to address that.  I
> know it has to happen because I know the boot process, and what has to
> happen to boot with a different x86 BIOS implementation.

Ok, so how do we know it is stable and how might one address that?  How have you addressed this with kexec?  

> Entering via the 32bit entry point has not been previously discussed.
> H. Petern Anvin has not been convinced it should be a stable kernel
> entry point.  

Why?  I've missed this argument.   

The documentation has not been updated.  A recent RedHat
> kernel has even shipped with a different 32bit kernel entry point.

I'm afraid I haven't looked at kexec.  Do you employ the standard 32 bit entry point or do you actually go back to real mode or something in between?

> My hunch is that most of the EFI code should actually live in another
> subarch.  I think the kernel has support for compiling in multiple
> subarches.  If not it is simply because no one has gotten 
> that far yet.

I can see how this could be useful and potentially consolidate the efi related code in ia64, the ia32 stuff I've posted, and any other architecture that supports efi in the future, but don't know about compiling in multiple subarchs.  Comments on how this is done?  

matt
