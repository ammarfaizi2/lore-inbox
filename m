Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265574AbTFRWZl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 18:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265575AbTFRWZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 18:25:41 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:65468 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265574AbTFRWZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 18:25:39 -0400
Date: Wed, 18 Jun 2003 23:40:20 +0100
From: Dave Bentham <dave.bentham@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.21 crash
Message-Id: <20030618234020.18252c84.dave@telekon>
In-Reply-To: <200306162148.h5GLmXsN002578@telekon.davesnet>
References: <200306162148.h5GLmXsN002578@telekon.davesnet>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Regarding this issue I have been advised to setup a serial console to
capture the 'kernel panic' debug output. For the record, I can get the
panic from the BASH prompt _before_ starting X/WM just by mounting my
CDRW drive.

However, I think I need some advice on setting up the serial console. I
have attached another PC (WinXP with HyperTerminal) serially to my panic
Linux PC. Following the Remote Terminal HOWTO I have achieved some
success... but all I see on HyperTerminal is:

   LILO 22.3.2 boot:
   Loading Linux_2.4.21................
   BIOS data check successful

   Mandrake Linux release 9.0 (dolphin) for i586
   Kernel 2.4.21 on an i686 / ttyS0
   telekon.davesnet login:

It seems to start piping the stuff to ttyS0, but then gives up after
a few progress-dots: I'm missing the main kernel blurb (its all on the
attached monitor), and also the panic stuff appears only on the attached
monitor.

Excerpt of butchered lilo.conf

boot=/dev/hda
map=/boot/map
#vga=normal
default=Linux_2.4.21
keytable=/boot/uk.klt
prompt
nowarn
timeout=100
#message=/boot/message
#menu-scheme=wb:bw:wb:bw
ignore-table
# serial term bits
serial = 0,9600n8
image = /boot/vmlinuz-2.4.21
	root = /dev/hda3
	label = Linux_2.4.21
	read-only
#	vga=788
	append = "devfs=mount hdd=ide-scsi console=tty0 console=ttyS0,9600n8"


Any help gratefully recieved!

Thanks

Dave

On Mon, 16 Jun 2003 22:48:33 +0100
dave.bentham@ntlworld.com wrote:

> Hello
> 
> I upgraded my kernel on a Mandrake 9.0 base from 2.4.20 to the new
> 2.4.21 tonight - built from source patches as I always do; followed by
> reinstalling the NVidia drivers and ALSA.
> 
> But there seems to be a major failure when the computer just stops
> with no warning. Two scenarios that seem to repeat it include starting
> Loki's Heretic2 off, and mounting the CDRW drive via WindowMaker dock
> app. I cannot do anything when this happens; can't hotkey out of X,
> can't telnet to it from my other networked PC. I have to power down
> and back up.
> 
> It seems to be a few seconds after the trigger that the lock up
> occurs, and also it starts flashing the keyboard Caps Lock and Scroll
> Lock LEDs in step at about 1 Hz. I'm sure its trying to tell me
> something...
> 
> Thanks in advance
> 
> Dave
> 


-- 
A computer without Microsoft is like chocolate cake without mustard.

