Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVACKQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVACKQF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 05:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVACKQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 05:16:05 -0500
Received: from [202.125.86.130] ([202.125.86.130]:29832 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261419AbVACKPo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 05:15:44 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: How can we get the different version.h files under different source directories?
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Mon, 3 Jan 2005 15:49:59 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348112B89FA@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How can we get the different version.h files under different source directories?
Thread-Index: AcTxeph3xLDdag39T/6TTerUqWX3qA==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,
 
I am building the new kernel images for the 2.6.6 and 2.6.8 kernel versions on Intel 
x86 machine which was already installed using 2.6.5-7.71 kernel version. 

I downloaded the kernel tar files from the following link. http://www.kernel.org/pub/linux/kernel/v2.6/

I build the images on the same machine for the new 2.6.6 and 2.6.8 kernels. Now I am able to boot using the new kernel images. But there is the same version.h file under all the source directories. 

I have seen the version.h file under the following source directories. 
 
1.	/usr/src/linux-2.6.5-7.71/include/linux/
2.	/usr/src/linux-2.6.6/include/linux/
3.	/usr/src/linux-2.6.8/include/linux/

The contents of the version.h file are as follows.
--------------------------------------------------
#define UTS_RELEASE "2.6.5-7.71-default"
#define LINUX_VERSION_CODE 132613
#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))

Due the same version.h file, when I try to load the module (which was compiled using the 2.6.8 kernel image on x86 machine which was installed using 2.6.5-7.71 kernel CDs) on another machine which was installed using 2.6.8 kernel CDs, I got the following error. 

> tifm: version magic '2.6.5-7.71-default 586 REGPARM gcc-3.3' should be '2.6.8 PENTIUM4 gcc-3.2'
> insmod: error inserting 'tifm.ko': -1 Invalid module format

I understood that the bug is: we can assume that the module was compiled for 
2.6.5-7.71-default with gcc 3.3 version where as we are trying to load the module on a machine which is having 2.6.8 kernel with gcc 3.2 version. 
 
My doubt is: Why all the source directories does include the same version.h file? How can we get the different version.h files under different source directories? 
 
Please give me an idea or solution, how to resolve the problem?
 
Regards,
Srinivas G
 

