Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbVLCSLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVLCSLz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 13:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVLCSLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 13:11:55 -0500
Received: from hera.cwi.nl ([192.16.191.8]:4557 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S932117AbVLCSLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 13:11:54 -0500
Date: Sat, 3 Dec 2005 19:11:40 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, horms@verge.net.au
Subject: Re: security / kbd
Message-ID: <20051203181140.GA25534@apps.cwi.nl>
References: <5f6Fp-1ZB-11@gated-at.bofh.it> <E1EiLA5-0001VE-64@be1.lrz> <20051203013455.GB24760@apps.cwi.nl> <Pine.LNX.4.58.0512030251570.6039@be1.lrz> <20051203023946.GC24760@apps.cwi.nl> <Pine.LNX.4.58.0512030616230.6684@be1.lrz> <20051203144659.GA2091@apps.cwi.nl> <Pine.LNX.4.58.0512031650450.2051@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0512031650450.2051@be1.lrz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 06:19:47PM +0100, Bodo Eggert wrote:

> > But there are many ways of using such a file descriptor.
> > This patch cripples the keymap changing but does not solve anything.
> 
> Obviously it solves only a part. OTOH you can't keep an exploit open just 
> because there is another exploit.
> Like I said, use chmod u+s loadkeys.

Hmm. There is an obscure security problem. It was fixed in a bad way -
people want to say unicode_start and unicode_stop and find that that
fails today. Ach.

You argue "you can't keep an exploit open" - but as far as I can see
there is no problem that needs solving in kernel space.
For example - today login does a single vhangup() for the login tty.
In case that is a VC it could do a vhangup() for all VCs.
That looks like a better solution.

And "chmod u+s loadkeys" - you can't be serious..
