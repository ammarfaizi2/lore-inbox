Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265883AbTF3Uw0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 16:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265884AbTF3Uw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 16:52:26 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:24595 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S265883AbTF3UwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 16:52:24 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: gilson r <gilsonr@highstream.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.5.72 doesn't load up
Date: Mon, 30 Jun 2003 23:05:43 +0200
User-Agent: KMail/1.5.2
References: <200306301655.06221.gilsonr@highstream.net>
In-Reply-To: <200306301655.06221.gilsonr@highstream.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306302301.42046.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 June 2003 22:55, gilson r wrote:

Hi Gilson,

> Just as when I tried 2.5.64, I get now the same result with 2.5.72.
Consider using .73 :)

> When I reboot with the new kernel, I get:
>    "Booting 'Linux-2.5.72'
>    kernel (hd1,14)/vmlinuz-2.5.72 ro root=/dev/hdb2 hdc=ide-scsi
>  [Linux - bzImage, setup=0x1400, size=0xdd72f]
>    initrd (hd1,14)/initrd-2.5.72.img
>  [Linux - initrd @ 0xf7cb000, 0x14d14 bytes]
>  Uncompressing Linux... Ok, booting the kernel."
> And it hangs there, whether I compile with Mandrake-9.1 or RedHat-8.
> I'd love to learn what I'm doing wrong.
Well, does it _really_ hang or are you able to ping that machine from another 
machine? Your error looks like the 8435989 times discussed misconfiguration 
;)

CONFIG_INPUT=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y

Make sure you have the above set in your .config

Or, to speak in menuconfig language:

Input device support ->
 [*] Input devices (needed for keyboard, mouse, ...)
Character devices ->
 [*] Virtual terminal
    [*] Support for console on virtual terminal


ciao, Marc

