Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbTDMQuM (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 12:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263551AbTDMQuM (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 12:50:12 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:53450 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261321AbTDMQuL (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 12:50:11 -0400
Date: Sun, 13 Apr 2003 19:01:53 +0200 (MEST)
Message-Id: <200304131701.h3DH1rdg012999@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: vojtech@suse.cz
Subject: Re: PS/2 mouse problems with 2.5 input drivers
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Feb 2003 11:30:34 +0100 (MET), I wrote:
>On my Dell Latitude, the external PS/2 mouse works, but the
>sensitivity is way down compared to the 2.4 PS/2 driver.
>(As in: I have to move the mouse much further with 2.5 to
>move the mouse pointer a given distance on the screen.)
>
>On resuming after suspend (apm), the mouse goes bonkers.
>Even the tiniest mouse movement or key press seems to generate
>too many and bogus events (it wreaks havoc in my xterm), the
>PS/2 interrupt count goes up rapidly, and I get "psmouse.c:
>Lost synchronization, throwing N bytes away." (for N in 1-3).
...
>(Also, it seems the input layer detects most of my mice as
>"ImPS/2 Generic Wheel Mouse", even though only one of them
>is a wheel mouse. I don't know if that's a problem.)

I got a tip to use the "psmouse_noext" kernel option, and
that solved the two latter problems: the mouse is now simply
recognized as a generic PS/2 mouse, and it doesn't go bonkers
after a suspend/resume cycle. Kernel 2.5.67.

The first problem remains: in console mode (not X), the
sensitivity is still way down compared to 2.4 kernels.
Is there a way to adjust that?
