Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268065AbUIPNnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268065AbUIPNnG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 09:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268060AbUIPNlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 09:41:44 -0400
Received: from styx.suse.cz ([82.119.242.94]:32131 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S268065AbUIPNit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 09:38:49 -0400
Date: Thu, 16 Sep 2004 15:39:00 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [bk pull request] Input update
Message-ID: <20040916133900.GA4455@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

Please do a pull from my BK tree:

	bk://kernel.bkbits.net/vojtech/input

It's all been well tested in -mm, fixes some serious bugs and I really
need to sync with you badly to do any further development.

Thanks, Vojtech.

Diffstat:
~~~~~~~~

 Documentation/input/joystick-parport.txt     |   13 
 Documentation/kernel-parameters.txt          |    6 
 MAINTAINERS                                  |   17 
 drivers/Makefile                             |    4 
 drivers/char/keyboard.c                      |   33 +
 drivers/input/gameport/emu10k1-gp.c          |    3 
 drivers/input/joydev.c                       |    6 
 drivers/input/joystick/Kconfig               |    2 
 drivers/input/joystick/gamecon.c             |  192 ++++-----
 drivers/input/joystick/iforce/iforce-main.c  |    4 
 drivers/input/joystick/iforce/iforce-serio.c |   18 
 drivers/input/joystick/iforce/iforce.h       |    2 
 drivers/input/joystick/magellan.c            |   24 -
 drivers/input/joystick/spaceball.c           |   24 -
 drivers/input/joystick/spaceorb.c            |   24 -
 drivers/input/joystick/stinger.c             |   24 -
 drivers/input/joystick/tmdc.c                |    2 
 drivers/input/joystick/twidjoy.c             |   20 
 drivers/input/joystick/warrior.c             |   24 -
 drivers/input/keyboard/atkbd.c               |  283 +++++++++----
 drivers/input/keyboard/lkkbd.c               |   24 -
 drivers/input/keyboard/newtonkbd.c           |   24 -
 drivers/input/keyboard/sunkbd.c              |   24 -
 drivers/input/keyboard/xtkbd.c               |   24 -
 drivers/input/misc/Kconfig                   |    2 
 drivers/input/misc/uinput.c                  |    3 
 drivers/input/mouse/Kconfig                  |    2 
 drivers/input/mouse/logips2pp.c              |    2 
 drivers/input/mouse/psmouse-base.c           |  310 +++++++++-----
 drivers/input/mouse/psmouse.h                |   40 +
 drivers/input/mouse/sermouse.c               |   24 -
 drivers/input/mouse/synaptics.c              |   54 +-
 drivers/input/mouse/vsxxxaa.c                |   24 -
 drivers/input/mousedev.c                     |  237 ++++++++---
 drivers/input/serio/Kconfig                  |   16 
 drivers/input/serio/Makefile                 |    1 
 drivers/input/serio/ambakmi.c                |   40 +
 drivers/input/serio/ct82c710.c               |  106 ++--
 drivers/input/serio/gscps2.c                 |   62 +-
 drivers/input/serio/i8042-io.h               |   31 +
 drivers/input/serio/i8042.c                  |  353 +++++++++-------
 drivers/input/serio/i8042.h                  |    7 
 drivers/input/serio/maceps2.c                |   86 ++--
 drivers/input/serio/parkbd.c                 |   47 +-
 drivers/input/serio/pcips2.c                 |   52 +-
 drivers/input/serio/q40kbd.c                 |  117 ++++-
 drivers/input/serio/rpckbd.c                 |   50 +-
 drivers/input/serio/sa1111ps2.c              |   39 +
 drivers/input/serio/serio.c                  |  576 +++++++++++++++++++++------
 drivers/input/serio/serio_raw.c              |  390 ++++++++++++++++++
 drivers/input/serio/serport.c                |   49 +-
 drivers/input/touchscreen/gunze.c            |   24 -
 drivers/input/touchscreen/h3600_ts_input.c   |   24 -
 drivers/input/tsdev.c                        |  301 ++++++++------
 drivers/serial/sunsu.c                       |   89 ++--
 drivers/serial/sunzilog.c                    |   80 ++-
 drivers/usb/input/hid-core.c                 |  104 ++--
 drivers/usb/input/hiddev.c                   |   17 
 fs/compat_ioctl.c                            |    2 
 include/asm-ppc/8253pit.h                    |   10 
 include/asm-ppc64/8253pit.h                  |   10 
 include/linux/compat_ioctl.h                 |   17 
 include/linux/input.h                        |    2 
 include/linux/serio.h                        |   66 ++-
 64 files changed, 3003 insertions(+), 1284 deletions(-)

Changesets (merge csets removed from list):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 ChangeSet@1.1803.119.2, 2004-08-19 17:02:03+02:00, vojtech@suse.cz
  input: Make sure the HID request queue survives report transfer failures gracefully.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
  Problem-spotted-by: Alan Stern <stern@rowland.harvard.edu>

 ChangeSet@1.1803.4.29, 2004-08-16 15:16:23+02:00, vojtech@suse.cz
  input: Update MAINTAINERS entries for Vojtech Pavlik.

 ChangeSet@1.1803.4.28, 2004-08-12 14:56:02+02:00, rmk@arm.linux.org.uk
  input: Update pcips2 driver
  
  Use pci_request_regions()/pci_release_regions() instead of
  request_region()/release_region()
  
  Signed-off-by: Russell King <rmk@arm.linux.org.uk>   
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1803.37.5, 2004-07-29 14:13:12+02:00, vojtech@suse.cz
  input: Check the range for HIDIOC?USAGES num_values.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1803.37.4, 2004-07-29 13:42:55+02:00, vojtech@suse.cz
  input: Fix a missing index in tmdc.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1803.12.22, 2004-07-28 00:57:35-05:00, dtor_core@ameritech.net
  Input: fix absolute device handling in mousedev that was broken
         by recent change that tried to do better multiplexing.
         Now every client will keep its own virtual cursor position
         and both absolute and relative events will update it
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1803.12.21, 2004-07-28 00:55:34-05:00, dtor_core@ameritech.net
  Input: fix reader wakeup conditions in mousedev, joydev and tsdev
         (we want readers to wake up when underlying device is gone
          so they would get -ENODEV and close the device).
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1803.12.20, 2004-07-28 00:54:40-05:00, dtor_core@ameritech.net
  Input: switch atkbd driver from busy-polling for command completion
         to waiting for event
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1803.12.19, 2004-07-28 00:54:01-05:00, dtor_core@ameritech.net
  Input: atkbd - harden ACK/NAK and command processing logic
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1803.12.18, 2004-07-28 00:52:45-05:00, dtor_core@ameritech.net
  Input: switch psmouse driver from busy-polling for command completion
         to waiting for event
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1803.12.17, 2004-07-28 00:51:37-05:00, dtor_core@ameritech.net
  Input: psmouse - harden command mode processing logic
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1803.12.16, 2004-07-28 00:50:38-05:00, dtor_core@ameritech.net
  Input: fix psmouse_sendbyte logic
         - correctly return NAK when command times out on our side
         - always reset ACK flag, even when serio_write fails
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1803.20.66, 2004-07-27 14:46:36+02:00, olh@suse.de
  input: Re-add PC Speaker support for PPC
  
  Signed-off-by: Olaf Hering <olh@suse.de>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1803.12.15, 2004-07-19 23:26:20-05:00, dtor_core@ameritech.net
  Input: serio - switch to use driver_find, adjust reference count
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1803.12.14, 2004-07-19 23:17:19-05:00, dtor_core@ameritech.net
  Input: allow marking serio ports (in addition to serio drivers)
         as manual bind only, export the flag through sysfs
  
             echo -n "manual" > /sys/bus/serio/devices/serio0/bind_mode
             echo -n "auto" > /sys/bus/serio/drivers/serio_raw/bind_mode
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1803.12.13, 2004-07-19 23:16:28-05:00, dtor_core@ameritech.net
  Input: Switch to use bus' default device and driver attributes to
         manage serio sysfs attributes
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1803.12.12, 2004-07-19 23:15:36-05:00, dtor_core@ameritech.net
  Input: integrate ct82c710, maceps2, q40kbd and rpckbd with sysfs
         as platform devices so their serio ports have proper parents
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1803.12.11, 2004-07-19 23:14:44-05:00, dtor_core@ameritech.net
  Input: make i8042 a platform device instead of system device so
         its serio ports have proper parent
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1803.12.10, 2004-07-19 22:48:22-05:00, dtor_core@ameritech.net
  Input: drop __attribute__ ((packed)) from mousedev_emul
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1803.12.9, 2004-07-19 22:44:37-05:00, dtor_core@ameritech.net
  Input: rearrange activation/children probe sequence in psmouse so
         reconnect on children ports works even after parent port is
         fully activated:
         - when connecting/reconnecting a port always activate it
         - when connecting/reconnecting a pass-throgh port deactivate
           parent first and activate it after connect is done
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1803.12.8, 2004-07-19 22:41:37-05:00, dtor_core@ameritech.net
  Input: synaptics - do not try to process packets from slave device
         as if they were coming form the touchpad itself if pass-through
         port is disconnected, just pass them to serio core and it will
         attempt to bind proper driver to the port
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1803.12.7, 2004-07-19 22:39:18-05:00, dtor_core@ameritech.net
  Input: do not call protocol handler in psmouse unless mouse is
         filly initialized - helps when USB Legacy emulation gets
         in our way and starts generating junk data stream while
         psmouse is detecting hardware
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1803.12.6, 2004-07-19 22:38:32-05:00, dtor_core@ameritech.net
  Input: when changing psmouse state (activated, ignore) use srio_pause_rx/
         serio_continue_rx so it will not fight with the interrupt handler
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1803.12.5, 2004-07-19 22:37:24-05:00, dtor_core@ameritech.net
  Input: add serio_pause_rx and serio_continue_rx so drivers can protect
         their critical sections from port's interrupt handler
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1803.12.4, 2004-07-19 22:36:34-05:00, dtor_core@ameritech.net
  Input: workaround for i8042 active multiplexing controllers losing
         track of where data is coming from. Also sprinkled some
         "likely"s in i8042 interrupt handler.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1803.12.3, 2004-07-19 22:35:13-05:00, dtor_core@ameritech.net
  Input: rearrange code in sunzilog so it registers its serio ports
         only after hardware was fully initialized and with interrupts
         tuned back on, otherwise it deadlocks.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1803.12.2, 2004-07-19 22:34:23-05:00, dtor_core@ameritech.net
  Input: move input/serio closer to the top of drivers/Makefile so
         serio_bus is available early
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1757.59.5, 2004-07-05 13:38:52+02:00, akropel1@rochester.rr.com
  This patch fixes another disconnect oops in hiddev.
  
  hid-core calls hiddev_disconnect() when the underlying device goes away
  (hot unplug or system shutdown). Normally, hiddev_disconnect() will
  clean up nicely and return to hid-core who then frees the hid structure.
  However, if the corresponding hiddev node is open at disconnect time,
  hiddev delays the majority of disconnect work until the device is closed
  via hiddev_release(). hiddev_release() calls hiddev_cleanup() which
  proceeds to dereference the hid struct which hid-core freed back when   
  the hardware was disconnected. Oops.
  
  To solve this, we change hiddev_disconnect() to deregister the hiddev
  minor and invalidate its table entry immediately and delay only the
  freeing of the hiddev structure itself. We're protected against future
  operations on the fd since the major fops check hiddev->exists.
  
  There may still be an ordering of events that causes a problem but I can
  no longer reproduce any manually. There are enough different subsystems
  and object lifetimes interacting here that I may have screwed something
  else up; review is certainly welcome.
  
  Signed-off-by: Adam Kropelin <akropel1@rochester.rr.com>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1757.59.2, 2004-06-29 11:59:04+02:00, vojtech@suse.cz
  input: Move Compaq ProLiant DMI handling (ServerWorks/OSB workaround)
         to i8042.c.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1757.58.1, 2004-06-29 09:48:40+02:00, vojtech@suse.cz
  input: Fix Kconfig so that the joydump module can be compiled.
  
  Reported-by: Matthieu Castet <castetm@ensimag.imag.fr>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1757.18.36, 2004-06-29 01:36:29-05:00, dtor_core@ameritech.net
  Input: link serio ports to their parent devices in ambakmi,
         gscps2, pcips2 and sa1111ps2 drivers
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1757.18.35, 2004-06-29 01:31:03-05:00, dtor_core@ameritech.net
  Input: Add serio_raw driver that binds to serio ports and provides
         unobstructed access to the underlying serio port via a char
         device. The driver tries to register char device 10,1
         (/dev/psaux) first and if it fails goes for dynamically
         allocated minor. To bind use sysfs interface:
  
         echo -n "serio_raw" > /sys/bus/serio/devices/serioX/driver
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1757.18.34, 2004-06-29 01:30:19-05:00, dtor_core@ameritech.net
  Input: allow marking some drivers (that don't do HW autodetection)
         as manual bind only. Such drivers will only be bound to a
         serio port if user requests it by echoing driver name into
         port's sysfs driver attribute.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1757.18.33, 2004-06-29 01:29:39-05:00, dtor_core@ameritech.net
  Input: allow users manually rebind serio ports, like this:
         echo -n "psmouse" > /sys/bus/serio/devices/serio0/driver
         echo -n "atkbd" > /sys/bus/serio/devices/serio1/driver
         echo -n "none" > /sys/bus/serio/devices/serio1/driver
         echo -n "reconnect" > /sys/bus/serio/devices/serio1/driver
         echo -n "rescan" > /sys/bus/serio/devices/serio1/driver
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1757.18.32, 2004-06-29 01:28:53-05:00, dtor_core@ameritech.net
  Input: serio sysfs integration
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1757.18.31, 2004-06-29 01:28:21-05:00, dtor_core@ameritech.net
  Input: allow serio drivers to create children ports and register these
         ports for them in serio core to avoid having recursion in connect
         methods.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1757.18.30, 2004-06-29 01:27:46-05:00, dtor_core@ameritech.net
  Input: switch to dynamic (heap) serio port allocation in preparation
         to sysfs integration. By having all data structures dynamically
         allocated serio driver modules can be unloaded without waiting
         for the last reference to the port to be dropped.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1757.18.29, 2004-06-29 01:27:11-05:00, dtor_core@ameritech.net
  Input: more renames in serio in preparations to sysfs integration
         - serio_dev -> serio_driver
         - serio_[un]register_device -> serio_[un]register_driver
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1757.18.28, 2004-06-29 01:26:36-05:00, dtor_core@ameritech.net
  Input: rename serio->driver to serio->port_data in preparation
         to sysfs integration
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1757.18.27, 2004-06-29 01:25:59-05:00, dtor_core@ameritech.net
  Input: make connect and disconnect methods mandatory for serio
         drivers since that's where serio_{open|close} are called
         from to actually bind driver to a port.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1757.39.3, 2004-06-24 17:55:29+02:00, vojtech@suse.cz
  input: Fix Peter Nelson's e-mail address in gamecon.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1757.39.2, 2004-06-24 15:44:37+02:00, cr7@os.inf.tu-dresden.de
  input: Add CodeMercs IOWarrior to hid-core device blacklist.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1722.159.13, 2004-06-23 22:19:54+02:00, James@superbug.demon.co.uk
  input: Add Audigy LS PCI ID to emu10k1-gp.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1722.159.12, 2004-06-23 19:58:19+02:00, vojtech@suse.cz
  input: Add Dell SB Live! PCI ID to the emu10k1-gp driver.
  
  Reported-by: Francisco Moraes <fmoraes74@netzero.net>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1722.159.11, 2004-06-23 08:06:20+02:00, vojtech@suse.cz
  input: Fix array overflows in keyboard.c when KEY_MAX > keycode > NR_KEYS > 128.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1722.159.10, 2004-06-21 20:31:56+02:00, vojtech@suse.cz
  input: when probing for ImExPS/2 mice, the ImPS/2 sequence needs
         to be sent first, but the result should be ignored.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1722.159.8, 2004-06-21 08:35:20+02:00, pnelson@andrew.cmu.edu
  input: Enhancements/fixes for PSX pad support:
  
      * Adds support for more than one controller. Previously more than
        one controller was initialized and the docs said they worked, but
        only one was actually read.                                      
      * Removes unnecessary detection on initialization. This allows the
        module to be initialized without controllers plugged in (hot    
        swapping controllers works). This removes a warning if the user
        has an unrecognized controller plugged in, but the only        
        unrecognized controller I have been able to find information about
        online is the PSX mouse, which I've never actually seen.          
      * Adds a GC_DDR option value to have direction presses register as
        buttons instead of axes. Allows the module to be used for Dance
        Dance Revolution emulators like Stepmania.                     
      * Adds psx_* to documentation.   
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>           

 ChangeSet@1.1722.159.7, 2004-06-21 07:48:47+02:00, vojtech@suse.cz
  input: Remove an extra dmi_noloop declaration in i8042.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1722.159.6, 2004-06-17 08:38:07+02:00, zinx@epicsol.org
  input: Fix bad struct hidinput initialization in hid-tmff.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1722.154.2, 2004-06-12 13:55:01+02:00, vojtech@suse.cz
  Input: rearrangements and cleanups in serio.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1722.112.26, 2004-06-06 20:13:56+02:00, vojtech@suse.cz
  input: Remove OSB4/Profusion hack in i8042, as it's handled by
         DMI blacklist now.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1612.25.4, 2004-06-06 11:37:05-05:00, dtor_core@ameritech.net
  Input: mousedev - implement tapping for touchpads working in absolute
         mode, such as Synaptics
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1612.25.3, 2004-06-06 11:34:24-05:00, dtor_core@ameritech.net
  Input: mousedev - better handle button presses when under load
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1722.119.5, 2004-06-06 11:56:42+02:00, zap@homelink.ru
  input: 
  
  From: Andrew Zabolotny <zap@homelink.ru>
  
  - Implement the 'raw' touchscreen protocol for backward compatibility
    (/dev/input/ts[0-7] now speaks the protocol of the old /dev/h3600_ts, and
    the /dev/input/tsraw[0-7] speaks the protocol of the old /dev/h3600_tsraw
    device).
  
  - Support the ioctls for setting the calibration parameters.  The default
    calibration matrix is computed from the xres,yres parameters (duplicate the
    old behaviour), however this is not enough for a good translation from
    touchscreen space to screen space.
  
  - Fixed a old bug in tsdev: on a pen motion event X1,Y1 -> X2,Y2 the driver
    would output three events with coordinates: X1,Y1, X2,Y1, X2,Y2.  This
    happened not only with coordinates, but with pressure too.
  
  - Update James's email address
  
  - Remove mention of Transvirtual Technologies: they no longer exist.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1722.119.4, 2004-06-06 11:37:43+02:00, herbert@gondor.apana.org.au
  input: Fix boundary checks for GUSAGE/SUSAGE in hiddev.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1722.119.3, 2004-06-06 11:09:31+02:00, vojtech@suse.cz
  input: Add a missing extern i8042_dmi_loop.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1722.119.2, 2004-06-06 11:08:20+02:00, vojtech@suse.cz
  input: Make hardware rawmode optional for AT-keyboards, and check
         for rawmode bits in keyboard.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1722.108.1, 2004-06-04 07:18:00+02:00, wli@holomorphy.com
  input: Move CONFIG_USB_HIDDEV a little lower in hiddev.h, to fix
         compilation breakage when it is not defined.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1612.25.2, 2004-06-02 13:00:58-05:00, dtor_core@ameritech.net
  Input: logips2pp - do not call get_model_info 2 times
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

 ChangeSet@1.1722.86.5, 2004-06-02 16:30:53+02:00, vojtech@suse.cz
  input: Add a missong dmi_noloop declaration in i8042.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1722.86.4, 2004-06-02 16:09:25+02:00, vojtech@suse.cz
  input: More locking improvements (and a fix) for serio. This
         merges both my and Dmitry's changes.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1722.86.3, 2004-06-02 15:46:14+02:00, vojtech@suse.cz
  input: Make atkbd.c's atkbd_command() function immune to keys being pressed
         and scancodes coming from the keyboard while it's executing.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1722.87.1, 2004-06-02 13:44:20+02:00, vojtech@suse.cz
  input: Disable the AUX LoopBack command in i8042.c on Compaq ProLiant
         8-way Xeon ProFusion systems, as it causes crashes and reboots
         on these machines. DMI data is used for determining if the
         workaround should be enabled.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1722.68.2, 2004-06-02 09:37:24+02:00, vojtech@suse.cz
  input: Fixes in serio locking. We need per-serio lock for passthrough
         ports, some locks were missing, and spin_lock_irq was wishful
         thinking in serio_interrupt. There is no guarantee
         that serio_interrupt won't be called twice at the same time.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1722.65.3, 2004-05-31 16:25:29+02:00, vojtech@suse.cz
  input: Use raw events generated by atkbd in keyboard.c to implement true
         rawmode for PS/2 keyboards.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1722.65.2, 2004-05-31 15:49:05+02:00, vojtech@suse.cz
  input: Add reporting of raw scancodes to atkbd.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1722.65.1, 2004-05-31 15:11:41+02:00, vojtech@suse.cz
  input: Explicit variable access rules for psmouse.c, using bitops.

 ChangeSet@1.1722.56.3, 2004-05-31 12:27:40+02:00, vojtech@suse.cz
  input: Return 0 from uinput poll if device isn't yet created.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1722.56.2, 2004-05-30 16:57:22+02:00, vojtech@suse.cz
  input: Make atomicity and exclusive access to variables explicit
  in atkbd.c, using bitops.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

 ChangeSet@1.1612.1.22, 2004-05-28 22:57:43+02:00, vojtech@suse.cz
  input: Fix an oops in poll() on uinput.  Thanks to Dmitry Torokhov
         for suggesting the fix.

 ChangeSet@1.1612.24.2, 2004-05-28 18:24:08+02:00, vojtech@suse.cz
  input: An attempt at fixing locking in i8042.c and serio.c

 ChangeSet@1.1612.24.1, 2004-05-28 16:19:29+02:00, vojtech@suse.cz
  Cset exclude: dtor_core@ameritech.net| ChangeSet|20040510063935|25419

 ChangeSet@1.1612.1.20, 2004-05-19 00:13:58+02:00, akropel1@rochester.rr.com
  input: Add 64-bit compatible ioctls for hiddev.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
