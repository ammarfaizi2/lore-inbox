Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWBCPyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWBCPyt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 10:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWBCPyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 10:54:49 -0500
Received: from hummeroutlaws.com ([12.161.0.3]:5386 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1750842AbWBCPys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 10:54:48 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Fri, 3 Feb 2006 10:53:50 -0500
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: acahalan@gmail.com, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       James@superbug.co.uk, j@bitron.ch
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060203155349.GA9301@voodoo>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	acahalan@gmail.com, mrmacman_g4@mac.com, matthias.andree@gmx.de,
	linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
	James@superbug.co.uk, j@bitron.ch
References: <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail> <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner> <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com> <43E374CF.nail5CAMKAKEV@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43E374CF.nail5CAMKAKEV@burner>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/06 04:20:47PM +0100, Joerg Schilling wrote:
> Albert Cahalan <acahalan@gmail.com> wrote:
> 
> > On 2/2/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> > > "Jim Crilly" <jim@why.dont.jablowme.net> wrote:
> > >
> > > > I see the same thing with, the only external kernel patch I have
> > > > applied is Suspend2. The ATA scanbus code tries to
> > > > open("/dev/hda", O_RDWR|O_NONBLOCK|O_EXCL) and that fails, and since
> > >
> > > This is not cdrecord but a bastardized version......
> >
> > True enough, but it would work great if you'd fix that bug
> > that makes cdrecord give up while scanning. I guess
> > that's one more patch Debian will be applying.
> 
> As including O_EXCL would disallow to use more than one cdrecord
> program at the same time, there is no chance for the mains stream source.

Maybe I'm just being thick, but wouldn't that only prevent you from using
cdrecord on the same device multiple times? The only thing I can see being
opened with O_EXCL is the target device.

> > Using O_EXCL is kind of broken, because you'll need to
> > retry any failures, but that's life. You hacked cdrecord to
> > properly interact with the Solaris volume manager. You
> > can do the same for HAL.
> 
> Well the big difference with Solaris is that several modifications have been 
> applied by Sun to the vold sub-system on Solaris in order to decently 
> support cdrecord.
> 
> The last change was done with Nevada Build 21 in August 2005.
> 
> It makes sense for Linux not to ignore CD/DVD writing. Solaris also did
> chose not to ignore cdrecord.
> 
> Jörg

A bug in HAL is not a bug in Linux. If the HAL people need to make some
changes to their daemon to make it play nice with cdrecord and the like
that's fine, but telling people here makes no sense.

Jim.
