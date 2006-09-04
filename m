Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWIDLuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWIDLuk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 07:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWIDLuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 07:50:40 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48791 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964814AbWIDLuj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 07:50:39 -0400
Subject: Re: [RFC: 2.6 patch] build sound/sound_firmware.c only for OSS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060904114135.GO4416@stusta.de>
References: <20060904114135.GO4416@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Sep 2006 13:11:04 +0100
Message-Id: <1157371864.30801.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-04 am 13:41 +0200, ysgrifennodd Adrian Bunk:
> All sound/sound_firmware.c contains is mod_firmware_load() that is a 
> legacy API only used by some OSS drivers.
> 
> This patch builds it into an own sound_firmware module that is only 
> built depending on CONFIG_SOUND_PRIME making the kernel slightly smaller 
> for ALSA users.

Reminds me - might as well fix this too

Signed-off-by: Alan Cox <alan@redhat.com>

--- sound/sound_firmware.c~	2006-09-04 12:33:08.805282488 +0100
+++ sound/sound_firmware.c	2006-09-04 12:33:08.817280664 +0100
@@ -59,8 +59,7 @@
  *	value zero on a failure.
  *
  *	Caution: This API is not recommended. Firmware should be loaded via
- *	an ioctl call and a setup application. This function may disappear
- *	in future.
+ *	request_firmware.
  */
  
 int mod_firmware_load(const char *fn, char **fp)


-- 
VGER BF report: H 2.96182e-15
