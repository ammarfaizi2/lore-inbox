Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbVKAWyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbVKAWyT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 17:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbVKAWyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 17:54:19 -0500
Received: from fmr22.intel.com ([143.183.121.14]:15489 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751391AbVKAWyS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 17:54:18 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: processor module locks up hyperthreading enabled machine
Date: Tue, 1 Nov 2005 14:54:12 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6006314A9F@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: processor module locks up hyperthreading enabled machine
Thread-Index: AcXfNjQez1/dFtCJS+ankrXyDtd+4AAAIh9w
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Reinhard Nissl" <rnissl@gmx.de>
Cc: <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 01 Nov 2005 22:54:13.0568 (UTC) FILETIME=[2DDE8400:01C5DF37]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Reinhard Nissl [mailto:rnissl@gmx.de] 
>Sent: Tuesday, November 01, 2005 2:47 PM
>To: Pallipadi, Venkatesh
>Cc: linux-kernel@vger.kernel.org; Brown, Len
>Subject: Re: processor module locks up hyperthreading enabled machine
>
>Hi,
>
>I'm sorry for the delay. Here are the results:


Hmmmmm.... Please try the latest patch here
http://bugme.osdl.org/show_bug.cgi?id=5452


Thanks,
Venki



>
>Pallipadi, Venkatesh wrote:
>
>> 1) Does this problem go way if you boot with maxcpus=1?
>
>No.
>
>The modules are loaded via initrd and SuSE prints the name of 
>the module 
>before loading it. So I get on console
>
>Loading processor
>ACPI: CPU0 (power states:C1[C1])
>ACPI: CPU0 (power states:C1[C1])
>Loading thermal
>Loading fan
>Waiting for device /dev/sda1 to appear: ok
>Attempting manual resume
>Loading jdb
>Loading ext
>Waiting for device /dev/sda2 to appear: ok
>rootfs: major=8 minor=2 devn=2050
>
>Then the system freezes.
>
>Without the maxcpus argument the freeze happens already in 
>front of the 
>above "Loading thermal" line.
>
>> 2) Does the problem go away if you not load the acpi 
>processor module?
>
>Yes.
>
>When I remove processor (and thermal as it has a dependency on 
>processor) to be loaded by initrd then the freeze happens at some time 
>later when acpid gets started, as SuSE loads these modules at 
>that time 
>again in case they were not loaded already.
>
>When I remove loading the processor (and thermal) module at this 
>location too, then the system is running ok so far besides the 
>restrictions which result from not loading these modules.
>
>What should I try next?
>
>Bye.
>-- 
>Dipl.-Inform. (FH) Reinhard Nissl
>mailto:rnissl@gmx.de
>
