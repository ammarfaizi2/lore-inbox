Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbTLUPSe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 10:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbTLUPSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 10:18:34 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:17842 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263527AbTLUPS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 10:18:29 -0500
Date: Sun, 21 Dec 2003 09:48:13 -0500
From: Ben Collins <bcollins@debian.org>
To: M?ns Rullg?rd <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Firewire/sbp2 troubles with Linux 2.6.0
Message-ID: <20031221144813.GN6607@phunnypharm.org>
References: <yw1x8yl66ecs.fsf@ford.guide> <20031221035348.GM6607@phunnypharm.org> <yw1x4qvumozm.fsf@ford.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1x4qvumozm.fsf@ford.guide>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 11:42:05AM +0100, M?ns Rullg?rd wrote:
> Ben Collins <bcollins@debian.org> writes:
> 
> > On Sun, Dec 21, 2003 at 04:26:11AM +0100, M?ns Rullg?rd wrote:
> >> 
> >> I'm having some trouble connecting a Firewire hard disk box to a
> >> laptop running Linux 2.6.0.  The disk is correctly detected when
> >> connected, and can be mounted.  The problems start when I try to read
> >> large files from the disk.  It will start off reading at about 10
> >> MB/s, which seems a bit slow for Firewire.  The disks I've used are
> >> capable of much more.  That's not the real problem, though.  After a
> >> little while, sometimes as little as 1 MB, sometimes after about 50
> >> MB, the reading will stall and this message is printed in the kernel
> >> log:
> >> 
> >> ieee1394: sbp2: aborting sbp2 command
> >> 0x28 00 03 6f d2 f1 00 00 f8 00 
> >
> > Please try the code in the repo on linux1394.org. I've done a lot of
> > work to sbp2 since my last sync with Linus.
> 
> No difference at all.  What I think is strange, is that small reads or
> reading at a slow rate works perfectly.  Any further ideas?

I've seen that before with an old card that I had. I was forced to
either serialize the serial commands in sbp2, or reduce the max speed to
S200.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
