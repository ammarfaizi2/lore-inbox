Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265901AbUBBVTM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 16:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbUBBVTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 16:19:12 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:15488 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265901AbUBBVTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 16:19:06 -0500
Date: Mon, 2 Feb 2004 22:19:26 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Valdis.Kletnieks@vt.edu
Cc: Joshua Kwan <joshk@triplehelix.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: 2.6 input drivers FAQ
Message-ID: <20040202211926.GB440@ucw.cz>
References: <20040201100644.GA2201@ucw.cz> <20040201163136.GF11391@triplehelix.org> <200402020527.i125RvTx008088@turing-police.cc.vt.edu> <20040202092318.GD548@ucw.cz> <200402021812.i12IC6eR006637@turing-police.cc.vt.edu> <20040202201813.GA272@ucw.cz> <200402022028.i12KSnSQ011554@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402022028.i12KSnSQ011554@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 03:28:49PM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 02 Feb 2004 21:18:13 +0100, Vojtech Pavlik said:
> 
> > Because normally the X server reads them in very quick succession and if
> > you don't make a very short click, the sequence looks like this:
> > 
> > push1 push2 release1 release2, which is fine, because X interprets that
> > as just a push and a release.
> > 
> > If there is disk activity or something else that causes the scheduling
> > to be delayed, it's push1 release1 push2 release2, which counts as a
> > doubleclick.
> > 
> > Hence sporadic doubleclicking.
> 
> Well.. that would explain things except for the single /dev/psaux I have.
> 
> Could a similar timing hole happen if the system submerged into SMM
> code for a battery check or similar? (I know, that *should* cause
> lost events not duplicated, but....)

I don't see a way how this could happen. One thing you could try - run
evtest on the mouse event device in a window/on another vc, and when the
doubleclick happens, examine the last sreenful of events.

> > For movement, of course, you get twice the mouse speed, but usually most
> > people just adjust the acceleration settings and are done with that.
> 
> Haven't seen this.

Most likely your problem comes from elsewhere. Did you try another
mouse?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
