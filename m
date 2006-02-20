Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161198AbWBTU5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161198AbWBTU5X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbWBTU5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:57:22 -0500
Received: from styx.suse.cz ([82.119.242.94]:14755 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1161189AbWBTU5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:57:21 -0500
Date: Mon, 20 Feb 2006 21:57:29 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i386 AT keyboard LED question.
Message-ID: <20060220205729.GA31639@suse.cz>
References: <200602202003.26642.nick@linicks.net> <20060220202441.GB31272@suse.cz> <200602202051.51882.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602202051.51882.nick@linicks.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 08:51:51PM +0000, Nick Warne wrote:
> On Monday 20 February 2006 20:24, Vojtech Pavlik wrote:
> > On Mon, Feb 20, 2006 at 08:03:26PM +0000, Nick Warne wrote:
> > > Hi Vojtech,
> > >
> > > I wondered why numlock LED goes off during boot process, even though I
> > > ask BIOS to turn on;
> 
> ~snip~
> 
> > Some old notebooks forget them on, which makes the keyboard unusable -
> > you get '4' instead of 'u', etc.
> 
> Understand.  I never thought of that!
> 
> >
> > We can't read the LED state anyway (except for going to the BIOS data
> > structures, which isn't reasonable from the atkbd driver), and we need
> > to initialize it, so off is the safer default.
> >
> > Further, this has been the behavior of Linux since it was first
> > implemented, and thus, in my rewrite of the keyboard handling, I didn't
> > change it.
> 
> Thanks for detailed reply - I see now, and didn't know any of this.
> 
> > It's trivial to change the default lock state in init scripts / xdm
> > config / X config, too.
> 
> I boot into init 3, so as I don't reboot much, I always forget to turn numlock 
> back on when logging in [failed] - hence the question.
> 
> I will look at a local fix rather than a patch for kernel.
 
The 'setleds' command in boot.local might be the fix you're looking for.

-- 
Vojtech Pavlik
Director SuSE Labs
