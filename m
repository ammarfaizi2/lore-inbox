Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbVJRSlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbVJRSlW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 14:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbVJRSlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 14:41:21 -0400
Received: from khc.piap.pl ([195.187.100.11]:25604 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751159AbVJRSlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 14:41:21 -0400
To: Rudolf Polzer <debian-ne@durchnull.de>
Cc: Horms <horms@verge.net.au>, linux-kernel@vger.kernel.org,
       334113@bugs.debian.org, Alastair McKinstry <mckinstry@debian.org>,
       security@kernel.org, team@security.debian.org,
       secure-testing-team@lists.alioth.debian.org
Subject: Re: kernel allows loadkeys to be used by any user, allowing for
 local root compromise
References: <E1EQofT-0001WP-00@master.debian.org>
	<20051018044146.GF23462@verge.net.au>
	<m37jcakhsm.fsf@defiant.localdomain>
	<20051018171645.GA59028%atfield-dt@durchnull.de>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 18 Oct 2005 20:41:19 +0200
In-Reply-To: <20051018171645.GA59028%atfield-dt@durchnull.de> (Rudolf
 Polzer's message of "Tue, 18 Oct 2005 19:16:45 +0200")
Message-ID: <m3fyqyhdm8.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rudolf Polzer <debian-ne@durchnull.de> writes:

> That does not help against the loadkeys issue if the attacking user is still
> logged in on another virtual console. Even when tty1 is active, a user owning
> tty6 can use loadkeys.

Sure. The problem is that mappings are shared between VCs but anyway
it's solved by disabling user changes.
I don't think there is a solution here, easier than hardware reset.
As for "server" machines (not simple terminals), physical locking is
critical.

> Well, sometimes you have problems that powercycling would "hide" so you can't
> track them down if you powercycle the whole computer every time.

In security-sensitive instalation, you simply don't expose the computers
to non-admins.

> For using foreign languages and keyboard mappings.

Hope they don't change the keys in the process.
Anyway, most people don't need that nor they need suid-wrapper.

BTW: there are similar problems with serial access: users can play
with termio(s) settings (especially CLOCAL flag) and fake
login/password requests. Unless the getty programs are fixed,
you don't want to connect dial-in modems to a machine with user
accounts. Not a kernel thing, though - Linux has termios locking
for 10+ yrs.
-- 
Krzysztof Halasa
