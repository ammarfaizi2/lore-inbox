Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbTLUTTJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 14:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263904AbTLUTTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 14:19:09 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:57267 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263895AbTLUTTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 14:19:05 -0500
Date: Sun, 21 Dec 2003 13:48:40 -0500
From: Ben Collins <bcollins@debian.org>
To: M?ns Rullg?rd <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Firewire/sbp2 troubles with Linux 2.6.0
Message-ID: <20031221184840.GR6607@phunnypharm.org>
References: <yw1x8yl66ecs.fsf@ford.guide> <20031221035348.GM6607@phunnypharm.org> <yw1x4qvumozm.fsf@ford.guide> <20031221144813.GN6607@phunnypharm.org> <yw1xn09mkvs9.fsf@ford.guide> <20031221183132.GP6607@phunnypharm.org> <yw1x4qvu6l9g.fsf@ford.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1x4qvu6l9g.fsf@ford.guide>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm guessing that your card doesn't like getting some many commands at
> > once. It's possible that your sbp2 device itself cannot handle it
> > (generally, I've found it to be caused by the card though).
> 
> Is it possible to set the limit somewhere between the default and
> complete serialization?  Shouldn't it be possible to detect such
> things automatically, somehow?

Things are attempted to be detected, but somehow that only works 95% of
the time. I'd blame bad sbp2 devices, but I don't have anything to back
that up. You can look in sbp2.c to see where it sets the max commands.

> > As far as 10mbs, you have to remember that even though firewire is much
> > higher than that, your drive is still an IDE, and the firewire is still
> > going through an IDE bridge. So the limitation lies in the IDE bridge.
> > I've seen performance as high as 34MB/s with good IDE bridges and
> > drives, though.
> 
> The disks will easily do 40 MB/s on a good IDE controller.  It seems
> like a rather bad bridge to me if it has that much overhead.  I
> haven't seen many different options for sale, either.

Most things based on newer Oxford chips seem to work pretty well. What
ohci1394 controller do you have though?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
