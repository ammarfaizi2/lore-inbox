Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVBGUh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVBGUh7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 15:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVBGUga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 15:36:30 -0500
Received: from fmr14.intel.com ([192.55.52.68]:32710 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S261269AbVBGTrE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:47:04 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH][i386] HPET setup, duplicate HPET_T0_CMP needed for some platforms
Date: Mon, 7 Feb 2005 11:47:00 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6003F3456F@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][i386] HPET setup, duplicate HPET_T0_CMP needed for some platforms
Thread-Index: AcUMZSKN9Y4IQRrKSWGe3ctZh6p69AA5/8/g
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Giuseppe Bilotta" <bilotta78@hotpop.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Feb 2005 19:47:01.0829 (UTC) FILETIME=[CAEFE750:01C50D4D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Giuseppe Bilotta
>Sent: Sunday, February 06, 2005 7:59 AM
>To: linux-kernel@vger.kernel.org
>Subject: Re: [PATCH][i386] HPET setup, duplicate HPET_T0_CMP 
>needed for some platforms
>
>Venkatesh Pallipadi wrote:
>> +	/* 
>> +	 * Some systems seems to need two writes to HPET_T0_CMP, 
>> +	 * to get interrupts working
>> +	 */
>> +	hpet_writel(tick, HPET_T0_CMP);
>>  	hpet_writel(tick, HPET_T0_CMP);
>
>Is it known which platforms require two, and which ones require 
>one write? Is it cost-effective to #if CONFIG_ the second 
>write?

Additional write should not be performace critical, as this code is
called
only once, during boot up (and again during system suspend-resume).

Thanks,
Venki
