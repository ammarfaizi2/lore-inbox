Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbUBYUJD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 15:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbUBYUJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 15:09:03 -0500
Received: from fmr06.intel.com ([134.134.136.7]:28550 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261413AbUBYUHv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:07:51 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE:  Re: Intel vs AMD x86-64
Date: Wed, 25 Feb 2004 12:07:35 -0800
Message-ID: <7F740D512C7C1046AB53446D37200173EA27D6@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: Intel vs AMD x86-64
Thread-Index: AcP7vP9o4mi/Dv5WRNqew8oMRH63uQAG/dsg
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Feb 2004 20:07:36.0451 (UTC) FILETIME=[03134530:01C3FBDB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For near branches (CALL, RET, JCC, JCXZ, JMP, etc.), the operand size is
forced to 64 bits on both processors in 64-bit mode, basically meaning
RIP is updated.

Compilers would typically use a JMP short for "intraprocedural jumps",
which requires just an 8-bit displacement relative to RIP. 

Jun
>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of H. Peter Anvin
>Sent: Wednesday, February 25, 2004 8:17 AM
>To: linux-kernel@vger.kernel.org
>Subject: Re: Intel vs AMD x86-64
>
>Followup to:  <403CCBE0.7050100@techsource.com>
>By author:    Timothy Miller <miller@techsource.com>
>In newsgroup: linux.dev.kernel
>>
>>
>> Nakajima, Jun wrote:
>> > No, it's not a problem. Branches with 16-bit operand size are not
>useful
>> > for compilers.
>>
>>  From AMD's documentation, I got the impression that 66H caused near
>> branches to be 32 bits in long mode (default is 64).
>>
>> So, Intel makes it 16 bits, and AMD makes it 32 bits?
>>
>> Either way, I don't see much use for either one.
>>
>
>Both claims are pretty bogus.  Shorter branches are quite nice for
>intraprocedural jumps; it reduces the cache footprint.
>
>	-hpa
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
