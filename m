Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSHFROP>; Tue, 6 Aug 2002 13:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSHFROO>; Tue, 6 Aug 2002 13:14:14 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:38117 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S313867AbSHFROO>;
	Tue, 6 Aug 2002 13:14:14 -0400
Date: Tue, 6 Aug 2002 10:17:36 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.20-pre1
Message-ID: <20020806171736.GC11313@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20020806002126.GA10585@bougret.hpl.hp.com> <Pine.LNX.4.44.0208060933070.7302-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208060933070.7302-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2002 at 09:33:45AM -0300, Marcelo Tosatti wrote:
> 
> 
> On Mon, 5 Aug 2002, Jean Tourrilhes wrote:
> 
> > 	Hi,
> >
> > 	Sorry to disturb, but it seems that kernel.org didn't pick up
> > 2.4.20-pre1 (or I'm looking at the wrong places).
> >
> > 	I'm asking because I've just finished testing my IrDA update
> > for 2.4.20, and you've just included some useless IrDA change that
> > probably render my patch worthless
> 
> What you mean I included some useless IrDA patch?

	Yep, tons of these :
-----------------------------------------------
-        IRDA_DEBUG(4, __FUNCTION__ "(), speed=%d (was %d)\n", speed, 
-		   self->speed);
+        IRDA_DEBUG(4, "%s(), speed=%d (was %d)\n", __FUNCTION__,
+        	speed, self->speed);
-----------------------------------------------
	Between this and fixing a Oops or Deadlock, I'll take the
second any day.
	I don't care on those patch in general, I'm not a control
freak, except that being so pervasive they are guaranteed to screw up
my own patches. That's why yesterday I *explicitely* asked you and
Alan if anything was pending, so that I could avoid wasting my time
and instead wait for the next release doing something else.
	I guess it's too late, I already wasted my afternoon.

	The second thing that bugs me is that because those patches
pass behind my back, they won't get applied to *both* 2.4.X and
2.5.X. Because of that, keeping 2.4.X and 2.5.X in synch is an
exercise in futility.
	But maybe you are finding that there is already too many IrDA
maintainers.

	I'll send you the Wireless patches, and I'll try to respin the
IrDA patches this afternoon (i.e. please screw me again !).

	Regards,

	Jean
