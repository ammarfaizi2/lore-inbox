Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265201AbTANU2Q>; Tue, 14 Jan 2003 15:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265205AbTANU2Q>; Tue, 14 Jan 2003 15:28:16 -0500
Received: from fmr02.intel.com ([192.55.52.25]:3816 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265201AbTANU2O> convert rfc822-to-8bit; Tue, 14 Jan 2003 15:28:14 -0500
content-class: urn:content-classes:message
Subject: RE: timing an application
Date: Tue, 14 Jan 2003 12:37:05 -0800
Message-ID: <331AD7BED1579543AD146F5A1A44D525127AD6@fmsmsx403.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: timing an application
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcK8CZtyZjReYyf8EdeNCQBQi+Bs2AAAkCjA
From: "Howell, David P" <david.p.howell@intel.com>
To: "Maciej Soltysiak" <solt@dns.toxicfilms.tv>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Jan 2003 20:37:06.0407 (UTC) FILETIME=[B3ECDF70:01C2BC0C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If this is on a IA32(Pentium II or later)/IA64 have you considered using
the processor TSC register to get interval timestamps? It's a lot
lighter weight and should give better resolution. When we have done this
we compared the tick values directly.

To convert TSC ticks to time the /proc/cpuinfo value for 'cpu MHz', see
the glibc get_clockfreq.c and hp_timing.h implementation for details.

Dave Howell

-----Original Message-----
From: Maciej Soltysiak [mailto:solt@dns.toxicfilms.tv] 
Sent: Tuesday, January 14, 2003 2:58 PM
To: linux-kernel@vger.kernel.org
Subject: timing an application

Hi,

being inspired by some book about optimizing c++ code i decided to do
timing of functions i wrote. I am using gettimeofday to set
two timeval structs and calculate the time between them.
But the results depend heavily on the load, also i reckon that this
is an innacurate timing.

Any ideas on timing a function, or a block of code? Maybe some kernel
timers or something.

Regards,
Maciej Soltysiak

-----BEGIN GEEK CODE BLOCK-----
VERSION: 3.1
GIT/MU d-- s:- a-- C++ UL++++$ P L++++ E- W- N- K- w--- O! M- V- PS+
PE++
Y+ PGP- t+ 5-- X+ R tv- b DI+ D---- G e++>+++ h! y?
-----END GEEK CODE BLOCK-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
