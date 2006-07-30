Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWG3HPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWG3HPg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 03:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWG3HPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 03:15:36 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:9768 "EHLO
	asav09.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1751230AbWG3HPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 03:15:35 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HALX2y0SBUw
From: Dmitry Torokhov <dtor@insightbb.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [git pull] Input update for 2.6.18-rc2
Date: Sun, 30 Jul 2006 03:15:32 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200607270154.01859.dtor@insightbb.com>
In-Reply-To: <200607270154.01859.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607300315.32927.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 July 2006 01:54, Dmitry Torokhov wrote:
> Linus,
> 
> Please pull from:
> 
>         git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
> 
> or
>         master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus
> 
> It has bunch of cleanups and bugfixes discovered by Coverity, wistron
> section mismatch fix, IBM trackpoint resume fix, etc.
> 

Any chance it can be pulled for -rc3? 

> Changelog:
> 
> Andrew Morton:
>       Input: wistron - fix section reference mismatches
>       Input: fix list iteration in input_release_device()
> 
> Dmitry Torokhov:
>       Input: remove accept method from input_dev
>       Input: add start() method to input handlers
>       Input: introduce input_inject_event() function
>       Input: fm801-gp - fix use after free
>       Input: libps2 - warn instead of oopsing when passed bad arguments
>       Input: iforce - check array bounds before accessing elements
>       Input: HID - fix potential out-of-bound array access
>       Input: add missing handler->start() call
>       Input: hiddev - use standard list implementation
>       Input: keyboard - remove static variable and clean up initialization
>       Input: keyboard - simplify emulate_raw() implementation
>       Input: keyboard - change to use kzalloc
>       Input: trackpoint - activate protocol when resuming
>       Input: ati_remote - relax permissions on sysfs module parameters
>       Input: ati_remote - add missing input_sync()
>       Input: ati_remote - use msec instead of jiffies
> 
> Edwin Huffstutler:
>       Input: ati_remote - make filter time a module parameter
> 
> Marko Macek:
>       Input: ati_remote - increase timeout, use msecs instead of jiffies
> 
> Nick Martin:
>       Input: spaceball - make 4000FLX Lefty work
> 
> Przemek Iskra:
>       Input: iforce - add Trust Force Feedback Race Master support
> 
> Randy Dunlap:
>       Input: serio/gameport - check whether driver core calls succeeded
> 
> Roberto Castagnola:
>       Input: logips2pp - fix button mapping for MX300
> 
> Diffstat:
> 
>  b/drivers/char/keyboard.c                     |    4 
>  b/drivers/input/evdev.c                       |    6 -
>  b/drivers/input/gameport/fm801-gp.c           |    4 
>  b/drivers/input/gameport/gameport.c           |   66 ++++++++---
>  b/drivers/input/input.c                       |    5 
>  b/drivers/input/joystick/iforce/iforce-main.c |    1 
>  b/drivers/input/joystick/spaceball.c          |    2 
>  b/drivers/input/misc/wistron_btns.c           |   20 +--
>  b/drivers/input/mouse/logips2pp.c             |    3 
>  b/drivers/input/mouse/trackpoint.c            |   52 ++++++---
>  b/drivers/input/serio/libps2.c                |    5 
>  b/drivers/input/serio/serio.c                 |   65 +++++++++--
>  b/drivers/usb/input/ati_remote.c              |  134 +++++++++++++-----------
>  b/drivers/usb/input/hid-input.c               |    3 
>  b/drivers/usb/input/hiddev.c                  |   72 ++++++------
>  b/include/linux/input.h                       |    1 
>  drivers/char/keyboard.c                       |  145 ++++++++++++++------------
>  drivers/input/evdev.c                         |    4 
>  drivers/input/input.c                         |   56 +++++++---
>  drivers/input/joystick/iforce/iforce-main.c   |   18 +--
>  drivers/usb/input/ati_remote.c                |   46 ++++----
>  include/linux/input.h                         |   23 +++-
>  22 files changed, 458 insertions(+), 277 deletions(-)
> 

-- 
Dmitry
