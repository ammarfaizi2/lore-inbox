Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTIBVlp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 17:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbTIBVlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 17:41:44 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:48399 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263299AbTIBVlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 17:41:36 -0400
Date: Tue, 2 Sep 2003 23:41:33 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: keyboard - was: Re: Linux 2.6.0-test4
Message-ID: <20030902234133.A1627@pclin040.win.tue.nl>
References: <20030831120605.08D6.CHRIS@heathens.co.nz> <20030902080733.GA14380@charite.de> <20030902124717.B1221@pclin040.win.tue.nl> <20030902123252.GC22365@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030902123252.GC22365@charite.de>; from Ralf.Hildebrandt@charite.de on Tue, Sep 02, 2003 at 02:32:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 02:32:52PM +0200, Ralf Hildebrandt wrote:

> > Yesterday's data sufficed, and I suppose the patch I gave solves
> > this problem.
> 
> Nope. I applied the patch and rebuilt the kernel and rebooted.
> 
> Right now, my CTRL key is totally "stuck" on the fbconsole. I can't
> release it, not even by switching between the consoles and/or X11.
> 
> But now I don't get any messages like the one below (yes, the special
> code generating this output is still active...)
> 
> > > atkbd.c: Unknown key (set 2, scancode 0x9c, on isa0060/serio0) pressed.
> > > i8042 history: e0 d0 1c 9c 2e ae 10 90 e0 50 e0 d0 e0 d0 1c 9c

Well, that shows that this particular problem was solved, but there are
more problems. No doubt we'll understand everything eventually.

(Unless we remove this i8042_unxlate_seen before understanding all problems.
It is really very ugly to have two different arrays that both keep the
"key down" status of the keys, and that can get out of sync.)

Again, of course, I would like to see the past few dozen scancodes, like you
gave before, up to the moment the problem arises.
(If you cannot think of something better, just log every incoming scancode.)

Andries

