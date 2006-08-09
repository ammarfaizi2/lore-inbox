Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030701AbWHILeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030701AbWHILeB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 07:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030700AbWHILeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 07:34:01 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:29458 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1030701AbWHILeA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 07:34:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 09 Aug 2006 11:33:58.0732 (UTC) FILETIME=[B46888C0:01C6BBA7]
Content-class: urn:content-classes:message
Subject: Re: ext3 corruption
Date: Wed, 9 Aug 2006 07:33:58 -0400
Message-ID: <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>
In-Reply-To: <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ext3 corruption
Thread-Index: Aca7p7SO1iiylu71TqGCxBmLhW3FsA==
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com> <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Molle Bestefich" <molle.bestefich@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Aug 2006, Molle Bestefich wrote:

> I have a ~1TB filesystem that fails to mount, the message is:
>
> EXT3-fs error (device loop0): ext3_check_descriptors: Block bitmap for
                  ^^^^^^^^^^^_________

It seems as though you have a LOT of RAM if you can make a 1TB
filesystem on the loopback device!

Seriously, what are you doing, attempting to mount a big file-system
through the loop-back device or is this a copied-down message message
you got during boot when initrd tried to mount a RAM disk?

> group 2338 not in group (block 1607003381)!
> EXT3-fs: group descriptors corrupted !
>

Ordinary disk repair involves running fsck on an UNMOUNTED file-system.

> A day before, it worked flawlessly.
>
> What could have happened, and what's the best course of action?

Any bad RAM, any shutdown without a proper unmount, any device hardware
error like DMA not completing properly, can cause file-system corruption.
That's why there are tools to fix it.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
