Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310201AbSCaAMx>; Sat, 30 Mar 2002 19:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293632AbSCaAMn>; Sat, 30 Mar 2002 19:12:43 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:64772 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S293596AbSCaAM2>;
	Sat, 30 Mar 2002 19:12:28 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Justin Piszcz <war@starband.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.18 [link error] 
In-Reply-To: Your message of "Sat, 30 Mar 2002 17:26:43 EST."
             <3CA63BA3.9E57BD52@starband.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 31 Mar 2002 10:12:17 +1000
Message-ID: <11595.1017533537@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Mar 2002 17:26:43 -0500, 
Justin Piszcz <war@starband.net> wrote:
>The .config is attached.
>/usr/src/linux/arch/i386/lib/lib.a \
>        --end-group \
>        -o vmlinux
>net/network.o(.text.lock+0x3a37): undefined reference to `local symbols
>in discarded section .text.exit'

Your .config is invalid for 2.4.18.  You did not run make *config
before building the kernel[1], the results are undefined.

[1] Guess why kbuild 2.5 checks if make *config has been run?

