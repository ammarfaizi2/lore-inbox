Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbSLaLQy>; Tue, 31 Dec 2002 06:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbSLaLQy>; Tue, 31 Dec 2002 06:16:54 -0500
Received: from smtp07.iddeo.es ([62.81.186.17]:24460 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S261642AbSLaLQx>;
	Tue, 31 Dec 2002 06:16:53 -0500
Date: Tue, 31 Dec 2002 12:25:16 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre2aa1
Message-ID: <20021231112516.GA1626@werewolf.able.es>
References: <20021226010605.GA4223@dualathlon.random> <20021226151358.GA1607@werewolf.able.es> <200212261626.41204.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200212261626.41204.m.c.p@wolk-project.de>; from m.c.p@wolk-project.de on Thu, Dec 26, 2002 at 16:26:41 +0100
X-Mailer: Balsa 2.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.12.26 Marc-Christian Petersen wrote:
> On Thursday 26 December 2002 16:13, J.A. Magallón wrote:
> 
> Hi J.A.
> 
> > > 	I never noticed this problem before because I rarely use 3d (and usually
> > > 	I had mesasoft setup anyways). It's not specific to a certain graphics
> > > card, so it looks more like an agp generic problem or something, I can
> > > reproduce myself on my laptop i830 graphics card and i830 agp, on my
> > > desktop g450 with amd agp, and on my test box on a ati radeon 7500 and
> > > intel agp, so it doesn't look like a lowlevel driver problem, and it only
> > > hurts while using the agp and/or drm somehow. Many thanks to Srihari
> > > Vijayaraghavan who found the offending patch in the whole kit originally
> > > some time ago.
> > I saw it also using nVidia drivers, that do not touch drm. So I would vote
> > for agpgart.
> try this please.
> 

Sorry to say this, but it just gives me more hangs ;).
Without pte_fast and your patch, I can run gl apps, and even strace gears
(I was trying to know why it takes 4 seconds to show the first image onto
the gl window, and other 4 betwwen a Ctrl-C and the app really dying...)
With both, gl apps lock the box, and strace gears segfaults after a big
mprotect...

Thanks anyways.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre2-jam2 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
