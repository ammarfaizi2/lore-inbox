Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVC2UUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVC2UUl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVC2USa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:18:30 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:31717 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261350AbVC2URF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:17:05 -0500
Subject: Re: [Alsa-devel] Re: 2.6.12-rc1-mm3, sound card lost id
From: Lee Revell <rlrevell@joe-job.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: James Courtier-Dutton <James@superbug.co.uk>, Takashi Iwai <tiwai@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, Jaroslav Kysela <perex@suse.cz>
In-Reply-To: <20050329195721.385717aa.khali@linux-fr.org>
References: <20050325002154.335c6b0b.akpm@osdl.org>
	 <20050326111945.5eb58343.khali@linux-fr.org> <s5hr7hyiqra.wl@alsa2.suse.de>
	 <20050329195721.385717aa.khali@linux-fr.org>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 15:17:04 -0500
Message-Id: <1112127424.5141.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 19:57 +0200, Jean Delvare wrote:
> Hi Takashi,
> 
> > > This one made /proc/asound/card0/id change from "Live" to "Unknown"
> > > on one of my systems, preventing alsatcl from properly restoring my
> > > mixer settings.
> > 
> > Hmm, perhaps it's a side effect of chip detection patch by James.
> > But "Unknown" is bad, of course.
> > 
> > How does /proc/asound/cards look?
> 
> 0 [Unknown        ]: EMU10K1 - SB Live [Unknown]
>                      SB Live [Unknown] (rev.6, serial:0x80271102) at 0x8800, irq 5
> 
> With the bk-alsa patch reverted, it looks like:
> 
> 0 [Live           ]: EMU10K1 - Sound Blaster Live!
>                      Sound Blaster Live! (rev.6, serial:0x80271102) at 0x8800, irq 5
> 
> Hope that helps. If you need any additional information, just ask.

I think we just have to add this PCI id to the table.  I got the same
result before James added the SBLive! platinum detection.

What is the output of 'lspci -v | grep -1 EMU10k1'?

Lee

