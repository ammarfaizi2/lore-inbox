Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVGIUrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVGIUrn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 16:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVGIUrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 16:47:43 -0400
Received: from vsmtp1alice.tin.it ([212.216.176.144]:5518 "EHLO
	vsmtp1alice.tin.it") by vger.kernel.org with ESMTP id S261724AbVGIUrn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 16:47:43 -0400
Message-ID: <42D03731.9060809@inwind.it>
Date: Sat, 09 Jul 2005 22:44:33 +0200
From: federico <xaero@inwind.it>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050515)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ability to change SysRq scancode
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020400060908060204020705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020400060908060204020705
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

i release this patch because my keyboard ("Mitsumi Electric Apple
Extended USB Keyboard" Bus=0003 Vendor=05ac Product=0205 Version=0122)
doesn't have a PrintScr key, so cannot send the right scancode, and
KEY_SYSRQ needs to be modified.

i hope that i've done in the right way ;)
it's tested by me, and it's working, yeah i'm pressing the SAK with F13 :P


--------------020400060908060204020705
Content-Type: text/x-patch;
 name="sysrq_scancode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysrq_scancode.patch"

diff linux.orig/lib/Kconfig.debug linux/lib/Kconfig.debug
30a31,40
> 	  
> config MAGIC_SYSRQ_SCANCODE
> 	int
> 	prompt "Change default scancode of SysRq key" if MAGIC_SYSRQ
> 	default 99
> 	depends on MAGIC_SYSRQ
> 	help
> 	  If your keyboard hasn't a SysRq key, you can specify another key
> 	  which should act as SysRq. You can find the scancode on your
> 	  keyboard with programs like showkey or evtest.

diff linux.orig/include/linux/input.h linux/include/linux/input.h
206a207,210
> 
> #if defined(CONFIG_MAGIC_SYSRQ) && defined(CONFIG_MAGIC_SYSRQ_SCANCODE)
> #define KEY_SYSRQ		CONFIG_MAGIC_SYSRQ_SCANCODE
> #else
207a212,213
> #endif
>

--------------020400060908060204020705--
