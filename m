Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWEaI0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWEaI0O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 04:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWEaI0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 04:26:14 -0400
Received: from smtp1.kolej.mff.cuni.cz ([195.113.24.4]:57872 "EHLO
	smtp1.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964861AbWEaI0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 04:26:13 -0400
X-Envelope-From: zajio1am@artax.karlin.mff.cuni.cz
Date: Wed, 31 May 2006 10:26:05 +0200
From: Ondrej Zajicek <santiago@mail.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060531082605.GA3925@localhost.localdomain>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605272245.22320.dhazelton@enter.net> <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com> <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com> <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz> <20060530223513.GA32267@localhost.localdomain> <447CD367.5050606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447CD367.5050606@gmail.com>
X-Operating-System: Debian GNU/Linux 3.1 (Sarge)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 07:21:11AM +0800, Antonino A. Daplas wrote:
> > 2) To modify appropriate fbdev drivers to not do mode change at startup.
> >    Fill fb_*_screeninfo with appropriate values for text mode instead.
> 
> Most drivers do not change the mode at startup.  Do not load fbcon, and
> you will retain your text mode even if a framebuffer is loaded. 

Yes, but i wrote about _using_ fbcon and fbdev without mode change.

> > 3) (optional) To modify appropriate fbdev drivers to be able to switch
> >    back from graphics mode to text mode.
> 
> And a few drivers already do that, i810fb and rivafb.  Load rivafb or i810fb,
> switch to graphics mode, unload, and you're back to text mode.

I though about being able to explicitly change mode from graphics to text 
(for example when fbdev-only X switch to fbcon) while using fbdev.

-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."
