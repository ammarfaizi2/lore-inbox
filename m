Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbULCHk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbULCHk4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 02:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbULCHk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 02:40:56 -0500
Received: from mail5.dslextreme.com ([66.51.199.81]:29340 "HELO
	mail5.dslextreme.com") by vger.kernel.org with SMTP id S262086AbULCHkp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 02:40:45 -0500
Subject: Re: [2.6 patch] OSS sb_card.c: no need to include mca.h
From: Paul Laufer <paul@laufernet.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041202005022.GF5148@stusta.de>
References: <20041201215012.GW2650@stusta.de>
	 <1101944325.30819.71.camel@localhost.localdomain>
	 <20041202005022.GF5148@stusta.de>
Content-Type: text/plain
Date: Thu, 02 Dec 2004 16:40:45 -0800
Message-Id: <1102034445.2841.19.camel@trogdor.laufernet.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mca.h is not needed in sb_card.c in 2.6.

At one point I thought I would include the 2.4 MCA code in the sb_card.c
rewrite for 2.6. The file was rewritten due to the ISAPnP interface
changes that came in mid 2.5, and the ugly state of the 2.4 code. I
ended up leaving the MCA code out because I didn't have any machines to
test it on, and didn't know of anyone interested in testing it. It
should be fairly trivial to re-integrate. It was only a few tens of
lines and fairly self-contained if I recall correctly.

Note, I'm not on LKML at this time since I'm concentrating on my
Master's degree.

Also, this is the correct address to reach me at, as noted at the top of
sb_card.c. Linus rejected my CREDITS file patches the last few times I
sent them in, so the address there is invalid.

-Paul

On Thu, 2004-12-02 at 01:50 +0100, Adrian Bunk wrote:
> On Wed, Dec 01, 2004 at 11:38:47PM +0000, Alan Cox wrote:
> > On Mer, 2004-12-01 at 21:50, Adrian Bunk wrote:
> > > I didn't find any reason why this file includes mca.h .
> > > 
> > 
> > It certainly used to need it to build MCA bus soundblaster support.
> > Whether it still does in 2.6 I don't know. I assume you tried an MCA
> > build of OSS ?
> 
> Yes, I did.
> 
> And a
> 
>   grep -ri mca sound/oss/*
> 
> only found false positives (nmcard_list, numcards).
> 
> cu
> Adrian
> 
-- 
Paul Laufer <paul@laufernet.com>

