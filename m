Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVFSE6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVFSE6P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 00:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVFSE6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 00:58:15 -0400
Received: from fmr16.intel.com ([192.55.52.70]:41401 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261832AbVFSE6H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 00:58:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6.12] x86-64 IO-APIC + timer doesn't work
Date: Sat, 18 Jun 2005 21:57:27 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6004FF1606@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.12] x86-64 IO-APIC + timer doesn't work
Thread-Index: AcV0bvIcclz1SOmLTA6SFkZHLcpNMgAHB3qQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Andi Kleen" <ak@muc.de>, "Alistair John Strachan" <s0348365@sms.ed.ac.uk>
Cc: <linux-kernel@vger.kernel.org>, <ACurrid@nvidia.com>
X-OriginalArrivalTime: 19 Jun 2005 04:57:30.0784 (UTC) FILETIME=[65D7BA00:01C5748B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Andi Kleen [mailto:ak@muc.de] 
>Sent: Saturday, June 18, 2005 6:34 PM
>To: Alistair John Strachan
>Cc: linux-kernel@vger.kernel.org; ACurrid@nvidia.com; 
>Pallipadi, Venkatesh
>Subject: Re: [2.6.12] x86-64 IO-APIC + timer doesn't work
>
>> Despite the fact that this wasn't documented in the BIOS 
>update, an update for 
>> my board (MS-7030 Neo Platinum by MSI) supposedly fixing 
>"Fan Function" 
>> actually corrects the IO-APIC and NMI bugs. I now get the 
>following in dmesg 
>> instead:
>> 
>> Calibrating delay loop... 3973.12 BogoMIPS (lpj=1986560)
>> Mount-cache hash table entries: 256
>> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
>> CPU: L2 Cache: 512K (64 bytes/line)
>> CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 00
>> Using local APIC timer interrupts.
>> Detected 12.561 MHz APIC timer.
>> testing NMI watchdog ... OK.
>> 
>> So I'm a happy man. Whether this is at all related to the 
>problems I was 
>> having before, I don't really know. If the problem doesn't 
>reoccur, I could 
>> very well have wasted your time.
>
>Hmm - I suspect I know what's happening. The older BIOS 
>probably had some long
>running SMM code that breaks the BogoMips computation occasionally
>and that breaks the timer check later which relies on usable BogoMips.
>
>There was a patch for that from Venkatesh (because it showed on some
>other machines too), but it didn't seem to have made it into 2.6.12 
>
>Venkatesh, can you push your calibrate_delay patch please? ? 
>
>
>-Andi


That patch is in mm tree.

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc
6/2.6.12-rc6-mm1/broken-out/platform-smis-and-their-interferance-with-ts
c-based-delay-calibration.patch

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc
6/2.6.12-rc6-mm1/broken-out/platform-smis-and-their-interferance-with-ts
c-based-delay-calibration-fix.patch

Thanks,
Venki
