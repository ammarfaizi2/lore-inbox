Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbULMQWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbULMQWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 11:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbULMQTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 11:19:33 -0500
Received: from witte.sonytel.be ([80.88.33.193]:57843 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261265AbULMQRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 11:17:32 -0500
Date: Mon, 13 Dec 2004 17:14:56 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Pavel Machek <pavel@suse.cz>
cc: Hans Kristian Rosbach <hk@isphuset.no>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>, andrea@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dynamic-hz
In-Reply-To: <20041213161207.GA27352@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.GSO.4.61.0412131713540.16849@waterleaf.sonytel.be>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz>
 <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>
 <20041213030237.5b6f6178.akpm@osdl.org> <1102936790.17227.24.camel@linux.local>
 <20041213112229.GS6272@elf.ucw.cz> <1102942270.17225.81.camel@linux.local>
 <Pine.GSO.4.61.0412131605180.16849@waterleaf.sonytel.be>
 <20041213161207.GA27352@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004, Pavel Machek wrote:
> > > I'm not sure what the above "scedule_timeout(HZ/10)" is supposed to
> > > do, but the parameter it gets in 1000hz is "100" so I assume this
> > > is because we want to wait for 100ms, and in 1000hz that equals
> > > 100 cycles. Correct?
> > 
> > `schedule_timeout(HZ/x)' lets it wait for 1/x'th second.
> 
> ...small problem is that for HZ lower than x it does not wait at all
> :-(.

I know. You better use `(HZ+x-1)/x' for delays.
Integer division can be tricky :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
