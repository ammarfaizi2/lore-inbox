Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVGVP6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVGVP6Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 11:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVGVP6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 11:58:15 -0400
Received: from spirit.analogic.com ([208.224.221.4]:62473 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S261303AbVGVP6K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 11:58:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <3faf0568050722081890a2e@mail.gmail.com>
References: <3faf0568050721232547aa2482@mail.gmail.com> <7d15175e050722072727a7f539@mail.gmail.com> <3faf0568050722081890a2e@mail.gmail.com>
X-OriginalArrivalTime: 22 Jul 2005 15:58:07.0410 (UTC) FILETIME=[26BEA120:01C58ED6]
Content-class: urn:content-classes:message
Subject: Re: Whats in this vaddr segment 0xffffe000-0xfffff000 ---p ?
Date: Fri, 22 Jul 2005 11:56:34 -0400
Message-ID: <Pine.LNX.4.61.0507221154150.16740@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Whats in this vaddr segment 0xffffe000-0xfffff000 ---p ?
thread-index: AcWO1ibdeZlpWvW2T0yiIwAaJYbiEA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "vamsi krishna" <vamsi.krishnak@gmail.com>
Cc: "Bhanu Kalyan Chetlapalli" <chbhanukalyan@gmail.com>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Jul 2005, vamsi krishna wrote:

> Hello,
>
>>
>> The location of the vsyscall page is different on 32 and 64 bit
>> machines. So 0xffffe000 is NOT the address you are looking for while
>> dealing with the 64 bit machine.  Rather 0xffffffffff600000 is the
>> correct location (on x86-64).
>>
> Both my process's are 32-bit process's, its just one runs on 64-bit
> machine and other runs on 32-bit machine. The write from address
> 0xffffe0000 to a file on a 32-bit machine fails, but does'nt fail on
> 64-bit machine (the process is still 32-bit although it runs on
> 64-bit).
>
> How can the virtual address of   0xffffffffff600000 exist in a 32-bit
> process ? (May be I have not made myself clear in explaining the
> problem?? :-?)
>
> Best,
> Vamsi.

It doesn't. The 32-bit machines never show 64 bit words in
/proc/NN/maps. They don't "know" how.

b7fd6000-b7fd7000 rw-p b7fd6000 00:00 0
b7ff5000-b7ff6000 rw-p b7ff5000 00:00 0
bffe1000-bfff6000 rw-p bffe1000 00:00 0          [stack]
ffffe000-fffff000 ---p 00000000 00:00 0          [vdso]
^^^^^^^^____________ 32 bits


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
