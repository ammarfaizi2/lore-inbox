Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266462AbUBLOrG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 09:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUBLOrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 09:47:06 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:8709 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S266462AbUBLOrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 09:47:03 -0500
Date: Thu, 12 Feb 2004 15:46:56 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange atkbd messages with missing keyboard
Message-ID: <20040212154656.A2460@pclin040.win.tue.nl>
References: <Pine.GSO.4.44.0402121600030.22808-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.44.0402121600030.22808-100000@math.ut.ee>; from mroos@linux.ee on Thu, Feb 12, 2004 at 04:18:43PM +0200
X-Spam-DCC: meer: mailhost.tue.nl 1086; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 04:18:43PM +0200, Meelis Roos wrote:
> I get strange messages on bootup when there is no keyboard attached
> (Intel 430TX chipset on a Tyan S1573 mainboard) - it tells about unknown
> keys pressed.
> 
> When no keyboard and no mouse is plugged in:
> 
> serio: i8042 AUX port at 0x60,0x64 irq 12
> atkbd.c: Unknown key pressed (raw set 0, code 0x17e on isa0060/serio1).
> atkbd.c: Use 'setkeycodes 7e <keycode>' to make it known.
> serio: i8042 KBD port at 0x60,0x64 irq 1
> atkbd.c: Unknown key released (translated set 0, code 0x7e on isa0060/serio0).
> atkbd.c: Use 'setkeycodes 7e <keycode>' to make it known.

Yes - most people see such messages involving 7a, where the
actual code is 0xfa = ACK.
You see 7e, the actual code is 0xfe = NACK, the error report
from the keyboard interface.

It is a kernel flaw that these ACK and NACK are not recognized
for what they are.
