Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWBCPW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWBCPW2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 10:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWBCPW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 10:22:28 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:24449 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750815AbWBCPW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 10:22:27 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 03 Feb 2006 16:20:47 +0100
To: schilling@fokus.fraunhofer.de, acahalan@gmail.com
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de,
       James@superbug.co.uk, j@bitron.ch
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43E374CF.nail5CAMKAKEV@burner>
References: <43DDFBFF.nail16Z3N3C0M@burner>
 <1138710764.17338.47.camel@juerg-t40p.bitron.ch>
 <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail>
 <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
 <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
 <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr>
 <20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner>
 <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com>
In-Reply-To: <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <acahalan@gmail.com> wrote:

> On 2/2/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> > "Jim Crilly" <jim@why.dont.jablowme.net> wrote:
> >
> > > I see the same thing with, the only external kernel patch I have
> > > applied is Suspend2. The ATA scanbus code tries to
> > > open("/dev/hda", O_RDWR|O_NONBLOCK|O_EXCL) and that fails, and since
> >
> > This is not cdrecord but a bastardized version......
>
> True enough, but it would work great if you'd fix that bug
> that makes cdrecord give up while scanning. I guess
> that's one more patch Debian will be applying.

As including O_EXCL would disallow to use more than one cdrecord
program at the same time, there is no chance for the mains stream source.

> Using O_EXCL is kind of broken, because you'll need to
> retry any failures, but that's life. You hacked cdrecord to
> properly interact with the Solaris volume manager. You
> can do the same for HAL.

Well the big difference with Solaris is that several modifications have been 
applied by Sun to the vold sub-system on Solaris in order to decently 
support cdrecord.

The last change was done with Nevada Build 21 in August 2005.

It makes sense for Linux not to ignore CD/DVD writing. Solaris also did
chose not to ignore cdrecord.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
