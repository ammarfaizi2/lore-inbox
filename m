Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbUKGSbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbUKGSbO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 13:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbUKGSbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 13:31:14 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:41406 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261670AbUKGSbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 13:31:08 -0500
From: "Christian Kujau" <evil@g-house.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net,
       perex@suse.cz
Reply-To: evil@g-house.de
Subject: Re: Oops in 2.6.10-rc1
Date: Sun, 7 Nov 2004 19:31:03 +0100
Message-Id: <20041107182155.M43317@g-house.de>
In-Reply-To: <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org>
References: <4180F026.9090302@g-house.de> <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz> <4180FDB3.8080305@g-house.de> <418A47BB.5010305@g-house.de> <418D7959.4020206@g-house.de> <Pine.LNX.4.58.0411062244150.2223@ppc970.osdl.org> <20041107130553.M49691@g-house.de> <418E4705.5020001@g-house.de> <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org>
X-Mailer: Open WebMail 2.41 20040926
X-OriginatingIP: 195.126.66.126 (evil)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Nov 2004 08:57:40 -0800 (PST), Linus Torvalds wrote
> 
> You can check the ALSA tree _before_ the merge, by doing (in 
> the current tree):
> 
> 	bk undo -a1.2000.7.2
> 
> which should give you a tree without any of "my" stuff, ie it 
> was what Jaroslav was working on before he merged it into the 
> standard tree.

yes, i already did so, i think:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109979092216919&w=2

but i did it this way:
 bk clone -r1.2000.7.1 linux-2.6-BK linux-2.6-BK-test
 bk undo -a1.2010

(probably wrong, so i'll repeat it as you suggeseted)

> (BK revision numbers change on merges, so the above number is 
> not necessarily the right one unless you have the current -bk 

aha!

> A quick suggestion: make sure that there is not some stale 
> object file lying around confusing things about memory layout, 
> and do a "make clean" and make sure that all old modules are 
> clean too and re-installed.

really: i always do "make clean", even "make mrproper" sometimes, just
to be sure. and i am quite certain, that i did not forget to install the
modules. but i'll keep my eyes open, yes.

> The kernel dependencies should be correct, but even then there can be
> problems with clocks that are off a bit etc.

i'm updating via "ntpdate" on every boot. i am even using a (faster) 2nd
machine for my build and the bk things right now: building a current -bk
on boths hosts gives me this error.

> Yes, that makes me suspicious, and is one reason why I wonder 
> if it's just your tree not being built right.

i'll build a -bk snapshot from a tar.bz2 later on and see what it gives.

> There are different revision numbers: there's the revision 
> number for the _file_, and there is the revision number for 
> the _change_.

aha. it was kinda confusing...now i got it, i think ;)

again: thank you for your time on this rainy weekend,
Christian.
-- 
BOFH excuse #8:

static buildup
