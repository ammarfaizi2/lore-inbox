Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbWGFP22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWGFP22 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 11:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWGFP22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 11:28:28 -0400
Received: from spirit.analogic.com ([204.178.40.4]:36614 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1030340AbWGFP21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 11:28:27 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6A110.B089B000"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 06 Jul 2006 15:27:28.0543 (UTC) FILETIME=[B0DC8AF0:01C6A110]
Content-class: urn:content-classes:message
Subject: Re: cpuinfo_x86 and apicid
Date: Thu, 6 Jul 2006 11:27:28 -0400
Message-ID: <Pine.LNX.4.61.0607061123380.10612@chaos.analogic.com>
In-Reply-To: <20060706150118.GB10110@frankl.hpl.hp.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: cpuinfo_x86 and apicid
thread-index: AcahELDmhpw7P7VlTfqNdb+Xsty4VA==
References: <20060706150118.GB10110@frankl.hpl.hp.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Stephane Eranian" <eranian@hpl.hp.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>, <perfmon@napali.hpl.hp.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6A110.B089B000
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


On Thu, 6 Jul 2006, Stephane Eranian wrote:

> Hello,
>
>
> In the context of the perfmon2 subsystem for processor with=
 HyperThreading,
> we need to know on which thread we are currently running. This comes from
> the fact that the performance counters are shared between the two=
 threads.
>
> We use the thread id (smt_id) because we split the counters in half
> between the two threads such that two threads on the same core can run
> with monitoring on.  We are currently computing the smt_id from the
> apicid as returned by a CPUID instruction. This is not very efficient.
>
> I looked through the i386 code and could not find a function nor
> structure that would return this smt_id. In the cpuinfo_x86 structure
> there is an apicid field that looks good, yet it does not seem to be
> initialized nor used.
>
> Is cpuinfo_x86->apicid field obsolete?
> If so, what is replacing it?
>
> Thanks.
>
> --=0D
> -Stephane
> -

Does the attached file help? It is supposed to tell which CPU
execution is occurring on. This might be modified to fill your
needs.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.88 BogoMips).
New book: http://www.AbominableFirebug.com/
_
=1A=04


****************************************************************
The information transmitted in this message is confidential and may be=
 privileged.  Any review, retransmission, dissemination, or other use of=
 this information by persons or entities other than the intended recipient=
 is prohibited.  If you are not the intended recipient, please notify=
 Analogic Corporation immediately - by replying to this message or by=
 sending an email to DeliveryErrors@analogic.com - and destroy all copies=
 of this information, including any attachments, without reading or=
 disclosing them.

Thank you.
------_=_NextPart_001_01C6A110.B089B000
Content-Type: TEXT/PLAIN;
	name="whichcpu.c"
Content-Transfer-Encoding: base64
Content-Description: whichcpu.c
Content-Disposition: attachment;
	filename="whichcpu.c"

LyoNCiAqICBUaGlzIHByb2dyYW0gdGVsbHMgeW91IHdoYXQgQ1BVIHlvdXIgcHJvY2VzcyBpcyBl
eGVjdXRpbmcgb24uDQogKiAgSWYgeW91IGNvbW1lbnQtb3V0IHRoZSB1c2xlZXAoMTAwMDApLCBz
byB5b3UgYXJlIGVhdGluZyBhbGwgdGhlDQogKiAgQ1BVIHRpbWUgaW4geW91ciB0aW1lLXNsaWNl
LCBhbmQgeW91IGV4ZWN1dGUgdGhpcyBmcm9tIHR3byB0YXNrcywNCiAqICB5b3Ugd2lsbCBub3Rl
IHRoYXQgZWFjaCB0YXNrIGdldHMgaXRzIG93biBDUFUgaWYgeW91IGhhdmUgdHdvDQogKiAgQ1BV
cy4NCiAqICBJZiB5b3UgbGVhdmUgaW4gdGhlIHVzbGVlcCgpLCB5b3Ugd2lsbCBub3RlIHRoYXQg
Ym90aCB0YXNrcyBtYXkNCiAqICB1c2UgdGhlIHNhbWUgQ1BVLiBUaGlzIGhhcHBlbnMgaWYsIGFu
ZCBvbmx5IGlmLCB0aGV5IGFyZSBub3QNCiAqICBleGVjdXRpbmcgYXQgdGhlIHNhbWUgdGltZS4N
CiAqLyANCg0KDQojaW5jbHVkZSA8c3RkaW8uaD4NCmludCBtYWluKHZvaWQpOw0KDQppbnQgbWFp
bigpDQp7DQogICAgaW50IGNwdSwgcHJ2Ow0KICAgIHBydiA9IC0xOyANCiAgICBmb3IoOzspDQog
ICAgew0KICAgICAgICBfX2FzbV9fIF9fdm9sYXRpbGVfXyAoDQoJCSJ4b3JsICUlZWF4LCUlZWF4
XG4iDQoJCSJzdHIgJSVheFxuIg0KCQkic3VibCAkMHg2MCwgJSVlYXhcbiINCgkJInNocmwgJDB4
MDUsICUlZWF4XG4iDQoJCTogIj1hIihjcHUpKTsNCiAgICAgICAgaWYoY3B1ICE9IHBydikNCiAg
ICAgICAgew0KICAgICAgICAgICAgcHJ2ID0gY3B1Ow0KICAgICAgICAgICAgcHJpbnRmKCJDUFUg
JWRcbiIsIGNwdSk7DQogICAgICAgIH0NCiAgICAgICAgdXNsZWVwKDEwMDAwKTsNCiAgICB9DQog
ICAgcmV0dXJuIDA7DQp9DQoNCg==

------_=_NextPart_001_01C6A110.B089B000--
