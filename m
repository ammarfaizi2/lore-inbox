Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbUKGSo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUKGSo1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 13:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbUKGSo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 13:44:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:12718 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261672AbUKGSoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 13:44:22 -0500
Date: Sun, 7 Nov 2004 10:44:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christian Kujau <evil@g-house.de>
cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net,
       perex@suse.cz
Subject: Re: Oops in 2.6.10-rc1
In-Reply-To: <20041107182155.M43317@g-house.de>
Message-ID: <Pine.LNX.4.58.0411071040440.2223@ppc970.osdl.org>
References: <4180F026.9090302@g-house.de> <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz>
 <4180FDB3.8080305@g-house.de> <418A47BB.5010305@g-house.de>
 <418D7959.4020206@g-house.de> <Pine.LNX.4.58.0411062244150.2223@ppc970.osdl.org>
 <20041107130553.M49691@g-house.de> <418E4705.5020001@g-house.de>
 <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org> <20041107182155.M43317@g-house.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Nov 2004, Christian Kujau wrote:

> On Sun, 7 Nov 2004 08:57:40 -0800 (PST), Linus Torvalds wrote
> > 
> > You can check the ALSA tree _before_ the merge, by doing (in 
> > the current tree):
> > 
> > 	bk undo -a1.2000.7.2
> > 
> > which should give you a tree without any of "my" stuff, ie it 
> > was what Jaroslav was working on before he merged it into the 
> > standard tree.
> 
> yes, i already did so, i think:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109979092216919&w=2
> 
> but i did it this way:
>  bk clone -r1.2000.7.1 linux-2.6-BK linux-2.6-BK-test
>  bk undo -a1.2010

Hmm.. That may well have worked fine, but it sounds in that post like you
tried to undo the ALSA stuff, and what I suggested was really to do the
reverse: take _only_ the ALSA changes, and then if it still fails, at
least you have now pinpointed it a bit more (admittedly to the _likely_
source, but that's as it should be: you narrow down the "known bad" source
base until you've narrowed it down to the smallest change you can find
that causes the problem).

> > Yes, that makes me suspicious, and is one reason why I wonder 
> > if it's just your tree not being built right.
> 
> i'll build a -bk snapshot from a tar.bz2 later on and see what it gives.

Sounds like you're doing everything right, but hey, it can't hurt to 
double-check.

		Linus
