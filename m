Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267619AbUIFIKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267619AbUIFIKh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 04:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUIFIKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 04:10:01 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:18117 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S267619AbUIFIG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 04:06:29 -0400
Subject: Re: [Transmeta hardware] Update of the CMS under Linux ?
From: Emmanuel Fleury <fleury@cs.aau.dk>
To: Linux Kernel Mailing-list <linux-kernel@vger.kernel.org>
Cc: Kalin KOZHUHAROV <kalin@thinrope.net>
In-Reply-To: <ch8lop$m3t$1@sea.gmane.org>
References: <1093165082.11189.20.camel@aphrodite.olympus.net>
	 <ch8lop$m3t$1@sea.gmane.org>
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1094457952.22441.34.camel@rade7.e.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 06 Sep 2004 10:05:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Actually, I have an answer to my question by now.

The way the CMS is built-in on the hardware allow one way to upgrade the
firmware (and only one, as far as I understood in
http://www.realworldtech.com/page.cfm?ArticleID=RWT010204000000 and
http://www.realworldtech.com/page.cfm?ArticleID=RWT012704012616).

Each upgrade has to be signed with a certain private key (this private
key is known by the seller of the laptop (Toshiba in your case) and by
Transmeta itself... well I assume that in fact each entity has a partial
knowledge of the private key which makes impossible to one of these to
do something without the agreement of the other one).

So, the process for upgrading the CMS firmware is the following:

1) Load the upgrade in memory,
2) Check the signature of the upgrade with the public key stored in the
   ROM.
3) If the signature match with the upgrade, then apply the upgrade.

As you see, an upgrade (for Linux or Windows, whatever) requires the
agreement of both Transmeta AND the laptop seller. And you cannot easily
hack your way through.

I see only two solutions to do our own upgrade of the CMS:

1) Take the EPROM out and write our own public key on it...
   (risky and need a lot of hardware. I wouldn't recommand this way)

2) Crack the public/private keys of the hardware.
   (this is a known plaintext attack for the HP tablet-PC, and for the
    other hardwares we can only have access to the public-key which is
    making it more difficult but nothing that can resist to a brute
    force attack in the case we have enough Seti-like softwares
    running).

I have no idea if it is legal or not... it is not my concern now. 
I'm just seeking for solutions ! :)
I guess it depends if you are in the States or in Europe.

So, I am about here in my investigations and I still have this annoying
bug with the Xserver... Moreover, it seems that Transmeta is fully on
the Efficeon now and does not want to invest time and money on looking
for a bug in the Crusoe CMS (except if one of its customer is
specifically asking for it, which is very unlikely from Sony and/or
Fujitsu).

I am gathering some informations on a bug in the CMS here:
http://www.cs.auc.dk/~fleury/bug_cms/index.html

But, it looks like we are f**ked. :)

That's pretty annoying as these Transmeta laptops are an extremely cool
piece of hardware !!! :-/

Anyway, I won't give up so easily (for once that we have a nice bug to
fight with) !!! :)

Regards
-- 
Emmanuel Fleury

Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.aau.dk

