Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287908AbSAHFee>; Tue, 8 Jan 2002 00:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287910AbSAHFeO>; Tue, 8 Jan 2002 00:34:14 -0500
Received: from [203.143.19.4] ([203.143.19.4]:5387 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S287908AbSAHFeI>;
	Tue, 8 Jan 2002 00:34:08 -0500
Date: Tue, 8 Jan 2002 11:33:33 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: linux-kernel@vger.kernel.org
Subject: An alternative kernel configuration system
Message-ID: <20020108113333.A8007@lklug.pdn.ac.lk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After hearing that Linus likes data to be `distributed' over the kernel tree
and config siles `owned' by people (unlike a single Configure.help), I started
a simple configuration system for the Linux kernel.

I just got a configuration file format worked out which looks more or less like
apt package lists on Debian - simple, yet powerful.

More than all, it is very readable.

It is easy to write tools to parse these configuration files.

Here is an example configuration item:

symbol: SOUND_OSS
depends: SOUND
# conflicts:
# implied-by:
type: tristate
menu-item: sound_oss
menu-caption: Sound card support
# menu-depends:
menu-parent: sound
description:
  OSS is the Open Sound System suite of sound card drivers. They make
  sound programming easier since they provide a common API. Say Y or M
  here (the module will be called sound.o) if you haven't found a
  driver for your sound card above, then pick your driver from the
  list below.

include drivers/sound/sb.conf
# other OSS sound driver files included here


Currently, I am in the process of converting CML1 files in the 2.5.2-pre9 tree
to this system and am expecting to get the dependencies from the CML2 system.
I also like to have the menus look like the CML1 so that users won't feel a
difference at all.

The plan is to write C programs (no python ;)) that would read the config
symbols and menu items into a balanced binary tree and invoke suitable front
ends (tty, curses, X-TCL or X/GTK).

More details are available at:

   http://www.bee.lk/people/anuradha/kernelconf/

No software nor config files are available yet. This mail is just a note to
inform that some work is going on.

Regards,

Anuradha

NB: I would like to work on it 24 hrs a day, but my undergrad exams are from
    15 to 28 :-(

-- 

Debian GNU/Linux (kernel 2.4.16-xfs)

Being overloaded is the sign of a true Debian maintainer.
	-- JHM on #Debian

