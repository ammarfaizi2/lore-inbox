Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbVKLXty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbVKLXty (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 18:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbVKLXty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 18:49:54 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:7572 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964886AbVKLXty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 18:49:54 -0500
Date: Sun, 13 Nov 2005 00:49:34 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Rob Landley <rob@landley.net>
cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Why did oldconfig's behavior change in 2.6.15-rc1?
In-Reply-To: <200511121731.25982.rob@landley.net>
Message-ID: <Pine.LNX.4.61.0511130042530.1610@scrub.home>
References: <200511121656.29445.rob@landley.net> <200511121731.25982.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 12 Nov 2005, Rob Landley wrote:

> Why did oldconfig switch off CONFIG_MODE_SKAS?  It didn't do that before.  
> Hmmm...  Rummage, rummage...  Darn it, it's position dependent.  _And_ 
> version dependent.

It's _not_ position dependent, but the behaviour with multiple equal 
symbols is undefined.

> Ok, now I have to put the new entries at the _beginning_.  Appending them 
> doesn't work anymore, it now ignores any symbol it's already seen, so you 
> can't easily start with allnoconfig, switch on just what you want, and expect 
> oldconfig to do anything intelligent.

Now you can put them in allno.config instead and allnoconfig will do the 
right thing.

bye, Roman
