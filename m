Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbUKKLEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbUKKLEs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 06:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbUKKLEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 06:04:48 -0500
Received: from smtp.loomes.de ([212.40.161.2]:21143 "EHLO falcon.loomes.de")
	by vger.kernel.org with ESMTP id S262200AbUKKLEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 06:04:34 -0500
Subject: Re: 2.6.10-rc1-mm5
From: Markus Trippelsdorf <markus@trippelsdorf.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041111012333.1b529478.akpm@osdl.org>
References: <20041111012333.1b529478.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 11 Nov 2004 12:04:29 +0100
Message-Id: <1100171069.1452.8.camel@lb.loomes.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-11 at 01:23 -0800, Andrew Morton wrote:

> +fbdev-add-vram-option-to-intelfb.patch
> +fbdev-fix-for-using-16-pixel-wide-font-in-fb-console.patch
> +fbdev-support-for-bigger-than-16x32-fonts-in-softcursor.patch
> +fbdev-support-for-bigger-than-16x32-fonts-in-rivafb-cursor.patch
> +fbcon-disable-fbcon-cursor-if-vt-softcursor-is-enabled.patch
> +fbdev-allow-mode-change-even-if-edid-block-is-not-found.patch
> +fbdev-fix-cursor-in-doublescan-mode-in-atyfb.patch
> +fbdev-fix-typo-in-atyfb.patch
> +fbdev-change-the-find_mode-behavior.patch
> 
>  fbdev updates
> 

The kernel does not link an AMD64:
  LD      vmlinux
drivers/built-in.o(.text+0x7f53): In function `fbcon_set_font':
: undefined reference to `crc32_le'

This is the code snipped from drivers/video/console/fbcon.c (line 2303):

 /* Since linux has a nice crc32 function use it for counting font
         * checksums. */
        csum = crc32(0, new_data, size);

After switching on CONFIG_CRC32, the kernel is linked correctly.
__ 
Markus

