Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318184AbSHUKSb>; Wed, 21 Aug 2002 06:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318182AbSHUKSb>; Wed, 21 Aug 2002 06:18:31 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:41146 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318184AbSHUKSa>;
	Wed, 21 Aug 2002 06:18:30 -0400
Date: Wed, 21 Aug 2002 12:17:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
       Anton Altaparmakov <aia21@cantab.net>, alan@lxorguk.ukuu.org,
       Andre Hedrick <andre@linux-ide.org>, axboe@suse.de, bkz@linux-ide.org,
       linux-kernel@vger.kernel.org
Subject: Re: IDE?
Message-ID: <20020821121747.A3801@ucw.cz>
References: <Pine.SOL.3.96.1020817004411.25629B-100000@draco.cus.cam.ac.uk> <Pine.LNX.4.44.0208161706390.1674-100000@home.transmeta.com> <20020818131515.A15547@ucw.cz> <1029672964.15858.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1029672964.15858.17.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sun, Aug 18, 2002 at 01:16:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2002 at 01:16:04PM +0100, Alan Cox wrote:
> On Sun, 2002-08-18 at 12:15, Vojtech Pavlik wrote:
> > I'll make patches for 2.5 to bring the low-level driver cleanups back.
> > Not just piix.c - also aec62xx.c and amd74xx.c - the last one was in 2.5
> > for a LONG time already and I'm not particularly happy it got lost.
> > 
> > If desirable (What's your opinion, Alan?) I can make equivalent patches
> > for 2.4 as well.
> 
> Look at 2.4.20-pre2-ac3 before you start doing that. A lot of cleanup
> has been done, although there is plenty more left. A starter is to fix
> the the ratemask/ratefilter stuff to not use silly while loops on the
> aec/amd drivers if you are hacking on those, stick in the static
> variables and document anything relevant looking.
> 
> Simple stuff first.

I have completely rewritten (and very well tested) versions of the amd
and piix pci ide drivers.

I'm now looking through 2.4.20-pre2-ac5 and your version of via82cxxx.c,
and all looks quite good to me, except for some of the indentation
changes which seem to make the code fit into 78 columns at the loss of
readability. Was the file run through indent?

I'm planning to adapt the amd and piix driver to the new framework for
IDE drivers and then send you a patch.

-- 
Vojtech Pavlik
SuSE Labs
