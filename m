Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbUBZBVC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 20:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbUBZBVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 20:21:02 -0500
Received: from fmr05.intel.com ([134.134.136.6]:62600 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262594AbUBZBU4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 20:20:56 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Intel vs AMD x86-64
Date: Wed, 25 Feb 2004 17:19:31 -0800
Message-ID: <7F740D512C7C1046AB53446D37200173EA288C@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Intel vs AMD x86-64
Thread-Index: AcP7/WkAzTlhTlAPTfi44oq9R+FZ8wABJOaQ
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Timothy Miller" <miller@techsource.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Feb 2004 01:19:31.0712 (UTC) FILETIME=[963D7800:01C3FC06]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, that's the very reason I said "useless for compilers." The way
IP/RIP is updated is different (and implementation specific) on those
processors if 66H is used with a near branch. For example, RIP may be
zero-extended to 64 bits (from IP), as you observed before.

Jun
>-----Original Message-----
>From: H. Peter Anvin [mailto:hpa@zytor.com]
>Sent: Wednesday, February 25, 2004 4:14 PM
>To: Timothy Miller
>Cc: Nakajima, Jun; linux-kernel@vger.kernel.org
>Subject: Re: Intel vs AMD x86-64
>
>Timothy Miller wrote:
>>
>>
>> Nakajima, Jun wrote:
>>
>>> For near branches (CALL, RET, JCC, JCXZ, JMP, etc.), the operand
size is
>>> forced to 64 bits on both processors in 64-bit mode, basically
meaning
>>> RIP is updated.
>>>
>>> Compilers would typically use a JMP short for "intraprocedural
jumps",
>>> which requires just an 8-bit displacement relative to RIP.
>>
>> I see.  It's too bad you can't have a 16-bit displacement.
>>
>> Ummm... so if 66H were used with a near branch, would that affect the
>> size of the immediate operand which gets added to RIP, or would that
>> affect the the portion of IP/EIP/RIP affected?  If it's the latter,
>> that's pretty silly.
>>
>
>Yes, that would be pretty silly.
>
>I honestly don't remember off the top of my head what "o16 jmp blah"
>does on i386; I have a vague memory that it zero-extends %eip to 32
>bits, which makes it useless, of course.
>
>	-hpa

