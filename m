Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVEKSj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVEKSj4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 14:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVEKSj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 14:39:56 -0400
Received: from [212.44.21.71] ([212.44.21.71]:65470 "EHLO
	femailgate.zeus.co.uk") by vger.kernel.org with ESMTP
	id S262006AbVEKSjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 14:39:52 -0400
Subject: Re: ALPS touchpad issues still exist in 2.6.12-rc4
From: Stuart Shelton <stuart@zeus.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Daniel Drake <dsd@gentoo.org>,
       Alan Lake <alan.lake@lakeinfoworks.com>, petero2@telia.co.uk,
       vojtech@suse.cz
In-Reply-To: <200505102059.36744.dtor_core@ameritech.net>
References: <42801AEE.5080308@lakeinfoworks.com>
	 <d120d5000505101520ad1761@mail.gmail.com>
	 <1115767038.12779.36.camel@callisto.dnsalias.net>
	 <200505102059.36744.dtor_core@ameritech.net>
Content-Type: text/plain
Organization: Zeus Technology Ltd.
Date: Wed, 11 May 2005 19:39:38 +0100
Message-Id: <1115836778.18377.5.camel@callisto.dnsalias.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1DVw7P-0002uS-00*4P0SX.M6fQ.* (Zeus Technology Ltd)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-10 at 20:59 -0500, Dmitry Torokhov wrote: 
> > I'm not sure if an updated GPM is the right solution: tapping does very
> > occasionally seem to work (although it might be some facet of the bug
> > that sometimes causes the cursor to appear and select the character
> > beneath it when typing).
> 
> I am not sure if I understand what you saying... Are you saying that you
> tried GPM with proper evdev support and you are seeing some issues or that
> you do not believe that GPM should be touched at all?

That was badly phrased ;)
What I meant was "I'm not sure if GPM is the cause of the behaviour I'm
seeing":

With GPM using "-t ps2" on 2.6.12-rc4, phantom clicks are occasionally
generated when typing, which I've never seen happen before.  Since
tapping didn't otherwise work during this test, it suggests that
something's not quite right...

I'm currently using GPM 1.20.1 - which I believe is the latest release -
which does allow "-t evdev".  Does this need any special configuration
over any other protocol?

> > More than this, with every kernel (at least since the very early 2.4
> > ones) up to 2.6.10 the ALPS touchpad has worked just fine through
> > input/mice or the psaux device - why has this changed in 2.6.11,
> 
> Because some people do not want tapping and some people do not like
> default sensitivity and some like having virtual scrolling while other
> want to have different actions assigned to corner taps.

Perhaps it might be prudent in this case to make the default behaviour
in 2.6.11+ kernels the same as previous kernels?

> > and can the change be reverted before 2.6.12 is released?
> 
> You do not need to wait for 2.6.12:
> 
> 	modprobe psmouse proto=exps
> 
> or boot with "psmouse.proto=exps" if mouse is built as a module.
> 
> On a bit tangent note - anyone is willing to test resync patches? I do not
> have access to ALPS touchpad and that's the one piece of hardware that does
> not want to play nicely...

Ah - I tried using "psmouse.proto=exps2" as a kernel argument before
(with 2.6.11?) and it didn't fix things completely.  This has changed
though, and you're right that in 2.6.12 this completely restores the
original behaviour.

I'm also happy to test any further ALPS patches, if needs be...

