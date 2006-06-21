Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWFULxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWFULxU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 07:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWFULxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 07:53:20 -0400
Received: from spirit.analogic.com ([204.178.40.4]:36102 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751505AbWFULxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 07:53:19 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C69529.488C7480"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 21 Jun 2006 11:53:17.0736 (UTC) FILETIME=[48FCC280:01C69529]
Content-class: urn:content-classes:message
Subject: Re: emergency or init=/bin/sh mode and terminal signals
Date: Wed, 21 Jun 2006 07:53:12 -0400
Message-ID: <Pine.LNX.4.61.0606210745550.4244@chaos.analogic.com>
In-Reply-To: <20060619114617.GM4253@implementation.labri.fr>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: emergency or init=/bin/sh mode and terminal signals
thread-index: AcaVKUkIblqEa8CKTU+1n0XBxuALJQ==
References: <20060618212303.GD4744@bouh.residence.ens-lyon.fr> <Pine.LNX.4.61.0606190730070.27378@chaos.analogic.com> <20060619114617.GM4253@implementation.labri.fr>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Samuel Thibault" <samuel.thibault@ens-lyon.org>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C69529.488C7480
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


On Mon, 19 Jun 2006, Samuel Thibault wrote:

> linux-os (Dick Johnson), le Mon 19 Jun 2006 07:37:02 -0400, a =E9crit :
>> I don't think this is the correct behavior. You can't allow some
>> terminal input to affect init. It has been the de facto standard
>> in Unix, that the only time one should have a controlling terminal
>> is after somebody logs in and owns something to control. If you want
>> a controlling terminal from your emergency shell, please exec=
 /bin/login.
>
> Ok, but people don't know that: they're given a shell, and wonder why on
> hell ^C doesn't work...
>
> Samuel

Attached is a simple program called shell. You can copy it to /bin/shell
and use it instead of /bin/bash for your emergency shell. It provides
for terminal control, plus it protects against exit because it does
its work from a fork()ed process and if that exits another is fork()ed
forever.

It has been tested and works, however after you do your emergency
stuff, you can't (correctly) exec /sbin/init as you could with
bash alone, because the executing task does not have PID=3D1. Instead,
you will have to manually unmount any file-systems you mounted, then
reboot using Ctr-Alt-Del.

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
------_=_NextPart_001_01C69529.488C7480
Content-Type: APPLICATION/x-gzip;
	name="shell.tar.gz"
Content-Transfer-Encoding: base64
Content-Description: shell.tar.gz
Content-Disposition: attachment;
	filename="shell.tar.gz"

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
+GqshtWwGlbDtQz/B0lAqLAAUAAA

------_=_NextPart_001_01C69529.488C7480--
