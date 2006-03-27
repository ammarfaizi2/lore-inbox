Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWC0UBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWC0UBV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 15:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWC0UBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 15:01:21 -0500
Received: from spirit.analogic.com ([204.178.40.4]:2830 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751087AbWC0UBV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 15:01:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <200603271953.k2RJrTR28039@inv.it.uc3m.es>
x-originalarrivaltime: 27 Mar 2006 20:01:19.0818 (UTC) FILETIME=[36F162A0:01C651D9]
Content-class: urn:content-classes:message
Subject: Re: uptime increases during suspend
Date: Mon, 27 Mar 2006 15:01:18 -0500
Message-ID: <Pine.LNX.4.61.0603271500050.16973@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: uptime increases during suspend
Thread-Index: AcZR2Tb4DG4LU321Ttu3ioWvj7objA==
References: <200603271953.k2RJrTR28039@inv.it.uc3m.es>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Peter T. Breuer" <ptb@inv.it.uc3m.es>
Cc: "john stultz" <johnstul@us.ibm.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Mar 2006, Peter T. Breuer wrote:

> In article <1143484821.2168.16.camel@leatherman> you wrote:
>>> Would it be possible to get the old behaviour back?
>
>> Why exactly do you want this behavior? Maybe a better explanation would
>> help stir this discussion.
>
> I don't know why he wants it (uptime does not increase during
> hibernation) but I want it so that I can tell if I should time out or
> not on an alarm for inactivity in userspace!  The alarm should fire if
> there has been no activity for a while (30s) while activity is possible.
> If the machine is suspended, no activity is possible, so the alarm
> should not fire.
>
> This is to counteract sysadamins playing with system time (e.g. syncing
> with a net time server after bootup) which might cause artificial time
> outs. Causing a timeout has nasty consequences when, for example, your
> root fs is mounted over the net via daemons that do the network to-ing
> and fro-ing from userspace. The only way they have of getting an
> estimate of REAL time elapsed,  without admin playing about messing
> with them, is by surreptitiously snooping uptime, which more or less
> represents kernel jiffies.
>
> If you change uptime to not represente kernel jiffies, goodbye the last
> hope for counting CPU time passed from userspace. False timeouts WILL
> ensue, and root mounts will fail.
>
> Peter

Well uptime code can be modified to subtract the time (if any) in
hibernation. Then everybody is happy.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
