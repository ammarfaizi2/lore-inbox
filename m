Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264976AbUDUGF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264976AbUDUGF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264974AbUDUGF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:05:59 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:34476 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264976AbUDUGFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:05:40 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/15] New set of input patches
Date: Wed, 21 Apr 2004 00:49:17 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404210049.17139.dtor_core@ameritech.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a new set of my input patches, would love to hear comments and/or
suggestions. The patches can also be found at:

http://www.geocities.com/dt_or/input/2_6_6-rc2/
bk pull bk://dtor.bkbits.net/input

01-synaptics-cleanup.patch
   Adjust the way we extract button data; do not announce BTN_BACK/BTN_FORWARD
   unless touchpad has SYN_CAP_FOUR_BUTTON; adjust querying extended
   capailities according to the latest Synaptics documentation addendum 

02-synaptics-middle-button.patch
   Support for touchpads that have middle button.

03-dont-change-max-proto.patch
   Do not mangle global parameter when probing for protocol extensions.

04-lkkbd-whitespace.patch

05-lkkbd-simplify.patch
   Drop some duplicate checks.

06-atkbd-soften-xfree-warning.patch
   Soften accusations against XFree when we get spurios ACK/NAK from the KBC. 

07-atkbd-trailing-whitespace.patch

08-atkbd-bitfields.patch
   Cleanup, convert some essentialy boolean fields ino bitfields.

09-atkbd-timeout-complaints.patch
   Do not complain about surious NAK in cases when keyboard controller's
   timeout is bigger then in atkbd and NAK to our probe comes too late. 

10-psmouse-rescan-on-hotplug.patch
   When we get 0xAA 0x00 froma device do reconnect and not rescan in case
   it's an old device that just reset for some reason (KVM switch?) 

11-psmouse-reconnect-after-error.patch
   Move psmouse_reconnectafter handling from synaptocs to psmouse-base so
   it can later be used by other protocols.

12-psmouse-protocol-handler.patch
   Add protocol_handler funtion pointer to the psmouse structure so we
   won't have unsighly if/switch constructs in psmouse-base when we add
   support for more protocols.

13-psmouse-sliced-command.patch
   Synaptics and logips2pp noth implemented their own routines of sening
   extended PS/2 commands to the mouse; consolidate the code.

14-atkbd-reconnect-probe.patch
   Do not alter psmouse structure when probing for supported protocols
   at reconnect. Cures an OOPS when Synaptics is not detected at first
   (USB legacy emulation problem, etc) but is detected after resume.

15-psaux-config.patch
   Allow disabling legacy psaux device even for non-embedded systems;
   not everyone wants/needs it.

-- 
Dmitry
