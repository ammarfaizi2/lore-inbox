Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264303AbTLESv0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbTLESv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:51:26 -0500
Received: from fmr05.intel.com ([134.134.136.6]:44781 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264303AbTLEStq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:49:46 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: High-pitch noise with 2.6.0-test11
Date: Fri, 5 Dec 2003 10:49:38 -0800
Message-ID: <F760B14C9561B941B89469F59BA3A84702C93186@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: High-pitch noise with 2.6.0-test11
Thread-Index: AcO7G22TIBgqP88NQxC133C8a3/fswARRM+Q
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Troels Walsted Hansen" <troels@thule.no>,
       "Jean-Marc Valin" <Jean-Marc.Valin@USherbrooke.ca>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Dec 2003 18:49:39.0686 (UTC) FILETIME=[89A21060:01C3BB60]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Troels Walsted Hansen

> > itself (that wasn't there with 2.4). The noise happens only 
> when the CPU
> > is idle. Also, I have noticed that removing thermal.o makes 
> the noise
> > stop, which is very odd. Is there anything that can be done 
> about that?
> 
> I had the same problem with my Dell Latitude C600 and newer 
> kernels with 
>   HZ>100. The solution I found was to add "apm=idle-threshold=100" to 
> the kernel commandline, to disable APM idle calls.
> 
> You should monitor the temperature of your laptop to make sure it 
> doesn't spin wildly and create extra heat if you use the same 
> solution.
> 
> Using ACPI instead of APM might also be a solution?

Here's the answer from another thread:

"It's not normal, but it means they used cheap capacitors. This is known
as the acoustic noise issue. It's related to PCB vibration as a result
of the piezo electric effect on the caps. What is the timer tick
frequency? ... The 1ms gives a nice 1kHz tone. It's related to the
voltage change of C4 exit."

Regards -- Andy
