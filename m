Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUDDOKR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 10:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUDDOKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 10:10:17 -0400
Received: from main.gmane.org ([80.91.224.249]:44430 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262412AbUDDOKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 10:10:11 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: 2.6.x: Multimedia keys for the Dell Inspiron 8x00 in console and X
Date: Sun, 4 Apr 2004 15:55:33 +0200
Message-ID: <MPG.1ada226fab8987f2989690@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-63-140.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

since I switched to the 2.6.x kernel series I am having problems 
properly setting up the multimedia keys available on the keyboard of 
my Dell Inspiron 8200 laptop, both in console and in X.

First of all, four of these keys (Play/Pause, Stop, Prev, Next) are 
not recognized by the at keyboard driver; their scancodes go from 
e001 to e004. This isn't really a problem because I can map them to 
the values used in previous kernels (129 to 132) with setkeycodes.

In console, the problem is that even after the mapping, the 
i8kbuttons daemon that monitors usage of these key in console doesn't 
seem to act. This is both with the keys that have to be mapped and 
with e.g. the volume control keys that are properly seen by the 
default driver with no additional user intervention. The utility 
worked fine with 2.4.x kernels.

In X, the volume control buttons are seen correctly, and propetly 
mapped to XF86AudioLower, Raise and Mute. The problems are with the 
other four keys:

* if I do not map them with setkeycodes, X doesn't see them at all (I 
can press them but xev shows no action)

* if I map them to the proper keycodes with setkeycodes, X seems to 
see them "shifted" by a certain amount; for example, if I do

setkeycodes e001 129

and press the Play/Pause key, xev reports a keycode of 133 (with no 
symbol attached). OTOH, the keycodes 129 to 132 are correctly mapped 
to the XF86Audio* feature by the inet(inspiron) xkb configs, so it's 
really a problem of the wrong keycodes getting passed through.

I would suspect xkb, if it wasn't for the i8kbuttons utility failing 
too ... is there a way to have the keys behave properly?

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

