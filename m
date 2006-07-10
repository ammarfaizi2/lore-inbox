Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWGJL0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWGJL0Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWGJL0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:26:25 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:23516 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP id S1751353AbWGJL0Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:26:24 -0400
Date: Mon, 10 Jul 2006 13:28:10 +0200
From: Adam =?ISO-8859-2?B?VGxhs2th?= <atlka@pg.gda.pl>
To: Lee Revell <rlrevell@joe-job.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       perex@suse.cz, alan@lxorguk.ukuu.org.uk
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round (v2)
Message-Id: <20060710132810.551a4a8d.atlka@pg.gda.pl>
In-Reply-To: <1152458300.28129.45.camel@mindpipe>
References: <20060707231716.GE26941@stusta.de>
	<p737j2potzr.fsf@verdi.suse.de>
	<1152458300.28129.45.camel@mindpipe>
Organization: Gdansk University of Technology
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Jul 2006 11:18:19 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> On Sat, 2006-07-08 at 01:50 +0200, Andi Kleen wrote:
> > Adrian Bunk <bunk@stusta.de> writes:
> > > 
> > > Q: What about the OSS emulation in ALSA?
> > > A: The OSS emulation in ALSA is not affected by my patches
> > >    (and it's not in any way scheduled for removal).
> > 
> > I again object to removing the old ICH sound driver.
> > It does the same as the Alsa driver in much less code and is ideal
> > for generic monolithic kernels
> 
> It doesn't do the same thing - software mixing is impossible with OSS.

Only GPL'ed version has this limitation - its just not implemented because all this
GPL'ed OSS is abandoned.
The commercial version from www.opensound.com does input/output mixing
in software in kernel space.
It is free for home/personal use and only one thing you must do is to update
it regularly - once every 4 months. It works out of the box with 2.6.xx kernels and you don't
need additional sound daemons or hidden library threads (ALSA approach).
It has included scripts for module compilation in case of kernel change
and you can also have automatic updates and mixer settings restore without need
for instaling additional software packages.
It has also text and graphical configuration tools and mixers.
So users have still a choise and they will chose a product which best fits they needs.

>From my point of view ALSA has many advantages if you want to dig in the card driver
buffers/period etc. settings but lacks ease of use and some of simple in theory
functionality is a pain - device enumeration or switching output mode/device
without restarting apps or rewritting them so they have special function for that purpose.

esd, arts, jackd, polypd and other prove that ALSA is not enough
and its functionality is far from perfect.

We have more and more audio devices - USB and Bluetooth ones - and
we need switch ouput from one to other device without changes in apps.

So better is to have some virtual sound device, then some mixing/effects/plugins
modules and then true sound device or network stream. Normal app just doesn't
need to now mutch about sound device. It just sets basic audio parameters
and plays. Is ALSA going in that direction?

ALSA api is too complicated - too many possibilities to obtain the same effect -
and additionaly there is no good docs how to use this api properly.
Some methods don't work in some situactions - callback method for example uses signals
and in case of apps which turns some signals off there will be no sound at all.

Developers of ALSA say that they have no time to write docs. True - but including in kernel
some functionality for which users have no good docs is not good for anybody.
We have many programs which use ALSA and don't work properly.
Forcing users to use ALSA is some kind of misunderstanding in this situaction.

We have also almost no docs about ALSA drvier <-> ALSA lib interface which is a strange
in case of GPL'ed software if we want to implement a new hw driver.

So is ALSA really what the users need? The future is unknown.
 
Regards
-- 
Adam Tla³ka       mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
Computer Center,  Gdañsk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl
