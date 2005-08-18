Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVHRQDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVHRQDQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 12:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbVHRQDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 12:03:16 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:27154 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932272AbVHRQDQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 12:03:16 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <4fec73ca050818084467f04c31@mail.gmail.com>
References: <4fec73ca050818084467f04c31@mail.gmail.com>
X-OriginalArrivalTime: 18 Aug 2005 16:03:13.0792 (UTC) FILETIME=[56841000:01C5A40E]
Content-class: urn:content-classes:message
Subject: Re: Environment variables inside the kernel?
Date: Thu, 18 Aug 2005 12:02:55 -0400
Message-ID: <Pine.LNX.4.61.0508181150230.5104@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Environment variables inside the kernel?
Thread-Index: AcWkDlaL7K/cHSsQQgSU/mJHOmg1ng==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: =?iso-8859-1?Q?Guillermo_L=F3pez_Alejos?= <glalejos@gmail.com>
Cc: "Linux Kernel mailing list" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Aug 2005, [iso-8859-1] Guillermo López Alejos wrote:

> Hi,
>
> I have a piece of code which uses environment variables. I have been
> told that it is not going to work in kernel space because the concept
> of environment is not applicable inside the kernel.
>
> I belive that, but I need to demonstrate it. I do not know how to
> proof this, perhaps referring to a solid reference about Linux design
> that points to the idea that it has no sense to use environment
> variables in kernel space.
>
> Do anyone knows about the existence of such document?
>
> Thank you,
>
> --
> Guillermo

You have to ask yourself, "What environment?". And, what it would
be used for.

Environment variables are some strings that exist in a processes'
name-space. The kernel is not a process. There are some strings
in the kernel, mostly relating to error messages, but there is
no conceptual use for an 'environment'. Since the kernel performs
functions on behalf of calling tasks, at that time, its environment
is the environment of the caller.

Now, there are environment strings set up for the very first
task by the kernel. This environment normally becomes the
environment of 'init'. (/usr/src/linux-`uname -r`/init/main.c)
This is just a "place-holder" and currently contains "HOME=/"
and "TERM=linux".

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12.5 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
