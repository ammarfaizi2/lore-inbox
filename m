Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVC2R5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVC2R5W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 12:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVC2R5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 12:57:22 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:47881 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261276AbVC2R5S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 12:57:18 -0500
Date: Tue, 29 Mar 2005 19:57:21 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-devel] Re: 2.6.12-rc1-mm3, sound card lost id
Message-Id: <20050329195721.385717aa.khali@linux-fr.org>
In-Reply-To: <s5hr7hyiqra.wl@alsa2.suse.de>
References: <20050325002154.335c6b0b.akpm@osdl.org>
	<20050326111945.5eb58343.khali@linux-fr.org>
	<s5hr7hyiqra.wl@alsa2.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

> > This one made /proc/asound/card0/id change from "Live" to "Unknown"
> > on one of my systems, preventing alsatcl from properly restoring my
> > mixer settings.
> 
> Hmm, perhaps it's a side effect of chip detection patch by James.
> But "Unknown" is bad, of course.
> 
> How does /proc/asound/cards look?

0 [Unknown        ]: EMU10K1 - SB Live [Unknown]
                     SB Live [Unknown] (rev.6, serial:0x80271102) at 0x8800, irq 5

With the bk-alsa patch reverted, it looks like:

0 [Live           ]: EMU10K1 - Sound Blaster Live!
                     Sound Blaster Live! (rev.6, serial:0x80271102) at 0x8800, irq 5

Hope that helps. If you need any additional information, just ask.

Thanks,
-- 
Jean Delvare
