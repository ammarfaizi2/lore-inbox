Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265660AbUFTVho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265660AbUFTVho (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 17:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265951AbUFTVho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 17:37:44 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:15878 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S265660AbUFTVhm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 17:37:42 -0400
Date: Sun, 20 Jun 2004 23:37:43 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Matroxfb in 2.6 still doesn't work in 2.6.7
Message-ID: <20040620213743.GA6974@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040618211031.GA4048@irc.pl> <20040619190503.GB17053@vana.vc.cvut.cz> <20040619193053.GA3644@irc.pl> <20040619203954.GC17053@vana.vc.cvut.cz> <20040620160437.GA29046@irc.pl> <20040620170114.GA4683@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040620170114.GA4683@vana.vc.cvut.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 07:01:14PM +0200, Petr Vandrovec wrote:
> > > video=matroxfb:vesa:0x11A,right:48,hslen:112,left:248,hslen:112,lower:1,vslen:3,upper:48
> > > maybe with ',sync:3' if +hsync/+vsync are mandatory for your monitor.
> > 
> >  Neither one works. During kernel boot resolution is switched to 1280x1024, but
> > screen become corrupted - there are some green points in upper part of
> > monitor. 
> 
> It works exactly as your kernel is configured. It switched to graphics, but it does
> not paint your console there because you told you kernel to not do that.
> >  Also, the patch from platan do not compile:
> 
> And this one too - my patch needs fbcon.
> > # CONFIG_FRAMEBUFFER_CONSOLE is not set
> 
> Enable this. Into the kernel, not as a module.

 Wow! It works! It not the same mode as in XFree (fb is moved lower by one line),
but it is working!
 I don't think if I've met CONFIG_FRAMEBUFFER_CONSOLE earlier in 2.6.x. Also
method of selecing videomode (vesa:xxx stuff, not plain resolution and bpp) seems
strange and alien, but it works with your patch. 
 When mergin with mainline is planned?

-- 
Tomasz Torcz            There exists no separation between gods and men:
zdzichu@irc.-nie.spam-.pl   one blends softly casual into the other. 

