Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbTFLJis (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 05:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbTFLJis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 05:38:48 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:4612 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S264582AbTFLJir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 05:38:47 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
References: <m2smqhqk4k.fsf@p4.localdomain> <20030611170246.A4187@ucw.cz>
	<m27k7sv5si.fsf@telia.com> <20030611203408.A6961@ucw.cz>
	<m2ptlkqpej.fsf@telia.com>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <m2ptlkqpej.fsf@telia.com>
Date: 12 Jun 2003 04:36:04 -0400
Message-ID: <m3llw7d763.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you tested with Arne Koewing <ark@gmx.net>'s synaptics_reset patch:

diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
--- a/drivers/input/mouse/psmouse.c     Thu Jun 12 04:26:48 2003
+++ b/drivers/input/mouse/psmouse.c     Thu Jun 12 04:26:48 2003
@@ -345,6 +345,7 @@
                   thing up. */
                psmouse->vendor = "Synaptics";
                psmouse->name = "TouchPad";
+              psmouse_command(psmouse, param, PSMOUSE_CMD_RESET_BAT);
                return PSMOUSE_PS2;
        }


w/o that patch, using 2.5 on a dell laptop disables the track point
until something else causes a rest on the ps/2 bus, such as hot-
plugging an external ps2 mouse or suspending and resuming the box.

For that matter, does running the touchpad in absolute mode affect
the track point at all?

(I'm primarily just interested in stopping the unintended mouse button
events I get from the pad's default config....)

-JimC

