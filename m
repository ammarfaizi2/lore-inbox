Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264075AbTIBUVd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 16:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264079AbTIBUVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 16:21:33 -0400
Received: from fmr09.intel.com ([192.52.57.35]:58328 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S264075AbTIBUV1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 16:21:27 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [UPDATED PATCH] EFI support for ia32 kernels
Date: Tue, 2 Sep 2003 13:21:12 -0700
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE678@fmsmsx406.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [UPDATED PATCH] EFI support for ia32 kernels
Thread-Index: AcNv/bYtqb0X1KIyQnG+DUwHBltl7ABj46YA
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Andrew Morton" <akpm@osdl.org>
Cc: "Matt Tolentino" <metolent@snoqualmie.dp.intel.com>,
       <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>
X-OriginalArrivalTime: 02 Sep 2003 20:21:13.0257 (UTC) FILETIME=[C139F990:01C3718F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As I have heard the story.
> 
> The guys at Intel were having problems getting a traditional
> PC style BIOS to run on the first Itaniums, realized they
> had a opportunity to come up with a cleaner firmware interface
> and came up with EFI.  Open Firmware was considered but dropped
> because it was not compatible with ACPI, and they did not want to
> dilute the momentum that had built up for ACPI.

Yes, Itanium has had EFI since the beginning.  

> And now since Intel has something moderately portable, they intend
> to back port it to x86 and start using/shipping it sometime early next
> year.

Hmmm...  It's not so much of a back port as it is the implementation of the interface on x86 boxes.  In fact, the EFI sample implementation can be used on boxes with legacy BIOSes and the interface is consistent with what is currently shipped on ia64 platforms.  The intention is to have an interface to the firmware that is portable and consistent.  For example, much of the linux loader is shared between ia64 and x86.  Assuming add-in cards have EFI compliant drivers, this also makes option ROM and even system BIOS upgrades easy with EFI utilities and without the need for DOS.    

> What I find interesting is that I don't see it addressed how the 16bit
> BIOS calls in setup.S can be bypassed on x86.  And currently while it
> works to enter at the kernels 32bit entry point if you know what you
> are doing it is still officially not supported. 
 
If one can obtain the required system configuration information from EFI before booting the kernel and pass this information to the kernel so as to enable kernel initialization, then why else might we even need the 16 bit BIOS calls in setup.S that essentially perform the same function?  I'm curious why it wouldn't be better to enter the kernel in 32 bit, protected mode?

thanks,
matt
