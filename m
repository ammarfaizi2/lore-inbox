Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273176AbRJNBeL>; Sat, 13 Oct 2001 21:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273255AbRJNBeC>; Sat, 13 Oct 2001 21:34:02 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:12471
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S273204AbRJNBdx>; Sat, 13 Oct 2001 21:33:53 -0400
Date: Sat, 13 Oct 2001 18:34:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.12-ac1
Message-ID: <20011013183421.G15110@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011012141726.A27516@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011012141726.A27516@lightning.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 02:17:26PM +0100, Alan Cox wrote:

> 2.4.12-ac1

This still won't compile drivers/char/pc_keyb.c on most arches.  The
following fixes that.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

--- linux-2.4.10-ac11.orig/drivers/char/pc_keyb.c	Wed Oct 10 19:10:27 2001
+++ linux-2.4.10-ac11/drivers/char/pc_keyb.c	Wed Oct 10 19:35:15 2001
@@ -34,6 +34,7 @@
 #include <linux/vt_kern.h>
 #include <linux/smp_lock.h>
 #include <linux/kd.h>
+#include <linux/pm.h>
 
 #include <asm/keyboard.h>
 #include <asm/bitops.h>
