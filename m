Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272078AbRHVSqi>; Wed, 22 Aug 2001 14:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272080AbRHVSq2>; Wed, 22 Aug 2001 14:46:28 -0400
Received: from sweetums.bluetronic.net ([24.162.254.3]:38075 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S272079AbRHVSqR>; Wed, 22 Aug 2001 14:46:17 -0400
Date: Wed, 22 Aug 2001 14:46:27 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Qlogic/FC firmware
In-Reply-To: <E15Za6U-0001ht-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.33.0108221431060.6389-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Alan Cox wrote:
>Read the source code. The driver never reloads the firmware on a running
>card. So if the sparc needed that it never worked anyway, and I don't follow
>your argument.

If the card wasn't setup by the BIOS (OBP in the Sparc case), then the driver
won't work.  And as late as 2.4.8, RELOAD_FIRMWARE was set to '1'.  Gee,
look what was changed in 2.4.9:

--- v2.4.8/linux/drivers/scsi/qlogicfc.c        Sun Aug 12 13:28:00 2001
+++ linux/drivers/scsi/qlogicfc.c       Sun Aug 12 10:51:41 2001
@@ -98,7 +98,7 @@
    isp2200's firmware.
 */

-#define RELOAD_FIRMWARE                1
+#define RELOAD_FIRMWARE                0

 #define USE_NVRAM_DEFAULTS      1

@@ -440,7 +440,7 @@
 #define MBOX_SEND_CHANGE_REQUEST        0x0070
 #define MBOX_PORT_LOGOUT                0x0071

-#include "qlogicfc_asm.c"
+//#include "qlogicfc_asm.c"

(I will note, that's not even a valid C construct. '//' is a C++ism.)

>Unlike you, I actually read the source

So, was that before or after you removed the firmware? (And who says I don't
read source code?  That's the first place I go to find out who fucked up
what.  I'm running 2.4.5 and below.  The only thing I have running 2.4.9 is
my laptop, and that was a certified nightmare.)

--Ricky


