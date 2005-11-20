Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVKTIiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVKTIiI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 03:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVKTIiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 03:38:08 -0500
Received: from styx.suse.cz ([82.119.242.94]:60886 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751135AbVKTIiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 03:38:07 -0500
Date: Sun, 20 Nov 2005 09:37:55 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [git pull 00/14] Input updates for 2.6.15
Message-ID: <20051120083755.GA26704@midnight.ucw.cz>
References: <20051120063611.269343000.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051120063611.269343000.dtor_core@ameritech.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2005 at 01:36:11AM -0500, Dmitry Torokhov wrote:

> Hi Linus,
> 
> Please consider pulling from:
> 
> 	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git
> 
> It corrects couple of problems caused by recein input dynalloc
> conversion, converts uinput driver to dynamic allocation and
> adds new wistron button driver which was siting in -mm for quite
> a while.
> 
> Vojtech, please bless the pull.

Yup, I have no objections at all. Thanks, Dmitry!

Linus, please pull these changes into your tree.

> Changelog:
> 
>  Fix missing initialization in ir-kbd-gpio.c
>  Fix an OOPS when initializing IR remote on saa7134
>  Input: make serio and gameport more swsusp friendly
>  Input: handle failures in input_register_device()
>  Input: uinput - don't use "interruptible" in FF code
>  Input: uinput - add UI_SET_SWBIT ioctl
>  Input: uinput - convert to dynalloc allocation
>  Input: wistron - disable wifi/bluetooth on suspend
>  Input: wistron - add PM support
>  Input: wistron - convert to dynamic input_dev allocation
>  Input: wistron - add support for Acer Aspire 1500 notebooks
>  Input: wistron - disable for x86_64
>  Input: add Wistron driver
>  Input: atkbd - speed up setting leds/repeat state
> 
> Diffstat:
> 
>  MAINTAINERS                                 |    5 
>  drivers/input/gameport/gameport.c           |   12 
>  drivers/input/input.c                       |   63 +--
>  drivers/input/keyboard/atkbd.c              |   99 +++-
>  drivers/input/misc/Kconfig                  |   10 
>  drivers/input/misc/Makefile                 |    1 
>  drivers/input/misc/uinput.c                 |  323 ++++++++--------
>  drivers/input/misc/wistron_btns.c           |  561 ++++++++++++++++++++++++++++
>  drivers/input/serio/serio.c                 |   12 
>  drivers/media/video/ir-kbd-gpio.c           |    5 
>  drivers/media/video/saa7134/saa7134-input.c |    2 
>  include/linux/uinput.h                      |   13 
>  12 files changed, 880 insertions(+), 226 deletions(-)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
