Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbUACJEL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 04:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUACJEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 04:04:10 -0500
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:42890 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262795AbUACJEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 04:04:05 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: New set of input patches
Date: Sat, 3 Jan 2004 03:50:43 -0500
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401030350.43437.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

I have a new set of input patches, could you take look at them?

1. i8042-suspend.patch
   Add suspend methods to i8042 to restore BIOS settings on suspend and
   kill polling timer which sometimes prevents APM suspend

2. i8042-options-parsing.patch
   psmouse-options-parsing.patch
   atkbd-options.parsing
   Complete conversion to the new way of parsing parameters. Drop "i8042_",
   "psmouse_" and "atkbd_" prefixes from option names when compiled as a
   module and require "i8042.", "psmouse." and "atkbd." prefixes if built
   into the kernel.

3. missing-module-license.patch
   Maple and newton keyboard drivers were missing MODULE_LICENSE("GPL")

4. kconfig-synaptics-help.patch
   Suggest psmouse.proto=imps to Synaptics users who do not want install
   native XFree Synaptics driver so taps would still work

5. sis-aux-port.patch
   Do not ignore AUX port if chipset fails to disable it when we do probes
   as SiS is having trouble disabling but otherwise mouse works fine.

The patches are on top of 2 other input patches (remove jitter and ps2
emulation) that I have sent to the list earlier. You can find the complete
set of patches at http://www.geocities.com/dt_or/input/2_6_0-rc1/ and
http://www.geocities.com/dt_or/input/2_6_0-rc1-mm1/

Dmitry
