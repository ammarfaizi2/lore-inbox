Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319662AbSH3UNX>; Fri, 30 Aug 2002 16:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319663AbSH3UNX>; Fri, 30 Aug 2002 16:13:23 -0400
Received: from chaos.analogic.com ([204.178.40.224]:30848 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S319662AbSH3UNX>; Fri, 30 Aug 2002 16:13:23 -0400
Date: Fri, 30 Aug 2002 16:18:26 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Stefano Biella <sbiella@hal9001.net>
cc: Dan Egli <dan@shortcircuit.dyndns.org>, linux-kernel@vger.kernel.org
Subject: Re: kernel panic: no init found with 2.5.32
In-Reply-To: <3D6FCCAC.E00585A5@hal9001.net>
Message-ID: <Pine.LNX.3.95.1020830161536.13754A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2002, Stefano Biella wrote:

> Dan Egli wrote:
> > 
> > What are you passing as the init= arg? What is your boot manager? (Grub?
> > Lilo? 3rd Party?)
> 
> the boot manager is Lilo 22.2
> 
> my lilo.conf is:
> -----------------
> boot= /dev/hda
> image = /boot/vmlinuz
>   root = /dev/hda2
>   label = Linux
>   read-only
> -----------------
> 
> > no init means that when the kernel boot sequence tries to spawn off
> > /sbin/init, it cannot find the file.The fault could be any one of multiple.
> 
> I don't know why with 2.4.xx works fine and with 2.5.xx make a kernel
> panic...
> 

The driver for /dev/hda2 (IDE driver) may not have been compiled in
or not otherwise installed. This would make the root file-system
inaccessible so /sbin/init can't be found.

Check for other boot messages to verify this.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

