Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272144AbTHDS64 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 14:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272152AbTHDS64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 14:58:56 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:9732 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S272144AbTHDS6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 14:58:38 -0400
Subject: Re: [PATCH] O13int for interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: kernel@kolivas.org
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1060023104.889.7.camel@teapot.felipe-alfaro.com>
References: <200307280112.16043.kernel@kolivas.org>
	 <200307281808.h6SI8C5k004439@turing-police.cc.vt.edu>
	 <20030728114041.2c8ce156.akpm@osdl.org>
	 <1060023104.889.7.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Message-Id: <1060023516.511.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 04 Aug 2003 20:58:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-04 at 20:51, Felipe Alfaro Solana wrote:
> Bad news, I guess...
> 
> I'm experiencing XMMS skips with 2.6.0-test2-mm4 + O13int patch. They
> are easily reproducible when browsing through the menus of
> KDE/Konqueror.
> 
> My KDE session is configured with the Keramik style, using XRender
> transparencies and drop-down shadows for the menus. When browsing the
> "Bookmarks" Konqueror drop-down menu, XMMS pauses audio playback very
> briedly. The skip starts at the moment at which I click the "Bookmarks"
> menu and lasts until the menu is displayed completely on the screen. My
> Konqueror "Bookmarks" menu is really big, occupying almost the entire
> screen height (over 700 pixels).
> 
> The XMMS skips can also be reproduced while navigating through web pages
> that require a lot of CPU horsepower, like for example,
> http://www.3dwallpapers.com. When browsing through the nice wallpapers
> at the site, Konqueror hogs the CPU and XMMS starts skipping.
> 
> Both scenarios can be reproduced with either XMMS or MPlayer, so I guess
> is not an isolated problem with an specific player. Also, the XMMS skips
> are not reproducible with previous releases of your scheduler patches.
> 
> Hope this helps!

OK, I had the X server reniced at -20... Renicing the X server at +0
makes the XMMS skips disappear. At least, with X at +0 I've been able to
reproduce them anymore.


