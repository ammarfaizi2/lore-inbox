Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266547AbUJVRZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUJVRZU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 13:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267326AbUJVRVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:21:53 -0400
Received: from fmr05.intel.com ([134.134.136.6]:21453 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S266741AbUJVRRP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:17:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 22 Oct 2004 10:16:23 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6003287D18@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Thread-Index: AcS4WiKWhV0AqR8aQlCbIA4gbRXIRwAADLdw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Kendall Bennett" <KendallB@scitechsoft.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-fbdev-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 22 Oct 2004 17:16:24.0827 (UTC) FILETIME=[DBD9D4B0:01C4B85A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Kendall Bennett [mailto:KendallB@scitechsoft.com] 
>Sent: Friday, October 22, 2004 10:11 AM
>To: Pallipadi, Venkatesh
>Cc: linux-kernel@vger.kernel.org; 
>linux-fbdev-devel@lists.sourceforge.net
>Subject: RE: [Linux-fbdev-devel] Re: Generic VESA framebuffer 
>driver and Video card BOOT?
>
>"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> wrote:
>
>> I have done some experiments with this video post stuff. I think
>> this should be done using x86 emulator rather than doing in real
>> mode. The reason being, with an userlevel emulator we can call it
>> at different times during resume. The current real mode videopost
>> does it before the driver has restored the PCI config space. Some
>> systems (mostly the ones with Radeon card) requires this to be
>> done after PCI config space is restored. With a userspace
>> emulator, we can call it at various places during the driver
>> restore. 
>> 
>> I have seen the SciTech's x86 emulator in X.org. I could seperate
>> it out from X into a stand alone application that does x86
>> emulation. I use it to get the video back on my laptop (which has
>> radeon card), by calling this user level emulator using
>> usermodehelper call. I hope we will have x86 emulator sitting in a
>> standard place in userspace. That way we can use it in driver
>> restore and solve the S3 video restore problem in a more generic
>> way. 
>
>We already have all this code completely separate from X and would 
>release this as part of the Video Boot package for Linux. The kernel 
>module is one part of it, but the code can be compiled as a 
>stand alone 
>user land program as well (SNAPBoot we call it right now). 
>

That is really nice to know. That will make "video on S3 resume" problem
go away on quite a few laptops. Will look forward to release of such a
code.

Thanks,
Venki
