Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVC2VRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVC2VRd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 16:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVC2VOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 16:14:39 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:65031 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261252AbVC2VNm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 16:13:42 -0500
Date: Tue, 29 Mar 2005 23:13:45 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: James Courtier-Dutton <James@superbug.co.uk>, Takashi Iwai <tiwai@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-devel] Re: 2.6.12-rc1-mm3, sound card lost id
Message-Id: <20050329231345.281e7323.khali@linux-fr.org>
In-Reply-To: <1112129571.5141.18.camel@mindpipe>
References: <20050325002154.335c6b0b.akpm@osdl.org>
	<20050326111945.5eb58343.khali@linux-fr.org>
	<s5hr7hyiqra.wl@alsa2.suse.de>
	<20050329195721.385717aa.khali@linux-fr.org>
	<1112127424.5141.7.camel@mindpipe>
	<20050329224630.069cda56.khali@linux-fr.org>
	<1112129571.5141.18.camel@mindpipe>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

> Here is the patch (against ALSA CVS) in its preferred format.  You
> will probably have to apply it by hand.  If the mixer settings can't
> be restored you'll have to do it manually or edit asound.state by
> hand.
> 
> Lee
> 
> Index: alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
> retrieving revision 1.49
> diff -u -r1.49 emu10k1_main.c
> --- alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c	27 Mar 2005 14:00:54 -0000	1.49
> +++ alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c	29 Mar 2005 20:51:44 -0000
> @@ -693,6 +693,10 @@
>  	 .driver = "EMU10K1", .name = "SBLive! Platinum [CT4760P]", 
>  	 .emu10k1_chip = 1,
>  	 .ac97_chip = 1} ,
> +	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80271102,
> +	 .driver = "EMU10K1", .name = "SBLive! Value [CT4832]", 
> +	 .emu10k1_chip = 1,
> +	 .ac97_chip = 1} ,
>  	{.vendor = 0x1102, .device = 0x0002,
>  	 .driver = "EMU10K1", .name = "SB Live [Unknown]", 
>  	 .emu10k1_chip = 1,

Unsurprisingly, my card is now named CT4832. I had to edit
/etc/asound.state manually to get my mixer settings back (with some
warnings, but I get some sound).

Not sure I quite see the idea of renaming from "Live", which the user
will understand, to (I suppose) the exact chip name on the card, while
the user has certainly no idea what it is. But heh I'm not an ALSA
developer, there must be a good reason.

Thanks,
-- 
Jean Delvare
