Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWFZPBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWFZPBm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWFZPBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:01:42 -0400
Received: from styx.suse.cz ([82.119.242.94]:40400 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932130AbWFZPBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:01:41 -0400
Date: Mon, 26 Jun 2006 17:01:39 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] atkbd: restore autorepeat rate after resume
Message-ID: <20060626150139.GA24550@suse.cz>
References: <Pine.LNX.4.44L0.0606261017340.9467-100000@iolanthe.rowland.org> <d120d5000606260735v6e1762d7mc278f315c3a994fb@mail.gmail.com> <20060626145332.GB24275@suse.cz> <d120d5000606260758m2ee97482m517d432f88975d87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000606260758m2ee97482m517d432f88975d87@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 10:58:46AM -0400, Dmitry Torokhov wrote:
> On 6/26/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> >On Mon, Jun 26, 2006 at 10:35:44AM -0400, Dmitry Torokhov wrote:
> >> On 6/26/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> >> >From: Linus Torvalds <torvalds@osdl.org>
> >> >
> >> >This patch (as728) makes the AT keyboard driver store the current
> >> >autorepeat rate so that it can be restored properly following a
> >> >suspend/resume cycle.
> >> >
> >>
> >> Alan,
> >>
> >> I think it should be a per-device, not global parameter. Anyway, I'll
> >> adjust adn apply, thank you.
> >
> >You can't make it per-device when there is no device when the keyboard
> >isn't plugged in. ;)
> 
> It there is no keyboard then you could not change repeat rate before
> suspending and we don't have anyhting to restore ;)
 
What the patch is trying to achieve is that you have the keyboard, set
the rate, unplug the keyboard, replug the keyboard, get the original
setting.

In the middle of the process, you have no device to attach the
information to. That's why the patch uses a global variable.

-- 
Vojtech Pavlik
Director SuSE Labs
