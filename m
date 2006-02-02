Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWBBQTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWBBQTe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWBBQTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:19:34 -0500
Received: from atpro.com ([12.161.0.3]:41227 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S932120AbWBBQTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:19:33 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Thu, 2 Feb 2006 11:18:53 -0500
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060202161853.GB8833@voodoo>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	mrmacman_g4@mac.com, matthias.andree@gmx.de,
	linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
	James@superbug.co.uk, j@bitron.ch, acahalan@gmail.com
References: <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner> <1138642683.7404.31.camel@juerg-pd.bitron.ch> <43DF3C3A.nail2RF112LAB@burner> <1138710764.17338.47.camel@juerg-t40p.bitron.ch> <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail> <43E1EA35.nail4R02QCGIW@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E1EA35.nail4R02QCGIW@burner>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/06 12:17:09PM +0100, Joerg Schilling wrote:
> Jim Crilly <jim@why.dont.jablowme.net> wrote:
> 
> > Every other method to access those devices uses the device name, i.e.
> > mount, fsck, etc, so why should cdrecord be different?
> 
> inadequateness on Linux did force libscg to go this way.
> 

And inadequacies are what's causing libscg and 'cdrecord -scanbus' to fail
to list all IDE devices on Linux. Unless the comments about it stopping the
scan after getting -EPERM on one device are wrong.

> The current method used by libscg is well established since 10 years.

So? Change isn't always a bad thing.

> Now Linux likes to confuse people by trying to enforce a completely 
> incompatible access method.

>From my point of view it's cdrecord that's confusing Linux users by trying
to force a completely different device naming method on users for no good
reason.

> Note that I need to avoid unneeded efforts and for this reason, I need to wait
> 5 years until is is forseable that a recent incompatible change in Linux will
> survive long enough to spent time on it.

I could be wrong, but don't all of the other OSes that cdrecord and
libscg support access the device via the device node? When I mount
a device on Solaris I use /dev/c0t0d0s0 (or whatever it is)and not
0:0:0, right? So it would be safe to assume that users are used to
using that form of names for their devices, so why should cdrecord
be the odd man out?

Jim.
