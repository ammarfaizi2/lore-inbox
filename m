Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263645AbUE3NYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbUE3NYN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 09:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbUE3NYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 09:24:13 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:51144 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S263645AbUE3NYL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 09:24:11 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: Linux 2.6.7-rc2
Date: Sun, 30 May 2004 13:24:11 +0000 (UTC)
Organization: Cistron
Message-ID: <c9cn9r$nod$1@news.cistron.nl>
References: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org> <c9c42l$228$1@news.cistron.nl> <20040530130902.A2756@electric-eye.fr.zoreil.com> <c9cmru$nju$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1085923451 24333 62.216.30.38 (30 May 2004 13:24:11 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny ter Haar <dth@ncc1701.cistron.net> wrote:
>Francois Romieu  <romieu@fr.zoreil.com> wrote:
>>> Ethernet stopped working (for me) going from 2.6.7-rc1-bk3 to 2.6.7-rc2.
>>> AMD64/asusK8V with onboard ethernet.
>>> 2.6.7-rc1-bk3 worked like intended.

>make menuconfig i cannot get into the submenu 
>device drivers -> 
> networking support -> 
>  Gigabit Ethernet (1000/10000 Mbit)  ---> 
>
>whereas with 10/100 Mbit ethernet i can.
>Little flaw elsewhere!

I remembered other artikel about gig-E problems, so after re-reading
this cured it:
****************
From: walt <wa1ter@myrealbox.com>
[1] Gigabit Kconfig problems with yesterday's update
Distribution: cistron

I have one machine with a gigabit NIC which I updated today from Linus'
bk tree.

The problem is that I was not asked if I wanted the 'new' gigabit
support and therefore the tg3 support was dropped from my new .config.

I edited .config by hand and deleted any mention of ethernet support --
and only then did 'make oldconfig' ask me the right questions.

Also: the phrase (10 or 100Mbit) should be deleted from the 'Ethernet'
menu item since it implies (wrongly) that the item is not needed for
gigabit support.

****************

Danny
-- 
"If Microsoft had been the innovative company that it calls itself, it 
would have taken the opportunity to take a radical leap beyond the Mac, 
instead of producing a feeble, me-too implementation." - Douglas Adams -

