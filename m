Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVHYPn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVHYPn2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 11:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbVHYPn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 11:43:28 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:52234 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932082AbVHYPn1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 11:43:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <BAY14-F14EAD811D62D43C1A2CE2FBAAB0@phx.gbl>
References: <BAY14-F14EAD811D62D43C1A2CE2FBAAB0@phx.gbl>
X-OriginalArrivalTime: 25 Aug 2005 15:43:24.0415 (UTC) FILETIME=[BA7BC8F0:01C5A98B]
Content-class: urn:content-classes:message
Subject: Re: Building the kernel with Cygwin
Date: Thu, 25 Aug 2005 11:42:46 -0400
Message-ID: <Pine.LNX.4.61.0508251138220.3971@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Building the kernel with Cygwin
Thread-Index: AcWpi7qdUhTMZKT5ThGTc0W5xirgYw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Chris du Quesnay" <duquesnay@hotmail.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 Aug 2005, Chris du Quesnay wrote:

> Hi.  I am newbie at GNU/linux.
>
> I am trying to build a kernel (2.6.12)  for a powerpc target using cygwin on
> my i686 machine.  I have
> Windows 2000 as my operating system.
>
> I have recent versions of cygwin (with GNU make 3.80), binutils for the
> powerpc (gcc v 3.3.1, ld v 2.14)
>
> I set
> ARCH=ppc
> CROSS_COMPILE= powerpc-ibm-eabi-
>
> and I add the cross compiler/build directory to my path.
>
> After untaring the kernel, I issue the
> make mrproper, which appears to work.
>
> Then I issue
> make menuconfig
>
> and I get the following error, which I can't seem to get around:
>
> HOSTCC   scripts/basic/fixdep
> fixdep: no such file or directory
> make[1]:*** [scripts/basic/fixdep] Error 2
> make[1] Leaving directory /cygdrive/c/Linux_amcc/linux-2.6.12
>
>
> Can you suggest what the problem might be?  Should I be able to build the
> kernel
> with cygwin?
>

Try this temporary work-around:

cd /cygdrive/c/Linux_amcc/linux-2.6.12/scripts/basic
gcc -O2 -o fixdep fixdep.c

You may also have to do the same thing for docproc, i.e.,
gcc -O2 -o docproc docproc.c

Others may tell you what's wrong, but at least this should get
you started.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12.5 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
