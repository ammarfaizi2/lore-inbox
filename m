Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVJQLnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVJQLnE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 07:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbVJQLnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 07:43:03 -0400
Received: from styx.suse.cz ([82.119.242.94]:4530 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932282AbVJQLnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 07:43:01 -0400
Date: Mon, 17 Oct 2005 13:42:58 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: emard@softhome.net
Cc: linux-kernel@vger.kernel.org, dtor_core@ameritech.net
Subject: Re: force feedback envelope incomplete
Message-ID: <20051017114258.GC10522@ucw.cz>
References: <20051015213953.GA27117@tink> <200510161335.48458.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510161335.48458.dtor_core@ameritech.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2005 at 01:35:47PM -0500, Dmitry Torokhov wrote:
> On Saturday 15 October 2005 16:39, emard@softhome.net wrote:
> > HI
> > 
> > Force feedback envelope struct in input.h 
> > for periodic events is incomplete.
> > 
> > struct ff_envelope {
> >         __u16 attack_length;    /* Duration of attack (ms) */
> >         __u16 attack_level;     /* Level at beginning of attack */
> >         __u16 fade_length;      /* Duration of fade (ms) */
> >         __u16 fade_level;       /* Level at end of fade */
> > };
> > 
> > The envelope consists of:
> > 1. Attack level (Level at beginning of attack)
> > 2. Attack time
> > 3. Sustain level (Level at end of attack and beginning of fade)
> > 4. Sustain time
> > 5. Fade level (Level at the end of fade)
> > 6. Fade time
> > 
> > If I want to implement proper envelope I propose something like this:
> > 
> > struct ff_envelope {
> >         __u16 attack_length;    /* Duration of attack (ms) */
> >         __u16 attack_level;     /* Level at beginning of attack */
> >         __u16 sustain_length;   /* Duration of sustain (ms) */
> >         __u16 sustain_level;    /* Sustain Level at end of attack and beginning of fade */
> >         __u16 fade_length;      /* Duration of fade (ms) */
> >         __u16 fade_level;       /* Level at end of fade */
> > };
> 
> You might want to talk to Vojtech about this (CC-ed).
 
Your proposal seems reasonable. Please send me a patch that adds the
sustain members to the envelope, and uses it in some driver, while
making sure existing binary-only apps (if there are any) don't break.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
