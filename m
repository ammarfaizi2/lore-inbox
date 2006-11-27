Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757349AbWK0IY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757349AbWK0IY1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 03:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757381AbWK0IY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 03:24:27 -0500
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36]:10677 "EHLO
	dgate2.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S1757349AbWK0IY0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 03:24:26 -0500
DomainKey-Signature: s=s768; d=fujitsu-siemens.com; c=nofws; q=dns; b=qrO9W2rjb+w6HyDtrSsyqcv4AbcLbaHRB3cFzcqNvEfd1Zex/CxD0swyiT1x1ErFbQDD/xO57F1myDBnWasr3TEK53mvFiCwCy2cFq5c0KoQsmpCtzdp2D9sGaaMgdhl;
X-SBRSScore: None
X-IronPort-AV: i="4.09,462,1157320800"; 
   d="scan'208"; a="49002989:sNHT24238672"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Weird wasting of time between ioctl() and ioctl dispatcher
Date: Mon, 27 Nov 2006 09:24:24 +0100
Message-ID: <F7F9B0BE3E9BD449B110D0B1CEF6CAEF03FA5863@ABGEX01E.abg.fsc.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Weird wasting of time between ioctl() and ioctl dispatcher
Thread-Index: AccR/XOCFX6eql9NRr2YYNdjExoA2A==
From: "Cestonaro, Thilo \(external\)" 
	<Thilo.Cestonaro.external@fujitsu-siemens.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Nov 2006 08:24:24.0582 (UTC) FILETIME=[72537A60:01C711FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I'm a developer for Fujitsu Siemens Computers, working on a program which has it's own kernel modules and userland components.
Now cause the program should be released we have done some testing and during this testphase a wierd wasting of time occured
during the call of the ioctl() in the userland component and the actuall entering of the dispatcher function in the module.
It takes 3 min. until the call at last enters my dispatcher. (Debugging output with printf on line before ioctl() and printk as first line in the 
dispatch function points that out). The dispatch function is the ioctl part of the fileoperations struct which defines the module stuff.

The kernel I'm running is the 2.6.16.21-0.8-default of SLED10 (32Bit), but installed on a 64Bit machine.
Can anyone point me to, where I can have a look where the waste of time comes from?

The ioctl itself works fine afterwards, but the whole process is time-critical so the 3 min. do hurt :(.

Ciao Thilo 
