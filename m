Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269392AbTCDPwn>; Tue, 4 Mar 2003 10:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269402AbTCDPwn>; Tue, 4 Mar 2003 10:52:43 -0500
Received: from fmr09.intel.com ([192.52.57.35]:64204 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id <S269392AbTCDPwm> convert rfc822-to-8bit;
	Tue, 4 Mar 2003 10:52:42 -0500
content-class: urn:content-classes:message
Subject: RE: MTRR & HT
Date: Tue, 4 Mar 2003 08:01:48 -0800
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB5640100C182@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: MTRR & HT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcLiQohQgCHMGHIpSWmICZj3rvfFzgAI4TOA
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Reed, Timothy A" <timothy.a.reed@lmco.com>,
       "Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Mar 2003 16:01:52.0377 (UTC) FILETIME=[5F099E90:01C2E267]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MTRRs must always be set properly, and they need to be consistent among the CPUs (and E820 info). For HT, they are shared between the two logical processors in a processor package. So you just set them once per processor package. Wrong MTTR setups (e.g. set UC for WB) can easily cause performance problems. 

Jun

> -----Original Message-----
> From: Reed, Timothy A [mailto:timothy.a.reed@lmco.com]
> Sent: Tuesday, March 04, 2003 3:37 AM
> To: Linux Kernel ML (E-mail)
> Subject: MTRR & HT
> 
> Morning all,
> 
> 	Quick question about MTRR and Hyper-Threading, should I be using
> MTRR in conjuction with HT?  Are there any performance reasons to use or
> not
> use MTRR with HT?
> 
> TIA
> Timothy Reed
> Software Engineer \ Systems Administrator
> Lockheed Martin - NE & SS Syracuse
> Email: timothy.a.reed@lmco.com
> 
> There are 10 types of people in the world; those who understand binary and
> those who don't
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
