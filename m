Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264779AbTE1PtE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 11:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264780AbTE1PtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 11:49:04 -0400
Received: from auemail1.lucent.com ([192.11.223.161]:62940 "EHLO
	auemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S264779AbTE1Psv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 11:48:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16084.56696.483384.79844@gargle.gargle.HOWL>
Date: Wed, 28 May 2003 12:02:00 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.70-mm1 - no boot console
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I've been trying on and off to get the 2.5.x series to boot on my DELL
Precision 610 MT dual processor machine.  I've got a pair of 550mhz
PIII Xeon and 768mb of ECC RAM.  I've got a Matrox G450 AGP card along
with a mix of SCSI and IDE drives, cdroms and tape.  And an
USB2.0/1394 Firewire combo card.  I've been happily running
2.4.21-pre5-ac1 for about a month without any problems, and previous
2.4.x versions as well. 

But over the past few days I've tried to get 2.5.69 and 2.5.70-mm1 to
start up and run, but without any luck.  All I get on the console is
the first two lines of output and then the system just hangs.  It
never gets to even mounting file systems, since I never have to fsck
on reboot.

I don't have a spare serial console currently, though I'm starting to
think I need to get one up and running if I'm ever going to make this
work.

Here's what I have in my .config for CONSOLE & INPUT entries:

  CONFIG_VT_CONSOLE=y
  CONFIG_HW_CONSOLE=y
  # CONFIG_SERIAL_8250_CONSOLE is not set
  # CONFIG_LP_CONSOLE is not set
  # Console display driver support
  CONFIG_VGA_CONSOLE=y
  # CONFIG_MDA_CONSOLE is not set
  CONFIG_DUMMY_CONSOLE=y
  CONFIG_FRAMEBUFFER_CONSOLE=y

  CONFIG_INPUT=y
  CONFIG_INPUT_MOUSEDEV=y
  CONFIG_INPUT_MOUSEDEV_PSAUX=y
  CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
  CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
  # CONFIG_INPUT_JOYDEV is not set
  # CONFIG_INPUT_TSDEV is not set
  CONFIG_INPUT_EVDEV=y
  # CONFIG_INPUT_EVBUG is not set
  # Input I/O drivers
  # Input Device Drivers
  CONFIG_INPUT_KEYBOARD=y
  CONFIG_INPUT_MOUSE=y
  # CONFIG_INPUT_JOYSTICK is not set
  # CONFIG_INPUT_TOUCHSCREEN is not set
  CONFIG_INPUT_MISC=y
  CONFIG_INPUT_PCSPKR=y
  CONFIG_INPUT_UINPUT=y

I've even tried to back off from CONFIG_M686 back down to just
CONFIG_M386, but nothing seems to help.  I'm using CONFIG_X86=y, but
none of the other CONFIG_X86_* options. 

Next I guess I'll try to get rid of SMP and PREEMPT and see how that
goes.  Any ideas on whats going on here, or what I should try to get
this working?

Thanks,
John

