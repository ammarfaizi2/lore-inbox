Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWDKLgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWDKLgI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWDKLgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:36:08 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:63504 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750768AbWDKLgG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:36:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <Pine.LNX.4.61.0604111230190.928@yvahk01.tjqt.qr>
x-originalarrivaltime: 11 Apr 2006 11:36:01.0205 (UTC) FILETIME=[1BD66E50:01C65D5C]
Content-class: urn:content-classes:message
Subject: Re: Detecting illegal memory access
Date: Tue, 11 Apr 2006 07:36:00 -0400
Message-ID: <Pine.LNX.4.61.0604110730090.29083@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Detecting illegal memory access
Thread-Index: AcZdXBv3w+cb9jIxS+eNqQwPZyPQfA==
References: <Pine.LNX.4.61.0604111230190.928@yvahk01.tjqt.qr>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Apr 2006, Jan Engelhardt wrote:

> Hello,
>
>
> I am looking for a way to check from userspace if a given address can be
> dereferenced. One way would be to examine /proc/self/maps if there is
> something mapped and 'r' at the address, but this seems a little time
> consuming. Is there another way? Kernelspace does have it I think, as
> access_ok().
>
>
> Jan Engelhardt
> --

A user program can trap EFAULT. However, you need to use siglongjmp()
to get back into your program and continue, plus you need to do very
careful coding to mask and unmask the appropriate signals though it
all. Since protection is on a per-page basis, one could make a program
that attempts to R/W from virtual page 0 on up, recoding success or
failure for each page.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
