Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWEQKYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWEQKYk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 06:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWEQKYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 06:24:40 -0400
Received: from spirit.analogic.com ([204.178.40.4]:5384 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932065AbWEQKYk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 06:24:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 17 May 2006 10:24:38.0191 (UTC) FILETIME=[19D55BF0:01C6799C]
Content-class: urn:content-classes:message
Subject: Re: Wiretapping Linux?
Date: Wed, 17 May 2006 06:24:37 -0400
Message-ID: <Pine.LNX.4.61.0605170618210.31079@chaos.analogic.com>
In-Reply-To: <20060517080705.47319.qmail@web51409.mail.yahoo.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Wiretapping Linux?
Thread-Index: AcZ5nBn7JdfNxKxzSJ2uAeVeRpqkYw==
References: <20060517080705.47319.qmail@web51409.mail.yahoo.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Joerg Pommnitz" <pommnitz@yahoo.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 May 2006, Joerg Pommnitz wrote:

> Hello all,
> while I agree with the points made in this discussion that it is harder to
> get a backdoor into Linux I'm left wondering about the whole computing
> system Linux is running on. Modern network card have enough computing
> power to easily run wiretapping that you won't see in the driver code. If
> you are concerned about wiretapping, then the large binary blobs of
> firmware needed to run your peripherals should be of real concern.
>
> The same is true for the BIOS. Even older CPUs come with a system mode
> that exists outside the realm controlled by the OS.
>
> Regards
>  Joerg
>

CPUs inside network cards (if any) don't run in the same address-space
as your host CPU, memory, etc. Data is DMAed (set up on the host-CPU
side) to/from this private bus, using the PCI bus. You would need
very extensive cooperative code running on the host CPU (in the
driver) to do anything useful. If you are going to write such
driver code, you don't need the CPU inside the controller card
at all because you are already running with high privileges on
the correct bus.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.AbominableFirebug.com/ http://www.LymanSchool.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
