Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbUEQNJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUEQNJQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 09:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUEQNJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 09:09:16 -0400
Received: from zork.zork.net ([64.81.246.102]:63638 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261210AbUEQNJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 09:09:15 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Scroll wheel on PS/2 Logitech MouseMan Wheel no longer works (was
 Re: 2.6.6-mm3)
References: <20040516025514.3fe93f0c.akpm@osdl.org>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, vojtech@suse.cz,
 linux-kernel@vger.kernel.org
Date: Mon, 17 May 2004 14:09:11 +0100
In-Reply-To: <20040516025514.3fe93f0c.akpm@osdl.org> (Andrew Morton's
 message of "Sun, 16 May 2004 02:55:14 -0700")
Message-ID: <6u3c5zkxoo.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

>  bk-input.patch

I'm guessing this patch contains the changes responsible.

As with 2.6.6-mm2 (and before, from a quick grep of
/var/log/messages), the mouse is detected as

  mice: PS/2 mouse device common for all mice
  serio: i8042 AUX port at 0x60,0x64 irq 12
  input: ImExPS/2 Logitech Wheel Mouse on isa0060/serio1

but moving the wheel causes the pointer to make large jumps toward the
top-right corner.

When I boot with psmouse.proto=imps, it is detected as below and works
as before.

  mice: PS/2 mouse device common for all mice
  serio: i8042 AUX port at 0x60,0x64 irq 12
  input: ImPS/2 Generic Wheel Mouse on isa0060/serio1

In case it's relevant, the mouse is connected through a KVM switch.
