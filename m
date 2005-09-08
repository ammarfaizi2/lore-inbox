Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbVIHRtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbVIHRtq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 13:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbVIHRtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 13:49:46 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:32017 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964907AbVIHRtp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 13:49:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <9c23279705090810123132447d@mail.gmail.com>
References: <9c23279705090810123132447d@mail.gmail.com>
X-OriginalArrivalTime: 08 Sep 2005 17:49:44.0036 (UTC) FILETIME=[B212AA40:01C5B49D]
Content-class: urn:content-classes:message
Subject: Re: How to plan a kernel update ?
Date: Thu, 8 Sep 2005 13:49:43 -0400
Message-ID: <Pine.LNX.4.61.0509081330270.4898@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to plan a kernel update ?
Thread-Index: AcW0nbIZdCcafe6RQFiZzDhjTaXX6Q==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Weber Ress" <ress.weber@gmail.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Sep 2005, Weber Ress wrote:

> Hi,
>
> I'm responsible to planning a kernel upgrade in many servers, from 2.4
> version to 2.6.13 (last stable version), using Debian 3.1r0a
>
> My team has good technical skills, but they need to be led. I would
> like know, what's the best pratices and recommendations that a project
> manager need think BEFORE an kernel upgrade.
>
> A technical guy have a particular vision about this upgrade, but I
> will be very been thankful if I receive from this community another
> vision.. a vision centered in the project process (planning,
> executing, controlling) to make this activity successfully.
>
> Thank's !
>
> Weber Ress

I think you need to get a new distribution from your vendor and
NOT try to just upgrade the kernel. The vendor has already made
certain that the utilities provided with the new distribution work
together. It is a gigantic jump from 2.4 to 2.6 and you may find
that some things don't work as planned.

Then, you should build up an otherwise unused server using your
existing configuration and server programs. It should be a clone
of an existing one with its IP address changed to something
unimportant. Then you should upgrade this server with an entire
new distribution from your favorite vendor.

Once that server is up, you can test its functionality and
verify that all its programs play nicely together. If they
don't, you can modify or rebuild anything that needs to be
fixed BEFORE it goes onto a production server.

Never just grab a new distribution and upgrade a production
server. Even if you have to purchase another box to experiment
with before the upgrade it will be worth it in the long run.
With production servers, never just upgrade the kernel unless
the version numbers between what you have and what you will
have are very close. Even that's not truly safe but you can
dual-boot to get back to the previous kernel if everything
falls apart. You see, it's possible that one or more of your
programs rely upon some side-effects or bugs in an older kernel.
If that bug gets fixed, your program(s) may no longer work
(think data-bases after an off-by-one lseek bug-fix).

Once you have upgraded the emulated server and know what to
fix, upgrade the others one-at-a-time.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
