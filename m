Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbRFGPOk>; Thu, 7 Jun 2001 11:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261386AbRFGPOa>; Thu, 7 Jun 2001 11:14:30 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:22255 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S261347AbRFGPOO>;
	Thu, 7 Jun 2001 11:14:14 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alan Olsen <alan@clueserver.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: es1371 compile issue in 2.4.5-ac9 
In-Reply-To: Your message of "Wed, 06 Jun 2001 14:45:10 MST."
             <Pine.LNX.4.10.10106061440280.20236-200000@clueserver.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Jun 2001 01:14:44 +1000
Message-ID: <3333.991926884@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001 14:45:10 -0700 (PDT), 
Alan Olsen <alan@clueserver.org> wrote:
>I rebuilt from clean source and patch for 2.4.5-ac9 and neglected to add
>in anything using the joystick.
>
>ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext ...
>	-o vmlinux
>drivers/sound/sounddrivers.o: In function `es1371_probe':
>drivers/sound/sounddrivers.o(.text+0x5e5d): undefined reference to
>`gameport_register_port'

Your attached .config (why was it in base64?) has
  # CONFIG_SOUND is not set
which is completely incompatible with the above error.  Either you
manually overrode the compile or you enclosed the wrong .config.

