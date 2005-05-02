Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVEBQmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVEBQmA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 12:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVEBQ17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 12:27:59 -0400
Received: from fmr14.intel.com ([192.55.52.68]:36025 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S261417AbVEBQPv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 12:15:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH]porting lockless mce from x86_64 to i386
Date: Mon, 2 May 2005 09:15:07 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB60049EED02@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]porting lockless mce from x86_64 to i386
Thread-Index: AcVM0AQluF4gnHUuT92/MO2ZWHjGzgB4l4CAAB+6WTA=
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Guo, Racing" <racing.guo@intel.com>, "Andi Kleen" <ak@muc.de>,
       "Andrew Morton" <akpm@osdl.org>
Cc: "Yu, Luming" <luming.yu@intel.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 May 2005 16:15:09.0501 (UTC) FILETIME=[1C7F96D0:01C54F32]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Guo, Racing
>Sent: Sunday, May 01, 2005 6:02 PM
>To: Andi Kleen; Andrew Morton
>Cc: Yu, Luming; linux-kernel@vger.kernel.org
>Subject: RE: [PATCH]porting lockless mce from x86_64 to i386
>
>>
>>If Luming would not move the mce.c file from x86-64 to i386 then
>>his patch would be only 1/4 as big. I dont know why he does this
>>anyways, it seems completely pointless.
>
>mce.c mce.h and mce_intel.c are moved from x86_64 to i386. so the
>patch is very big. The motivation is to share mce code between
>x86_64 and i386 and avoid duplicate code in x86_64 and i386.
>I don't know whether I completely understand what you point.
>Correct me if I am wrong.

I think what Andi meant was that instead of copying code from x86-64 
to i386 and making x86-64 link to this i386 copy, you can leave the 
code in x86-64 and link it from i386 part of the tree. 

Doing it either way should be OK with this mce code. But I feel, 
despite of the patch size, it is better to keep all the shared 
code in i386 tree and link it from x86-64. Otherwise, it may become 
kind of messy in future, with various links between i386 and x86-64.
Andi/Andrew: What do you suggest here?

Thanks,
Venki
