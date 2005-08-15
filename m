Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVHOMKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVHOMKY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 08:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVHOMKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 08:10:24 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:21005 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750721AbVHOMKX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 08:10:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <42FFED9C.6080708@avantwave.com>
References: <42FFED9C.6080708@avantwave.com>
X-OriginalArrivalTime: 15 Aug 2005 12:10:22.0190 (UTC) FILETIME=[4F8D88E0:01C5A192]
Content-class: urn:content-classes:message
Subject: Re: question : any difference between "echo xxx > /dev/console" and printk
Date: Mon, 15 Aug 2005 08:09:45 -0400
Message-ID: <Pine.LNX.4.61.0508150801060.10553@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: question : any difference between "echo xxx > /dev/console" and printk
Thread-Index: AcWhkk+xt5CPYg1HRmGBXtlPVABEtQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Tomko" <tomko@avantwave.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 14 Aug 2005, Tomko wrote:

> Hi all,
>
> as topic, do anyone know is there any difference between them ? by the
> way, console should only output but not input , but i could still see
> something when i type " cat /dev/console"  in one terminal then type
> something at the tty where i open the console.  Can anyone tell me why?
>
>
> Regards,
> TOM
> -

/dev/console is a virtual terminal just like /dev/tty*. It really
has nothing to do with "printk" in the kernel (really). It's
just one of the many places where things "printed" in the kernel
can be displayed.

And, yes, the console is a two-way terminal emulator. It is the
standard-input, standard-output, and standard-error, for the
init process. Normally init doesn't respond to any input from
the console, but during boot it does so that you can try to
fix various errors.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
