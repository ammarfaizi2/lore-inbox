Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263267AbVCDXwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbVCDXwW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263242AbVCDXp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:45:27 -0500
Received: from pirx.hexapodia.org ([199.199.212.25]:39481 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S263157AbVCDWPY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 17:15:24 -0500
Date: Fri, 4 Mar 2005 14:15:23 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc4: Alps touchpad too slow
Message-ID: <20050304221523.GA32685@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Vaio r505te comes up with an unusably slow touchpad if I allow the
ALPS driver to drive it.  It says

> ALPS Touchpad (Glidepoint) detected
>   Disabling hardware tapping
> input: AlpsPS/2 ALPS TouchPad on isa0060/serio1

and then the trackpad operates at about 1/8 the speed I've gotten used
to.

I'm running 2.6.11-rc4; this started happening somewhere between
2.6.10 and 2.6.11-rc3.

I've toyed with 'xset m', but nothing I've done there seems to have
any effect.  (I suspect that Linux never generates the appropriate
sequence of mouse events to trigger the X cursor acceleration regime.)

I can restore the original behavior by passing "proto=exps" to
psmouse.o, in which case I get
> input: PS/2 Generic Mouse on isa0060/serio1

On a related note, how are users supposed to control this newfangled
PS2 driver?  I'd like at least the *option* to turn tapping back on,
but I can't find any knobs *anywhere*.  And of course I'd like to
adjust the tracking speed, too.

-andy
