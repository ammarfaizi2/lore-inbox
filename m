Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265041AbUHQK52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265041AbUHQK52 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 06:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbUHQK52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 06:57:28 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:54226 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S265041AbUHQK51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 06:57:27 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Shaun Jackman <sjackman@telus.net>
Date: Tue, 17 Aug 2004 12:57:11 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Hang after "BIOS data check successful" with DVI
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <E82D6B0981@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Aug 04 at 16:55, Shaun Jackman wrote:
> When I have a DVI display plugged into my Matrox G550 video card the
> boot process hangs at "BIOS data check successful". I am running Linux
> kernel 2.6.6. This problem does not affect Linux kernel 2.4.26. If I
> boot without the DVI display plugged in, I can plug it in after the
> boot process and the display works.

Try disabling CONFIG_VIDEO_SELECT and/or comment out call to store_edid
in arch/i386/boot/video.S. Also which bootloader you use? From
quick glance at bootloaders, grub1 seems to set %sp to 0x9000, while 
LILO to 0x0800. And I think that 2048 byte stack (plus something already 
allocated by loader) might be too small for DDC call, as MGA BIOS first
creates EDID copy on stack...
                                           Best regards,
                                                Petr Vandrovec
                                                

