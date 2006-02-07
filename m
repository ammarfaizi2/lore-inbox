Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbWBGQYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbWBGQYB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 11:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbWBGQYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 11:24:01 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:19205 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S965150AbWBGQYA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 11:24:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 07 Feb 2006 16:23:56.0966 (UTC) FILETIME=[E4F81C60:01C62C02]
Content-class: urn:content-classes:message
Subject: pid_t range question
Date: Tue, 7 Feb 2006 11:23:56 -0500
Message-ID: <Pine.LNX.4.61.0602071122520.327@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: pid_t range question
Thread-Index: AcYsAuUZjeee8OpmS9GDjn87SFsfTg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Linux, type pid_t is defined as an int if you look
through all the intermediate definitions such as S32_T,
etc. However, it wraps at 32767, the next value being 300.

Does anybody know why it doesn't go to 0x7fffffff and
then wrap to the first unused pid value? I know the
code "reserves" the first 300 pids. That's not the
question. I wonder why. Also I see the code setting
the upper limit as well. I want to know why it is
set within the range of a short and is not allowed
to use the full range of an int. Nothing I see in
the kernel, related to the pid, ever uses a short
and no 'C' runtime interface limits this either!

Also, attempts to change /proc/sys/kernel/pid_max fail
if I attempt to increase it, but I can decrease it
to where I don't have enough pids available to fork()
the next command! Is this the correct behavior?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
