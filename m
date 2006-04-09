Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWDIVZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWDIVZz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 17:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWDIVZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 17:25:55 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:37392 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750700AbWDIVZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 17:25:54 -0400
Date: Sun, 9 Apr 2006 23:25:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/19] kconfig: recenter menuconfig
Message-ID: <20060409212548.GA30208@mars.ravnborg.org>
References: <Pine.LNX.4.64.0604091726550.23116@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604091726550.23116@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2006 at 05:27:14PM +0200, Roman Zippel wrote:
> 
> Move the menuconfig output more into the centre again, it's using a
> fixed position depending on the window width using the fact that the
> menu output has to work in a 80 chars terminal.
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
NACK.
With this change when window width is > 80 then we waste half of
the screen width only to right-indent the menus.

We truncate longer prompts and with this we require twice the
width to see full prompt.

One could argue that the old ITEM_IDENT should be 0 instead of 1,
avoiding wasting an extra char. But with this change we waste
a lot of space.

	Sam
