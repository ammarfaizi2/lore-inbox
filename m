Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267457AbUIMQec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267457AbUIMQec (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 12:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267841AbUIMQdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 12:33:07 -0400
Received: from mail1.ati.com ([209.50.91.165]:50146 "EHLO mail1.ati.com")
	by vger.kernel.org with ESMTP id S268317AbUIMQap convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 12:30:45 -0400
Subject: Re: radeon-pre-2
X-Sybari-Trust: 2fba19ec e1e46965 669a16f6 00000108
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Vladimir Dergachev <volodya@mindspring.com>,
       Dave Airlie <airlied@linux.ie>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <a728f9f9040912230544dcf8df@mail.gmail.com>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
	 <1094912726.21157.52.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409122319550.20080@skynet>
	 <1095035276.22112.31.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.61.0409122042370.9611@node2.an-vo.com>
	 <a728f9f9040912230544dcf8df@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Mon, 13 Sep 2004 12:29:46 -0400
Message-Id: <1095092986.4610.78.camel@admin.tel.thor.asgaard.local>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-13 at 02:05 -0400, Alex Deucher wrote:
> On Sun, 12 Sep 2004 20:45:18 -0400 (EDT), Vladimir Dergachev
> <volodya@mindspring.com> wrote:
> > 
> > 
> > On Sun, 12 Sep 2004, Michel [ISO-8859-1] D�nzer wrote:
> > 
> > > On Sun, 2004-09-12 at 23:42 +0100, Dave Airlie wrote:
> > >>
> > >> I think yourself and Linus's ideas for a locking scheme look good, I also
> > >> know they won't please Jon too much as he can see where the potential
> > >> ineffecienes with saving/restore card state on driver swap are, especailly
> > >> on running fbcon and X on a dual-head card with different users.
> > >
> > > Frankly, I don't understand the fuss about that. When you run a 3D
> > > client on X today, 3D client and X server share the accelerator with
> > > this scheme, and as imperfect as it is, it seems to do a pretty good job
> > > in my experience.
> > 
> > Not that good - try dragging something while a DVD video is playing.
> 
> The overlay could be converted to use the CP engine as well. right now
> it has to switch to MMIO for overlay.

The question is whether that matters at all, i.e. whether the registers
used for the overlay are FIFO'd.

Either way, I don't see how this is related to the way DRM context
switches are handled.


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer
