Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWDJRWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWDJRWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 13:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWDJRWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 13:22:22 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:61705 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750874AbWDJRWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 13:22:22 -0400
Date: Mon, 10 Apr 2006 19:22:14 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, perex@suse.cz, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] move EXPORT_SYMBOL's away from sound/pci/emu10k1/emu10k1_main.c
Message-ID: <20060410172214.GA8612@mars.ravnborg.org>
References: <20060407003105.GG7118@stusta.de> <s5hu095y367.wl%tiwai@suse.de> <20060407184909.GB9097@mars.ravnborg.org> <s5hodz992lx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hodz992lx.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2006 at 11:55:22AM +0200, Takashi Iwai wrote:
 > > > This patch moves the EXPORT_SYMBOL's from 
> > > > sound/pci/emu10k1/emu10k1_main.c to the files with the actual functions.
> > > 
> > > What is the merit of this movement?
> > 
> > 1) Documentation - it is obvious that the function/data is exported so
> > be a bit mroe careful when introducing changes
> > 2) Style. In 2.6 the preferred style is to put the EXPORT_SYMBOL on the
> > line following the closing } of the exported function.
> > 3) Keep changes local. If one removes a previously exported symbol less
> > files needs to be touched.
> 
> I know the above for the new codes, yes.  But my question is wheter do
> we get a good enough benifit by changing the existing code.
> 
> I'm not against such an action but just wornder whether it's really
> needed.  If yes, we should do it over the whole tree.
That has been done to a lot of existing code also.
In the 2.4 days it made sense to have them grouped due to build system
limitations - that is no longer the case with 2.6 so it is preferred to
do it correct.

	Sam
