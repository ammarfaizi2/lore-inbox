Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277804AbRJIQEa>; Tue, 9 Oct 2001 12:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277805AbRJIQEW>; Tue, 9 Oct 2001 12:04:22 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:5393 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S277804AbRJIQER>;
	Tue, 9 Oct 2001 12:04:17 -0400
Date: Tue, 9 Oct 2001 18:04:42 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Sonypi driver?
Message-ID: <20011009180442.P15740@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20011009081431.B30846@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011009081431.B30846@cpe-24-221-152-185.az.sprintbbd.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 08:14:31AM -0700, Tom Rini wrote:

> Hello.  This driver is for some x86-only HW, yes?  If so could you
> please change drivers/char/Config.in to only ask about it if
> "$CONFIG_EXPERIMENTAL" = "y" -a "$CONFIG_X86" = "y" ?  Thanks.

Tom is right, patch attached (against 2.4.10-ac10 or 2.4.11-pre6).

Alan, Linus, please apply.

Stelian.

--- linux-2.4.10-ac10.orig/drivers/char/Config.in	Tue Oct  9 11:13:23 2001
+++ linux-2.4.10-ac10/drivers/char/Config.in	Tue Oct  9 17:49:55 2001
@@ -192,7 +192,7 @@
 tristate 'Double Talk PC internal speech card support' CONFIG_DTLK
 tristate 'Siemens R3964 line discipline' CONFIG_R3964
 tristate 'Applicom intelligent fieldbus card support' CONFIG_APPLICOM
-if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+if [ "$CONFIG_EXPERIMENTAL" = "y" -a "$CONFIG_X86" = "y" ]; then
    dep_tristate 'Sony Vaio Programmable I/O Control Device support' CONFIG_SONYPI $CONFIG_PCI
 fi
 
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
