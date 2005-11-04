Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbVKDNMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbVKDNMa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 08:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbVKDNMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 08:12:30 -0500
Received: from styx.suse.cz ([82.119.242.94]:37861 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751419AbVKDNM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 08:12:29 -0500
Date: Fri, 4 Nov 2005 14:12:28 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-joystick@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] drivers/input/: possible cleanups
Message-ID: <20051104131228.GA5208@ucw.cz>
References: <20051104123541.GC5587@stusta.de> <20051104124207.GA4937@ucw.cz> <20051104125742.GE5587@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104125742.GE5587@stusta.de>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 01:57:42PM +0100, Adrian Bunk wrote:

> On Fri, Nov 04, 2005 at 01:42:07PM +0100, Vojtech Pavlik wrote:
> > On Fri, Nov 04, 2005 at 01:35:41PM +0100, Adrian Bunk wrote:
> > > This patch contains the following possible cleanups:
> > > - make needlessly glbal code static
> > 
> > Agreed.
> > 
> > > - gameport/gameport: #if 0 the unused global function gameport_reconnect
> > 
> > That one should be an EXPORT_SYMBOL() API. If the export is missing,
> > then that's the bug that needs to be fixed.
> >...
> 
> There isn't even a header providing a function prototype which is quite 
> strange for a part of an API.
 
It's a planned API (a mirror of what the serio abstraction does), the
drivers don't use it yet.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
