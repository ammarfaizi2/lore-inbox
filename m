Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317230AbSGHWu5>; Mon, 8 Jul 2002 18:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317232AbSGHWu4>; Mon, 8 Jul 2002 18:50:56 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:63505 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317230AbSGHWuz>;
	Mon, 8 Jul 2002 18:50:55 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Patch for Menuconfig script 
In-reply-to: Your message of "Mon, 08 Jul 2002 08:14:12 MST."
             <20020708151412.GB695@opus.bloom.county> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Jul 2002 08:53:27 +1000
Message-ID: <21071.1026168807@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2002 08:14:12 -0700, 
Tom Rini <trini@kernel.crashing.org> wrote:
>On Sun, Jul 07, 2002 at 11:22:10PM +0100, Riley Williams wrote:
>> > This is just a patch to the Menuconfig script (can be easily adapted
>> > to the other ones) that allows you to configure the kernel without
>> > the requirement of bash (I tested it with ksh, in POSIX-only mode).  
>> > Feel free to flame me :P
>> 
>> Does it also work in the case where the current shell is csh or tcsh
>> (for example)?
>
>Er.. why wouldn't it?
>$ head -1 scripts/Menuconfig 
>#! /bin/sh

The #! line is irrelevant.  The script is invoked via

  $(CONFIG_SHELL) scripts/Menuconfig arch/$(ARCH)/config.in

Large chunks of kbuild assume that CONFIG_SHELL is bash.  Don't bother
trying to cleanup all the code that assumes bash, just
  make CONFIG_SHELL=/path/to/bash ...

