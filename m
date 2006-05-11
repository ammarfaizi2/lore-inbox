Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbWEKPrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWEKPrl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 11:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbWEKPrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 11:47:41 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:60687 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1030289AbWEKPrl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 11:47:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20060511143440.23517.qmail@securityfocus.com>
X-OriginalArrivalTime: 11 May 2006 15:47:37.0655 (UTC) FILETIME=[3A6A6470:01C67512]
Content-class: urn:content-classes:message
Subject: Re: SecurityFocus Article
Date: Thu, 11 May 2006 11:47:37 -0400
Message-ID: <Pine.LNX.4.61.0605111140030.3833@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SecurityFocus Article
Thread-Index: AcZ1Ejpx4t1o36C1SgOSO1/GitXUtw==
References: <20060511143440.23517.qmail@securityfocus.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ed White" <ed.white@libero.it>
Cc: "ML" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 May 2006, Ed White wrote:

> A researcher of the french NSA discovered a scary vulnerability in modern x86 cpus and chipsets that expose the kernel to direct tampering.
>
> http://www.securityfocus.com/print/columnists/402
>
> The problem is that a feature called System Management Mode could be used to bypass the kernel and execute code at the highest level possible: ring zero.
>
> The big problem is that the attack is possible thanks to the way X Windows is designed, and so the only way to eradicate it is to redesign it, moving video card driver into the kernel, but it seems that this cannot be done also for missing drivers and documentation!
>
> I would like to hear developers opinion about it...
>
>
> ------------------------------------------------------------------------
>
> The quest for ring 0
>
> by Federico Biancuzzi
> 2006-05-10
>
> Federico Biancuzzi interviews French researcher Lo&iuml;c Duflot to learn about the System Management Mode attack, how to mitigate it, what hardware is vulnerable, and why we should be concerned with recent X Server bugs.
> http://www.securityfocus.com/columnists/402
>

If the SMRAM control register exists, the D_LCK bit can be set
in 16-bit mode during the boot sequence. This makes the SMRAM
register read/only so the long potential compromise sequence
that Mr. Duflot describes would not be possible. If the control
register doesn't exist, then the vulnerably doesn't exist.

The writer doesn't like the fact that a root process can execute
iopl(3) and then be able to read/write ports. He doesn't like
the fact that the X-server can read/write ports from user-mode.

Sorry, the X-server is too large to go into the kernel. It's
a lot easier to modify the boot-loader to set the D_LCK bit
if the security compromise turns out to be real.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
