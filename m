Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310637AbSDAUuB>; Mon, 1 Apr 2002 15:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311615AbSDAUtw>; Mon, 1 Apr 2002 15:49:52 -0500
Received: from air-2.osdl.org ([65.201.151.6]:40453 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S310637AbSDAUte>;
	Mon, 1 Apr 2002 15:49:34 -0500
Date: Mon, 1 Apr 2002 12:47:29 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][RFC] Linux/i386 boot protocol version 2.04
In-Reply-To: <m1d6xmuipv.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33L2.0204011236060.13412-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Mar 2002, Eric W. Biederman wrote:

| I have been doing some very weird things with booting the Linux kernel
| for a long time.

so you are saying that we want these 'weird' things in the
baseline kernel?  ;)

Will you please provide a one-sentence explanation for each of
these items?  (not "what," but "why" it's good to have it)

|   - Entering the kernel in 32bit mode to avoid 16bit BIOS calls.
|   - Converting bzImage into static ELF executables.
|   - Hard coding a kernel command-line
|   - Going back to 16bit mode to make BIOS calls if necessary.
|
| This version of the boot protocol should be fully backwards compatible
| but has new capabilities so I can do all of the above cleanly.
|
| The current plan is to send this to Linus in the next couple of days
| as soon as he gets back.
|
...
|
| Anyway please tell me what you think.
|
| Eric
|
|
| This is a log of a series of patches that cleans up and enhances the
| x86 boot process.

[snippage]

| 2.5.7.boot.proto 7
| ============================================================
| Update the boot protocol to include:
|    - A compiled in command line

when and how is the command line specified?  at build time?

maybe in a kernel.command.line file so that I don't have to type
it in every time?

|
| 2.5.7.boot.boot_params 1
| ============================================================
| - Introduce asm-i386/boot_param.h and struct boot_params
| - Implement struct boot_params in misc.c & setup.c

Yep, I like that one.

| This removes a lot of magic macros and by keeping all of the
| boot parameters in a structure it becomes much easier to track
| which boot_paramters we have and where they live.  Additionally
| this keeps the names more uniform making grepping easier.

I'll try to look over the patch files too.

-- 
~Randy

