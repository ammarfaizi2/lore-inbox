Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWEZSPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWEZSPd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 14:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWEZSPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 14:15:33 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:18451 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750805AbWEZSPc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 14:15:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 26 May 2006 18:15:26.0796 (UTC) FILETIME=[5D0828C0:01C680F0]
Content-class: urn:content-classes:message
Subject: Re: [PATCH] POSIX-hostname up to 255 characters
Date: Fri, 26 May 2006 14:15:26 -0400
Message-ID: <Pine.LNX.4.61.0605261409300.8002@chaos.analogic.com>
In-Reply-To: <20060526180131.GA13513@lug-owl.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] POSIX-hostname up to 255 characters
Thread-Index: AcaA8F0Rjjz0CoglSlqyh1uDlNwXaQ==
References: <20060525204534.4068e730.rdunlap@xenotime.net> <m1zmh5b129.fsf@ebiederm.dsl.xmission.com> <20060526144216.GZ13513@lug-owl.de> <Pine.LNX.4.58.0605261025230.9655@shark.he.net> <20060526180131.GA13513@lug-owl.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jan-Benedict Glaw" <jbglaw@lug-owl.de>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "lkml" <linux-kernel@vger.kernel.org>, <drepper@redhat.com>,
       "akpm" <akpm@osdl.org>, <serue@us.ibm.com>, <sam@vilain.net>,
       <clg@fr.ibm.com>, <dev@sw.ru>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 26 May 2006, Jan-Benedict Glaw wrote:

> On Fri, 2006-05-26 10:28:13 -0700, Randy.Dunlap <rdunlap@xenotime.net> wrote:
>> On Fri, 26 May 2006, Jan-Benedict Glaw wrote:
> [Patch touchin all archs]
>>> ...and this should have gone to linux-arch, too...
>>
>> so how does someone know:
>> (a) that this should have gone to linux-arch
>
> Anything that modifies all architectures (eg. new system calls,
> low-level MM changes, ...) should go to linux-arch. This is where all
> architecture maintainers are expected to be around.
>
>> (b) that linux-arch exists
>
> Noticing the existance of linux-arch is admittedly a hard job. It's a
> quite specialized low-volume list, so most people actually never ever
> recognize it--unfortunately.
>
>> (c) what it's full email address it?
>
> The list's email address is linux-arch@vger.kernel.org
>
>> I.e., where is all of this explained?
>
> Nowhere :-/
>
> MfG, JBG

MAXHOSTNAMELEN, defined by POSIX, is 64 bytes. You can't just
change it to 255. If you did, all servers in the universe, all
everything would have to be shutdown, recompiled, and rebooted
simultaneously. You can't have a name-server returning a 255-byte
string when a mail-server can only handle 64 bytes.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.73 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
