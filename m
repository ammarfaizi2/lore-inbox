Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbVKIRFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbVKIRFh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbVKIRFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:05:37 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:36358 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751459AbVKIRFg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:05:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <7d40d7190511090856x24fd68f5g@mail.gmail.com>
References: <7d40d7190511090749j3de0e473x@mail.gmail.com> <Pine.LNX.4.61.0511091110190.10303@chaos.analogic.com> <7d40d7190511090856x24fd68f5g@mail.gmail.com>
X-OriginalArrivalTime: 09 Nov 2005 17:05:34.0582 (UTC) FILETIME=[CC7C9160:01C5E54F]
Content-class: urn:content-classes:message
Subject: Re: Stopping Kernel Threads at module unload time
Date: Wed, 9 Nov 2005 12:05:29 -0500
Message-ID: <Pine.LNX.4.61.0511091158350.10894@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Stopping Kernel Threads at module unload time
Thread-Index: AcXlT8yWJddCOoxwQUWXtboBt0E5Rw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Aritz Bastida" <aritzbastida@gmail.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Nov 2005, Aritz Bastida wrote:

> Hello,
>
>> This is how the kernel thread is stopped.
>>
>>      if(info->pid)
>>      {
>>          (void)kill_proc(info->pid, SIGTERM, 1);
>>          wait_for_completion(&info->quit);
>>      }
>>
>
> I actually would prefer to do it with the new kernel thread API.
> So, to create the thread:   kthread_create
> bind it to a cpu:                  kthread_bind
> stop it:                                kthread_stop
>

Sure your original question was about how to properly stop
a kernel thread prior to module removal. This, I showed you.
Now you say you "prefer" to do it some other way. Good luck.
Unless your code runs exactly like the prototype that the
new macros were written for, you may have fix the macros.

> Now, if I call kthread_stop() in module unload time, does that code
> run in user process context just like system calls do? That is
> important, because if it cannot sleep, it would deadlock.
>

Not relevent. You have apparently made up your mind that you
need to do it "your" way. Fine.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
