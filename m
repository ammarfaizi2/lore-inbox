Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbVIVUMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbVIVUMR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbVIVUMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:12:17 -0400
Received: from spirit.analogic.com ([204.178.40.4]:41488 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1030323AbVIVUMQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:12:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050922194433.13200.qmail@webmail2.locasite.com.br>
References: <20050922194433.13200.qmail@webmail2.locasite.com.br>
X-OriginalArrivalTime: 22 Sep 2005 20:12:14.0978 (UTC) FILETIME=[EC9D5E20:01C5BFB1]
Content-class: urn:content-classes:message
Subject: Re: security patch 
Date: Thu, 22 Sep 2005 16:12:14 -0400
Message-ID: <Pine.LNX.4.61.0509221557400.13302@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: security patch 
Thread-Index: AcW/seyk0CyfZ/QiTTeQEICHnYfiCQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: <breno@kalangolinux.org>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Sep 2005 breno@kalangolinux.org wrote:

> Hi people,
>
> I'm doing a new feature for linux kernel 2.6 to protect against all kinds of buffer
> overflow. It works with new sys_control() system call controling if a process can or can't
> call a system call ie. sys_execve();
>

Are you aware that there are very few 'built-in' commands in
any of the shells?  If a user can't execute anything, the
user can't do anything.

If you think that this will protect against improperly-written
daemons, and things that never exec anything, you are wrong.
The place to fix bad code is in the code.

> You can do it using /bin/sys_control <pid> <enable or not system call>
> <eax of system call> <secret number>


This is a joke, right?


> for process that never call for example sys_execve(), setuid()
> ( you must need specify each eax for each system call) and use
> some functions in sys_control.h like lock_execve(n)
> and unlock_execve(n), where n is a secret number defined in sysctl.
> With this functions you will use system calls only when you need.
> All shellcodes that use system calls like sys_execve() sys_setuid()
> will not work with this feature.

What will they do? I try to execute `ls`, the kernel says I can't
fork and exec `/bin/ls`. So, do I get killed, logged out? The
shells handle errors in different ways. There is a big difference
between how bash handles ENOENT (No such file or directory) and
ENOSYS (Function not implimented).

>
> I think it can be an option in linux kernel.
>
> Questions .. suggestions.
>
> Thanks
>

I think this is just another ruse to attempt to get the system
call table exported, something you don't need to do in order
to replace any of its elements. Am I guessing correctly?

> Breno at kalangolinux.org
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
