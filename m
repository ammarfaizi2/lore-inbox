Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbTELMEX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 08:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTELMEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 08:04:23 -0400
Received: from [65.244.37.61] ([65.244.37.61]:59305 "EHLO
	WSPNYCON1IPC.corp.root.ipc.com") by vger.kernel.org with ESMTP
	id S262057AbTELMEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 08:04:22 -0400
Message-ID: <170EBA504C3AD511A3FE00508BB89A92020CD950@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: rubini@ipvvis.unipv.it
Cc: linux-kernel@vger.kernel.org
Subject: Broken mouse in 2.4.21-rc2
Date: Mon, 12 May 2003 08:16:28 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The mouse is not working on my 2 x XEON 2.4Ghz (Dell Precision 450)
under 2.4.21-rc2 (also 2.4.18 and 2.4.20).  Works fine under 2.5.x.

My usual mouse is a Logitech Cordless TrakMan Wheel, plugged into the
mouse port (not USB).  The symptoms are the same when using a MS
Intellimouse or old MS PS2 mouse.

With the logitech,  gpm loads without complaint if -t imsp2 is specified,
but on first mouse move compains "invalid ioctl for device".  If loaded
with -t ms, it doesn't complain.  In both cases, the mouse produces only
erratic responses.  In /var/log/messages I find:

gpm[283]: Skipping a data packet (?)

Using a MS Intellimouse, the symptoms are the same (erratic responses),
but there are no complaints to the console, or in any log files.  There
is a message in messages:

gpm[292]: imps2: Auto-detected standard PS/2

The same happens with the old mouse, except that there is no auto-detect
message.

Under XFree86, the mouse is completely unresponsive, whichever mouse is
used, and whether gpm was loaded first or not.  There are no warnings
or errors in the XFree86.log, and all normal mouse related messages are
present.

There are no errors or warnings produced during boot or module loading
in any log file or dmesg; with only this exception:

ACPI-0202: Warning: Invalid table signature ASF! found
ACPI-0095: Error: Acpi_load_tables: Error getting required tables
    (DSDT/FADT/FACS): AD_BAD_SIGNATURE
ACPI-0116: Error: Acpi_load_tables: Could not load tables: AE_BAD_SIGNATURE

System is Slackware 8.1, with upgrades: XFree86 4.3, dropline-gnome, KDE
3.1.

Mouse support is _not_ built as a module.  There is no support for USB HID.

Possibly also if interest - the keyboard will not auto-repeat.
