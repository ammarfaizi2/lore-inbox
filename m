Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWDGStp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWDGStp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWDGSto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:49:44 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:32266 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964882AbWDGSt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:49:28 -0400
Date: Fri, 7 Apr 2006 20:49:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, perex@suse.cz, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] move EXPORT_SYMBOL's away from sound/pci/emu10k1/emu10k1_main.c
Message-ID: <20060407184909.GB9097@mars.ravnborg.org>
References: <20060407003105.GG7118@stusta.de> <s5hu095y367.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hu095y367.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 02:34:56PM +0200, Takashi Iwai wrote:
> At Fri, 7 Apr 2006 02:31:05 +0200,
> Adrian Bunk wrote:
> > 
> > This patch moves the EXPORT_SYMBOL's from 
> > sound/pci/emu10k1/emu10k1_main.c to the files with the actual functions.
> 
> What is the merit of this movement?

1) Documentation - it is obvious that the function/data is exported so
be a bit mroe careful when introducing changes
2) Style. In 2.6 the preferred style is to put the EXPORT_SYMBOL on the
line following the closing } of the exported function.
3) Keep changes local. If one removes a previously exported symbol less
files needs to be touched.

	Sam
