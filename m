Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbTIAQPl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 12:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbTIAQPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 12:15:40 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:23727 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S263019AbTIAQP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 12:15:28 -0400
Date: Mon, 1 Sep 2003 18:01:25 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Re:Re: Linux 2.6.0-test4
Message-ID: <20030901160125.GL22127@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030831120605.08D6.CHRIS@heathens.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831120605.08D6.CHRIS@heathens.co.nz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Heath <chris@heathens.co.nz>:
> > Aug 27 18:53:41 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> > Aug 27 19:15:14 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0xb9, on isa0060/serio0) pressed.
> > Aug 27 19:42:50 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> > Aug 28 10:14:14 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> > 
> > Basically, CTRL was stuck. Even when I switched to X11.
> 
> Well, this completely baffles me.  I thought X11 maintains its own
> keydown array.
> 
> Anyway, I've included a patch that should hopefully give us better
> debugging information.  When you get an unknown key error, it will also
> dump the last 16 bytes that were sent from the keyboard.  Be careful
> with this one.  If you post any errors to the list, make sure it doesn't
> contain any sensitive passwords. :-)

I applied your patch, and alas:

Sep  1 16:12:19 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0xb9, on isa0060/serio0) pressed.
Sep  1 16:12:19 hummus2 kernel: i8042 history: ae 9d e0 48 e0 c8 e0 38 56 d6 e0 b8 e0 b8 39 b9

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
