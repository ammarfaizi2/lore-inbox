Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWDBF42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWDBF42 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 00:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWDBF42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 00:56:28 -0500
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:15459 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751123AbWDBF41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 00:56:27 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [git pull] Input update for 2.6.17
Date: Sun, 2 Apr 2006 00:56:24 -0500
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604020056.25245.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git

to receive various updates to the input layer.

Diffstat:

 Documentation/input/joystick-parport.txt    |   11 
 arch/alpha/kernel/setup.c                   |   18 +
 arch/i386/kernel/setup.c                    |   18 +
 arch/mips/Kconfig                           |    6 
 arch/mips/kernel/Makefile                   |    2 
 arch/mips/kernel/i8253.c                    |   28 +
 arch/powerpc/kernel/setup-common.c          |   24 +
 drivers/Makefile                            |    4 
 drivers/char/keyboard.c                     |  118 ++++++-
 drivers/input/evbug.c                       |    3 
 drivers/input/evdev.c                       |    6 
 drivers/input/gameport/gameport.c           |   30 +
 drivers/input/gameport/ns558.c              |   13 
 drivers/input/input.c                       |  436 +++++++++++++++++-----------
 drivers/input/joydev.c                      |    6 
 drivers/input/joystick/amijoy.c             |   11 
 drivers/input/joystick/db9.c                |   13 
 drivers/input/joystick/gamecon.c            |   96 ++++--
 drivers/input/joystick/iforce/iforce-ff.c   |   24 -
 drivers/input/joystick/iforce/iforce-main.c |    2 
 drivers/input/joystick/iforce/iforce.h      |    5 
 drivers/input/joystick/turbografx.c         |   13 
 drivers/input/keyboard/Kconfig              |    2 
 drivers/input/keyboard/atkbd.c              |   24 -
 drivers/input/keyboard/corgikbd.c           |   35 +-
 drivers/input/keyboard/hil_kbd.c            |    9 
 drivers/input/keyboard/spitzkbd.c           |   10 
 drivers/input/misc/pcspkr.c                 |   27 -
 drivers/input/misc/uinput.c                 |   14 
 drivers/input/mouse/hil_ptr.c               |    7 
 drivers/input/mouse/psmouse-base.c          |   38 +-
 drivers/input/mouse/synaptics.c             |   18 -
 drivers/input/mousedev.c                    |    6 
 drivers/input/power.c                       |    3 
 drivers/input/serio/hil_mlc.c               |    3 
 drivers/input/serio/i8042-x86ia64io.h       |   26 +
 drivers/input/serio/libps2.c                |   10 
 drivers/input/serio/parkbd.c                |    3 
 drivers/input/serio/rpckbd.c                |    3 
 drivers/input/serio/serio.c                 |   48 +--
 drivers/input/serio/serio_raw.c             |   29 -
 drivers/input/tsdev.c                       |    6 
 drivers/usb/input/hid-input.c               |    2 
 include/linux/gameport.h                    |    7 
 include/linux/input.h                       |   25 +
 include/linux/kbd_kern.h                    |    2 
 include/linux/keyboard.h                    |   13 
 include/linux/libps2.h                      |    2 
 include/linux/serio.h                       |    9 
 include/linux/uinput.h                      |    4 
 50 files changed, 821 insertions(+), 451 deletions(-)

Changelog:

Adrian Bunk:
      Input: serio - fix memory leak
      Input: gameport - fix memory leak

Arjan van de Ven:
      Input: serio - semaphore to mutex conversion
      Input: gameport - semaphore to mutex conversion

Bjorn Helgaas:
      Input: ns558 - fix logic around pnp_register_driver()
      Input: i8042 - fix logic around pnp_register_driver()

Dmitry Torokhov:
      Input: uinput - semaphore to mutex conversion
      Input: initialize serio and gameport at subsystem level
      Input: fix input_free_device() implementation
      Input: atkbd - allow disabling on X86_PC (if EMBEDDED)
      Input: limit attributes' output to PAGE_SIZE
      Input: convert /proc handling to seq_file
      Input: make modalias code respect allowed buffer size

Eric Sesterhenn:
      Input: use kzalloc() throughout the code

Ingo Molnar:
      Input: psmouse - semaphore to mutex conversion
      Input: atkbd - semaphore to mutex conversion
      Input: joysticks - semaphore to mutex conversion

Jes Sorensen:
      Input: input core - semaphore to mutex conversion

Micah F. Galizia:
      Input: HID - fix duplicate key mapping for Logitech UltraX remote

Michael Neuling:
      Input: pcspkr - separate device and driver registration

Raphael Assenat:
      Input: gamecon - add SNES mouse support

Richard Purdie:
      Input: zaurus keyboard driver updates

Richard Thrippleton:
      Input: synaptics - limit rate to 40pps on Toshiba Protege M300

Samuel Thibault:
      Input: add support for Braille devices

Vojtech Pavlik:
      Input: atkbd - fix complaints about 'releasing unknown key 0x7f'
      Input: atkbd - disable softrepeat for dumb keyboards
 
-- 
Dmitry
