Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVDEU2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVDEU2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbVDEU2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:28:15 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:40873 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261985AbVDEUGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:06:21 -0400
Message-Id: <20050405193859.506836000@delft.aura.cs.cmu.edu>
Date: Tue, 05 Apr 2005 15:38:59 -0400
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: Greg KH <greg@kroah.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: jaharkes@cs.cmu.edu, Dmitry Torokhov <dtor_core@ameritech.net>,
       Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: [patch 0/5] Hotplug firmware loader for Keyspan usb-serial driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is another stab at making the keyspan firmware easily loadable with
hotplug. Differences from the previous version,

- keep the IHEX parser into a separate module.
- added a fw-y and fw-m install targets to kbuild which will install a
  driver's firmware files in /lib/modules/`uname -r`/firmware.

01 - Add lib/ihex_parser.ko.
02 - Adapt drivers/usb/serial/keyspan.ko to use request_firmware/load_ihex.
03 - Program used to dump the firmware headers to IHEX formatted files.
04 - Result of converting the firmware.
05 - Add "make install_firmware" and the related fw-$(CONFIG_FOO) stuff.

Jan


