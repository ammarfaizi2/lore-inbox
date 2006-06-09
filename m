Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965256AbWFINY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965256AbWFINY6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 09:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965258AbWFINY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 09:24:58 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:38409 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S965256AbWFINY5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 09:24:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 09 Jun 2006 13:24:55.0364 (UTC) FILETIME=[18DF3840:01C68BC8]
Content-class: urn:content-classes:message
Subject: Re: Caching kernel messages at boot
Date: Fri, 9 Jun 2006 09:24:55 -0400
Message-ID: <Pine.LNX.4.61.0606090914200.2241@chaos.analogic.com>
In-reply-to: <448991CD.9070404@free.fr>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Caching kernel messages at boot
Thread-Index: AcaLyBkFI3ADMZK1SASTLFt1Jaj6BQ==
References: <448991CD.9070404@free.fr>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "s.a." <sancelot@free.fr>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Jun 2006, s.a. wrote:

> Hi,
> Is there a way to hide the kernel messages from the screen at boot ?
> Best Regards
> Steph

Sure, but it depends upon your boot loader. If you are using grub,
you put 'quiet' on the command-line in /boot/grub/grub.conf. If using
LILO, you can use append="console=null" in lilo.conf. The latter
causes a bit of a problem later on because no kernel messages will
ever be sent to the console. This could be fixed by making your own
'init' which opens /dev/console for the three standard file numbers,
then execs the real /sbin/init. You can put the temporary init
program name on the command-line as well as init=/sbin/my.init.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.88 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
