Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTFFSeq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 14:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbTFFSeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 14:34:46 -0400
Received: from pc-80-192-208-23-mo.blueyonder.co.uk ([80.192.208.23]:41959
	"EHLO efix.biz") by vger.kernel.org with ESMTP id S262174AbTFFSeo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 14:34:44 -0400
Subject: Re: 2.5.70 latest: breaks gnome
From: Edward Tandi <ed@efix.biz>
To: Andrew Morton <akpm@digeo.com>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030605154534.355380e1.akpm@digeo.com>
References: <20030604142241.0dc6f34e.shemminger@osdl.org>
	 <3EDE7398.70005@tmsusa.com> <20030605111212.33e63d46.shemminger@osdl.org>
	 <3EDFB3E2.2090308@tmsusa.com> <20030605143346.197a8923.akpm@digeo.com>
	 <3EDFBD08.5060902@tmsusa.com> <1054852458.1886.18.camel@wires.home.biz>
	 <20030605154534.355380e1.akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1054925329.2215.18.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 06 Jun 2003 19:48:49 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-05 at 23:45, Andrew Morton wrote:
> Edward Tandi <ed@efix.biz> wrote:
> >
> > FYI,
> > 
> > I have just tried mm5. I have Gnome2 working (using kdm) but am still
> > having the same problems as mm3:
> 
> It would be very interesting to know if these things still happen with just
> 2.5.70 plus
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm5/broken-out/linus.patch

OK, I've now tried it. Results follow...

> > 1) gnome-terminal still only works as root.
> 
> Don't know.

Still only works as root. I do get a message though:

(gnome-terminal:2280): GnomeUI-WARNING **: While connecting to session
manager: Authentication Rejected, reason : None of the authentication
protocols specified are supported and host-based authentication failed.

> > 2) xosview still freezes (reading /proc/*)
> 
> We changed the format of /proc/stat and broke xosview.  I just tried 1.8.0,
> not joy.

Got patch now :-) no longer an issue.

> > 3) rmmod still not working -"Can't open 'analog': No such file or
> > directory"
> 
> need more details on this.

It's from a Mandrake package (if that means anything to you):
Name: module-init-tools
Version: 0.9.9-1mdk

> > 4) su - <user> returns "operation not permitted". Works as root though
> > and thereafter as <user>.
> 
> Don't know.

This no longer gives me a problem. Not sure why though.

> > 5) This is the second time this has happened after switching to 2.5.x;
> > My Evolution groups (left-hand icon bar) have gone missing.
> 
> Don't know.  2.5 might be triggering latent bugs in evolution.  It's
> happened before..

It's just happened again! Looks like it's reproducible.

> > 6) from /var/log/messages: /sbin/mingetty[2583]: /dev/tty4: cannot open
> > tty: Inappropriate ioctl for device
> 
> Don't know.

Problem still there.

> > 7) Excessive "anticipatory scheduling elevator" messages allover in
> > /var/log/messages.
> 
> Will fix sometime.

OK, happy.

> > 8) from dmesg: process `named' is using obsolete setsockopt SO_BSDCOMPAT
> 
> Overly noisy warning.  How frequently do they occur?

Not so bad, only 3 times when named starts. I suspect the Linux vendors
will fix it eventually.

> > I think there is something "not quite right" in the terminal I/O area.
> 
> Tracking down the kernel version at which this started to occur would be
> good.

It could go back a long way. I've been having this problem from around
2.5.69. Before that I had real problems building. And then building
anything that worked on my hardware.

Ed-T.


