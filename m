Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312779AbSCVSMj>; Fri, 22 Mar 2002 13:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312783AbSCVSMS>; Fri, 22 Mar 2002 13:12:18 -0500
Received: from adsl-63-203-200-210.dsl.snfc21.pacbell.net ([63.203.200.210]:44229
	"EHLO hodog.wesecurethe.net") by vger.kernel.org with ESMTP
	id <S312779AbSCVSMG>; Fri, 22 Mar 2002 13:12:06 -0500
From: Change Ling <change@wesecurethe.net>
To: linux-kernel@vger.kernel.org
Subject: vesafb not working in later 2.4.x kernels?
Message-ID: <1016820299.3c9b724bd3515@www.wesecurethe.net>
Date: Fri, 22 Mar 2002 10:04:59 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.7
X-HoozYoDaddy: I AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying to build the vesafb under the 2.4.18 kernel for use in my 
work on the biatchux bootable cdrom distribution, but the frame buffer never 
seems to initialize at boot with the vga=791 kernel argument.

It is as though the Video select option isn't handling the kernel arg, since 
vga=ask doesn't present my with a selection menu either.

Has vesafb or Video_select support somehow been dropped in the latest stable 
kernel???

I have built the kernel on multiple machines with the following .config, and 
have resorted to downgrading my kernel by systematically decrementing versions, 
I've gone back as far as 2.4.14 so far, with no luck in initializing the vesafb.

I have the vesafb working under 2.4.5, but really would like to avoid going 
that far back.

Following is the FB specific portion of my .config

# Console drivers
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# Frame-buffer support
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

