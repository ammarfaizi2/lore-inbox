Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWAWQLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWAWQLq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWAWQLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:11:46 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:52746 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751484AbWAWQLp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:11:45 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20060123162624.5c5a1b94.diegocg@gmail.com>
X-OriginalArrivalTime: 23 Jan 2006 16:11:39.0369 (UTC) FILETIME=[B1217D90:01C62037]
Content-class: urn:content-classes:message
Subject: Re: [RFC] VM: I have a dream...
Date: Mon, 23 Jan 2006 11:11:29 -0500
Message-ID: <Pine.LNX.4.61.0601231058200.11299@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] VM: I have a dream...
Thread-Index: AcYgN7ErC4KsZctXQ7K7mhDXKZwxCA==
References: <200601212108.41269.a1426z@gawab.com><986ed62e0601221155x6a57e353vf14db02cc219c09@mail.gmail.com><E3C35184F807ADEC2AD9E182@dhcp-2-206.wgops.com><728201270601230705k25e6890ejd716dbfc393208b8@mail.gmail.com> <20060123162624.5c5a1b94.diegocg@gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Diego Calleja" <diegocg@gmail.com>
Cc: "Ram Gupta" <ram.gupta5@gmail.com>, <mloftis@wgops.com>,
       <barryn@pobox.com>, <a1426z@gawab.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Jan 2006, Diego Calleja wrote:

> El Mon, 23 Jan 2006 09:05:41 -0600,
> Ram Gupta <ram.gupta5@gmail.com> escribió:
>
>> Linux also supports multiple swap files . But these are more
>
> There're in fact a "dynamic swap" tool which apparently
> does what mac os x do: http://dynswapd.sourceforge.net/
>
> However, I doubt the approach is really useful. If you need that much
> swap space, you're going well beyond the capabilities of the machine.
> In fact, I bet that most of the cases of machines needing too much
> memory will be because of bugs in the programs and OOM'ing would be
> a better solution.

You have roughly 2 GB of dynamic address-space avaliable to each
task (stuff that's not the kernel and not the runtime libraries).
You can easily have 500 tasks, even RedHat out-of-the-box creates
about 60 tasks. That's 1,000 GB of potential swap-space required
to support this. This is not beyond the capabilites of a 32-bit
machine with a fast front-side bus and fast I/O (like wide SCSI).
Some persons tend to forget that 32-bit address space is available
to every user, some is shared, some is not. A reasonable rule-of-
thumb is to provide enough swap-space to duplicate the address-
space of every potential task.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
