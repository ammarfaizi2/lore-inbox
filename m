Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbVLVVx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbVLVVx2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbVLVVx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:53:27 -0500
Received: from spirit.analogic.com ([204.178.40.4]:52228 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1030328AbVLVVx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:53:27 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C60742.22387880"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 22 Dec 2005 21:53:25.0899 (UTC) FILETIME=[22C1A5B0:01C60742]
Content-class: urn:content-classes:message
Subject: 4k stacks
Date: Thu, 22 Dec 2005 16:53:25 -0500
Message-ID: <Pine.LNX.4.61.0512221640490.8179@chaos.analogic.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: 4k stacks
Thread-Index: AcYHQiLLvC9XcxLyQVa43x7ALDUpUg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C60742.22387880
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Yesterday I sent a patch to add stack-poison so the stack usage
could be observed.

Today I wrote a small program and tested the stack usage. Both
the program and the patch is attached. The result is:

Offset : 2ec8f000	Available Stack bytes =3D 3104
Offset : 2ecb1000	Available Stack bytes =3D 3104
Offset : 2ee5f000	Available Stack bytes =3D 20
Offset : 2f36d000	Available Stack bytes =3D 3104
Offset : 2fd09000	Available Stack bytes =3D 3012
Offset : 2fd0b000	Available Stack bytes =3D 3312
Offset : 2fd0f000	Available Stack bytes =3D 2132
Offset : 2fd2f000	Available Stack bytes =3D 2744
Offset : 2fd57000	Available Stack bytes =3D 2900
Offset : 2fdd5000	Available Stack bytes =3D 1400
Offset : 2fe35000	Available Stack bytes =3D 2832
Offset : 2ff3f000	Available Stack bytes =3D 776
Offset : 2ff45000	Available Stack bytes =3D 3188

This, after compiling the kernel. I did not have 4k stacks
enabled for this test so any crashing of the stack beyond
one page will not hurt the system. This was on linux-2.6.13.4.

Anyway, I tried to enable 4k stacks and the machine would
not boot past trying to install the first module. It just
stopped with the interrupts disabled. So, I am now rebuilding
the kernel back as I write this. That's why I am using 2.6.13
at the moment.

Anyway, getting down to 20 bytes of stack-space available
seems to be pretty scary.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.


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
------_=_NextPart_001_01C60742.22387880
Content-Type: APPLICATION/x-gzip;
	name="stack.tar.gz"
Content-Transfer-Encoding: base64
Content-Description: stack.tar.gz
Content-Disposition: attachment;
	filename="stack.tar.gz"

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
L7744osvvvjiiy+++PI/kn8DEqfrrgBQAAA=

------_=_NextPart_001_01C60742.22387880--
