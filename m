Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264863AbUEYOP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264863AbUEYOP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 10:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264864AbUEYOP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 10:15:28 -0400
Received: from postman1.arcor-online.net ([151.189.20.156]:12228 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S264863AbUEYOP0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 10:15:26 -0400
Subject: synaptics touchpad is still 'jumpy' in 2.6.7-rc1
From: Thorsten Hirsch <thorstenhirsch@arcor.de>
To: "linux kernel mailing list (lkml)" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1085494126.9350.23.camel@minime.hirsch.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 25 May 2004 16:08:46 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

The title says it. My synaptics touchpad is still jumpy and I also get
those out-of-sync errors in dmesg:

Synaptics driver lost sync at byte 4
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 4
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver resynced.
psmouse.c: TouchPad at isa0060/serio2/input0 lost synchronization,
throwing 2 bytes away.
[...and again and again...]

I know of the pcilink patch for ACPI, Len Brown has posted, but this one
doesn't do the trick for me. I also tried 2.6.6-mm5 and 2.6.7-rc1 (where
this patch is already included), but still get the same results.

I even don't know if it's ACPI-related, because the only thing that
makes it seem to be so is that the battery data (gkrellm monitor and
also /proc/acpi/battery) is broken, e.g. remaining capacity is going to
values >10000mWh for the moment when my touchpad is out of sync. But
then when syncing back the ACPI battery data is okay again, too.
But my point is, that when using the kernel parameter acpi=off I still
have the same problems with my touchpad.

My hardware is also okay as I've got no problems at all with kernel
2.4.x.

Bye.
Thorsten
-- 
PGP public key:
http://home.arcor.de/thorstenhirsch/thirschatwebde.asc

