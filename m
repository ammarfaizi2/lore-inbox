Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbWDYBaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWDYBaz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 21:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWDYBay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 21:30:54 -0400
Received: from spirit.analogic.com ([204.178.40.4]:19469 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751508AbWDYBay convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 21:30:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20060425001617.0a536488@werewolf.auna.net>
X-OriginalArrivalTime: 25 Apr 2006 01:30:52.0657 (UTC) FILETIME=[E40A2E10:01C66807]
Content-class: urn:content-classes:message
Subject: Re: C++ pushback
Date: Mon, 24 Apr 2006 21:30:52 -0400
Message-ID: <Pine.LNX.4.61.0604242107310.25554@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: C++ pushback
thread-index: AcZoB+QWnKXyJEdASKWrcm9F+zc7vw==
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com><mj+md-20060424.201044.18351.atrey@ucw.cz><444D44F2.8090300@wolfmountaingroup.com><1145915533.1635.60.camel@localhost.localdomain> <20060425001617.0a536488@werewolf.auna.net>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Apr 2006, J.A. Magallon wrote:

> On Mon, 24 Apr 2006 22:52:12 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
>> On Llu, 2006-04-24 at 15:36 -0600, Jeff V. Merkey wrote:
>>> C++ in the kernel is a BAD IDEA. C++ code can be written in such a
>>> convoluted manner as to be unmaintainable and unreadable.
>>
>> So can C.
>>
>>> All of the hidden memory allocations from constructor/destructor
>>> operatings can and do KILL OS PERFORMANCE.
>>
>> This is one area of concern. Just as big a problem for the OS case is
>> that the hidden constructors/destructors may fail.
>
> Tell me what is the difference between:
>
>
>    sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
>    if (!sbi)
>        return -ENOMEM;
>    sb->s_fs_info = sbi;
>    memset(sbi, 0, sizeof(*sbi));
>    sbi->s_mount_opt = 0;
>    sbi->s_resuid = EXT3_DEF_RESUID;
>    sbi->s_resgid = EXT3_DEF_RESGID;
>
> and
>
>    SuperBlock() : s_mount_opt(0), s_resuid(EXT3_DEF_RESUID), s_resgid(EXT3_DEF_RESGID)
>    {}
>
>    ...
>    sbi = new SuperBlock;
>    if (!sbi)
>        return -ENOMEM;
>
> apart that you don't get members initalized twice and get a shorter code :).
>
> --
> J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
> werewolf!able!es                         \         It's better when it's free
> Mandriva Linux release 2006.1 (Cooker) for i586
> Linux 2.6.16-jam9 (gcc 4.1.1 20060330 (prerelease)) #1 SMP PREEMPT Tue
>

I'd like to write modules in FORTRAN, myself. Unless you have been
writing software since computers were programmed with diode-pins, one
tends to think that the first programming language learned is the
best. It's generally because they are all bad, and once you learn how
to make the defective language do what you want, you tend to identify
with it. Identifying with one's captors, the Stockholm syndrome,
that's what these languages cause.

But, a master carpenter has many tools. He chooses the best for each
task. When you need to make computer hardware do what you want, in
a defined manner, in the particular order in which you require,
you use assembly language to generate the exact machine-code required.
It is possible to compromise a bit and use a slightly higher-level
procedural language called C. One loses control of everything with
any other language. Note that before C was invented, all operating
system code was written in assembly.

C++ wasn't written for this kind of work. It was written so that a
programmer didn't have to care how something was done only that somehow
it would get done. Also, as you peel away the onion skins from many
C++ graphics libraries, you find inside the core that does the work.
It's usually written in C.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
