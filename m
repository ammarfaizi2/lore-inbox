Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291531AbSCTO0F>; Wed, 20 Mar 2002 09:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292385AbSCTOZz>; Wed, 20 Mar 2002 09:25:55 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:46340 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S291531AbSCTOZp> convert rfc822-to-8bit; Wed, 20 Mar 2002 09:25:45 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Hooks for random device entropy generation missing in cpqarray.c 
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Wed, 20 Mar 2002 08:25:39 -0600
Message-ID: <A2C35BB97A9A384CA2816D24522A53BB01E88B79@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Hooks for random device entropy generation missing in cpqarray.c 
thread-index: AcHQE+3jCKc3+fz8Q+idxExCS/YV8QABrKDw
From: "White, Charles" <Charles.White@COMPAQ.com>
To: "Manon Goo" <manon@manon.de>, "Arrays" <Arrays@COMPAQ.com>
Cc: <linux-kernel@vger.kernel.org>, <tytso@MIT.EDU>,
        =?iso-8859-1?Q?Markus_Schr=F6der?= <schroeder.markus@allianz.de>
X-OriginalArrivalTime: 20 Mar 2002 14:25:39.0755 (UTC) FILETIME=[1C1EA7B0:01C1D01B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes.. I was reported that it some how got dropped from our 2.4 version of the driver.. 
DON'T add add_interrupt_randomness, just add "| SA_SAMPLE_RANDOM" to the call to request_irq. 

Patch to follow. 


-----Original Message-----
From: Manon Goo [mailto:manon@manon.de]
Sent: Wednesday, March 20, 2002 7:34 AM
To: Arrays
Cc: linux-kernel@vger.kernel.org; tytso@MIT.EDU; Markus Schröder
Subject: Hooks for random device entropy generation missing in
cpqarray.c 


Hi,

All hooks for the random ganeration (add_blkdev_randomness() ) are ignored 
in the cpqarray / ida  driver.
	Is a patch available ?
	or an other updated driver ?
	any hints where to put add_blkdev_randomness() in your driver ?
	
	is add_interrupt_randomness() called on an i386 SMP IO-APCI system ?


Thanks
Manon

PS: Folks on linux-kernel please CC to manon@manon.de I am not on the list


