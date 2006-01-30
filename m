Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWA3RIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWA3RIU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWA3RIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:08:20 -0500
Received: from mail.gmx.net ([213.165.64.21]:58544 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964795AbWA3RIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:08:19 -0500
X-Authenticated: #428038
Date: Mon, 30 Jan 2006 18:08:13 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: acahalan@gmail.com, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       bzolnier@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
Message-ID: <20060130170813.GG19173@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	acahalan@gmail.com, mrmacman_g4@mac.com,
	linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
	bzolnier@gmail.com
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <43DCA097.nailGPD11GI11@burner> <20060129112613.GA29356@merlin.emma.line.org> <Pine.LNX.4.61.0601292139080.2596@yvahk01.tjqt.qr> <43DD2A8A.nailGVQ115GOP@burner> <787b0d920601291328k52191977h3778a7c833d640f2@mail.gmail.com> <43DE3A99.nail16ZK1MAWN@burner> <787b0d920601300831j99fae82n5d4a5d94f99baafd@mail.gmail.com> <43DE405D.nail2AM2BPF20@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DE405D.nail2AM2BPF20@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-01-30:

> Albert Cahalan <acahalan@gmail.com> wrote:
> 
> > On 1/30/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> > > Albert Cahalan <acahalan@gmail.com> wrote:
> > >
> > > > Let's address the second bug first. Linux provides full
> > > > bus number and LUN info for all block devices. You get it
> > > > like this:
> > > >
> > > > struct stat sbuf;
> > > > stat("/dev/hdc", &sbuf);
> > > > int bus = sbuf.st_mode>>12;
> > > > int target = major(sbuf.st_rdev);
> > > > int lun = minor(sbuf.st_rdev);
> > >
> > > Now tell me how to match this with information from /dev/sg*
> >
> > You do the obvious, scanning /dev to find the device file.
> 
> I am sorry, but you obviously did not understand the problem.

Stop offending people who are trying to be helpful just because they
suggest different solutions than you expect. You - again - elided
Albert's crucial part, which even included an offer to fix things:

: If you need to map from /dev/hd* to /dev/sg*, then you have
: found a bug. Explain what must be added to /dev/hd* so that
: you don't need to go messing with /dev/sg* anymore.

-- 
Matthias Andree
