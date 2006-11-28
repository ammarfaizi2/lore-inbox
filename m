Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933268AbWK1NPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933268AbWK1NPa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 08:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933568AbWK1NPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 08:15:30 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50074 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S933268AbWK1NP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 08:15:29 -0500
Date: Tue, 28 Nov 2006 14:15:28 +0100
From: Martin Mares <mj@ucw.cz>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Entropy Pool Contents
Message-ID: <mj+md-20061128.131233.3594.atrey@ucw.cz>
References: <ek2nva$vgk$1@sea.gmane.org> <456B3483.4010704@cfl.rr.com> <ekfehh$kbu$1@taverner.cs.berkeley.edu> <456B4CD2.7090208@cfl.rr.com> <ekfifg$n41$1@taverner.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ekfifg$n41$1@taverner.cs.berkeley.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>   - Whether you automatically bump up the entropy estimate when
>     root users write to /dev/random is a design choice where you could
>     reasonably go either way.  On the one hand, you might want to ensure
>     that root has to take some explicit action to allege that it is
>     providing a certain degree of entropy, and you might want to insist
>     that root tell /dev/random how much entropy it added (since root
>     knows best where the data came from and how much entropy it is likely
>     to contain).

More importantly, it should be possible for root to write to /dev/random
_without_ increasing the entropy count, for example when restoring random
pool contents after reboot. In such cases you want the pool to contain
at least some unpredictable data before real entropy arrives, so that
/dev/urandom cannot be guessed, but you unless you remember the entropy
counter as well, you should not add any entropy.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Q: How to start hacking Linux?  A: vi /boot/vmlinuz
