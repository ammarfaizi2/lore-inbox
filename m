Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWBQVWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWBQVWg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 16:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWBQVWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 16:22:36 -0500
Received: from spirit.analogic.com ([204.178.40.4]:47886 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750812AbWBQVWf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 16:22:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <43F63A59.6090401@cfl.rr.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
x-originalarrivaltime: 17 Feb 2006 21:22:34.0459 (UTC) FILETIME=[44C212B0:01C63408]
Content-class: urn:content-classes:message
Subject: Re: C/H/S from user space
Date: Fri, 17 Feb 2006 16:22:34 -0500
Message-ID: <Pine.LNX.4.61.0602171609480.4549@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: C/H/S from user space
Thread-Index: AcY0CETJzj1MPjzKTKmLPtqMx00VqA==
References: <Pine.LNX.4.61.0602171157140.8950@chaos.analogic.com> <43F617FA.2030609@wolfmountaingroup.com> <Pine.LNX.4.61.0602171452520.4290@chaos.analogic.com> <43F63A59.6090401@cfl.rr.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Phillip Susi" <psusi@cfl.rr.com>
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Feb 2006, Phillip Susi wrote:

> linux-os (Dick Johnson) wrote:
>>
>> Yes, it's a very good model, in fact what I've been talking about.
>> However, several people who refused to read or understand, insisted
>> upon obtaining the exact same C/H/S that the machine claimed to
>> use when it was booted.
>>
>
> That's because if you don't use the same geometry that the bios reports
> when calculating the CHS addresses of the sectors you intend to load,
> you won't be requesting the right sectors from int 13.
   ^^^____

Who is YOU??? I would certainly be requesting the right sectors
if I (or anybody else who knows what they are doing), wrote
the boot code. The boot loader knows about OFFSETS into the
device where it's going to get its data, which eventually
becomes a whole operating system. It doesn't give a *uck about
anything else. There is a table of OFFSETS, obtained from
the file-system, of the correct pieces of files (since there
will not be a file-system until the machine is booted). This
table of offsets needs to be read somewhere in the first 63
sectors (32256 bytes). These offsets contain the junk to
be loaded into memory.

The boot-code, the code that executes in the 16-bit environment,
converts those offsets (after getting data from the DPB) into
the respective junk to put into the registers as I explained
over and over and over again.

You refuse to learn. Please go away.

[SNIPPED...]

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
