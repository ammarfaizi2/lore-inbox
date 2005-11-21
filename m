Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVKUVRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVKUVRd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVKUVRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:17:33 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:61014 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1750726AbVKUVRc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:17:32 -0500
Subject: Re: Linux 2.6.15-rc2
From: Kasper Sandberg <postmaster@metanurb.dk>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200511201858.32171.gene.heskett@verizon.net>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
	 <200511200018.11791.gene.heskett@verizon.net>
	 <1132526214.15938.5.camel@localhost>
	 <200511201858.32171.gene.heskett@verizon.net>
Content-Type: text/plain
Date: Mon, 21 Nov 2005 22:17:25 +0100
Message-Id: <1132607845.15938.30.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-20 at 18:58 -0500, Gene Heskett wrote:
> On Sunday 20 November 2005 17:36, Kasper Sandberg wrote:
> >On Sun, 2005-11-20 at 00:18 -0500, Gene Heskett wrote:
> >> On Saturday 19 November 2005 22:40, Linus Torvalds wrote:
> >> >There it is (or will soon be - the tar-ball and patches are still
> >> >uploading, and mirroring can obviously take some time after that).
> >>
> >> First breakage report, tvtime, blue screen no audio.  Trying slightly
> >> different .config for next build.  My tuner (OR51132) seems to be
> >> permanently selected in an xconfig screen.  Dunno if thats good or
> >> bad ATM.
> >
> >if it needs to be loaded with a parameter you will need to build it as
> > a module.. my saa7134 chip needs card=9.
> 
> Its never needed an argument before.
then you have a good card, mine is a cheap cheap cheap one which
apparently doesent have the nessecary embedded info to do proper
autodetection, so i gotta manually specify which card i have.

> 
> >i am experiencing same problems with saa7134, no video, however i do
> > get audio.
> 
> I wasn't, total digital gibberish on screen.
> 
> A full powerdown reboot to 2.6.14.2 fixed it.
> 
> >this is a way to (incorrectly according to v4l devs) "fix" it:
> >drivers/media/video/video-buf.c
> >change line 1233 to this:
> >        vma->vm_flags |= VM_DONTEXPAND;
> 

