Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129834AbQLJIqP>; Sun, 10 Dec 2000 03:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129884AbQLJIqG>; Sun, 10 Dec 2000 03:46:06 -0500
Received: from smtp.lax.megapath.net ([216.34.237.2]:29707 "EHLO
	smtp.lax.megapath.net") by vger.kernel.org with ESMTP
	id <S129834AbQLJIps>; Sun, 10 Dec 2000 03:45:48 -0500
Message-ID: <3A333B34.114A488B@megapathdsl.net>
Date: Sun, 10 Dec 2000 00:13:40 -0800
From: Miles Lane <miles@megapathdsl.net>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Bug in config scripts? Some FB console options not cleared when 
 container options disabled.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If I set these options using "make menuconfig":

CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

And, I then unset CONFIG_FBCON_ADVANCED and CONFIG_FBCON_FONTS
(the options that cause the CFB options and the FONT options
to become accessible), I am left with these options:

CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

Perhaps this is not a big deal and the orphaned options are usused.
I guess I would expect the orphaned options to simply not appear,
as the unselected options in the same subsections are not written
out.

        Miles
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
