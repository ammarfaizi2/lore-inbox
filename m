Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbVKTDJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVKTDJG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 22:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVKTDJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 22:09:06 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:7127 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751172AbVKTDJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 22:09:05 -0500
Date: Sun, 20 Nov 2005 04:08:54 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Rob Landley <rob@landley.net>
cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Quick and dirty miniconfig howto, with feature suggestions.
In-Reply-To: <200511170629.42389.rob@landley.net>
Message-ID: <Pine.LNX.4.61.0511192338300.1609@scrub.home>
References: <200511170629.42389.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 17 Nov 2005, Rob Landley wrote:

> 1) Add a "make miniconfig" which works like allnoconfig but A) takes 
> mini.config as its' default name, B) redirects stdout to /dev/null to make it 
> easier to spot typoed symbols, C) aborts (exits with an error, does not write 
> new .config) if mini.config isn't found or if it contains an unrecognized 
> symbol.

I think I better make allnoconfig silent (unless with V=1 or something), 
which makes it your miniconfig already almost like allnoconfig.
I'm not quite sure about aborting there are other error possibilities 
(e.g. new dependencies), so you never quite can trust the error value 
anyway.

> 2) Fix the interaction with O= so that it looks for the mini.config file in 
> the O= directory and not the source directory, so people don't _have_ to 
> specify KCONFIG_ALLCONFIG when building out of tree.

I indeed need to fix this.

bye, Roman
