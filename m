Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVF2HOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVF2HOl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 03:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbVF2HOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 03:14:30 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:10904 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262453AbVF2HMu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 03:12:50 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: accessing loopback filesystem+partitions on a file
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Date: Wed, 29 Jun 2005 08:12:44 +0100
Message-ID: <A95E2296287EAD4EB592B5DEEFCE0E9D28240E@liverpoolst.ad.cl.cam.ac.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: accessing loopback filesystem+partitions on a file
Thread-Index: AcV8TXg1851pRgL1RRW2XKJMpP2tewAK1UVA
From: "Ian Pratt" <m+Ian.Pratt@cl.cam.ac.uk>
To: "Luke Kenneth Casson Leighton" <lkcl@lkcl.net>,
       "Grzegorz Kulewski" <kangur@polcom.net>
Cc: <linux-kernel@vger.kernel.org>, <ian.pratt@cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> basically, the thing that is missing (or i can't find it) 
> from linux is a driver with the ability to present [any] 
> block devices with their major+minor numbers as a 
> [fsck-]recogniseable block device with its own major number, 
> with the implicit ability to create minor numbers within it.

The easiest thing to use is the 'lomount' utility that comes with qemu.

http://www.dad-answers.com/qemu/utilities/QEMU-HD-Mounter/lomount/lomoun
t.c

There's also kpartx which is part of device mapper, but its rather
trickier to build.

I think we should pull lomount into our tree until kpartx becomes
ubiquitous.

Ian
