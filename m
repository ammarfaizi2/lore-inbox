Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbUKJAXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbUKJAXZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 19:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbUKJAXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 19:23:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:59299 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261808AbUKJAXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 19:23:13 -0500
Date: Tue, 9 Nov 2004 16:23:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christian Kujau <evil@g-house.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.6.10-rc1
In-Reply-To: <41915CE3.4080404@g-house.de>
Message-ID: <Pine.LNX.4.58.0411091621220.2301@ppc970.osdl.org>
References: <4180F026.9090302@g-house.de> <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz>
 <4180FDB3.8080305@g-house.de> <418A47BB.5010305@g-house.de>
 <418D7959.4020206@g-house.de> <Pine.LNX.4.58.0411062244150.2223@ppc970.osdl.org>
 <20041107130553.M49691@g-house.de> <418E4705.5020001@g-house.de>
 <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org> <20041107182155.M43317@g-house.de>
 <418EB3AA.8050203@g-house.de> <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org>
 <418F6E33.8080808@g-house.de> <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org>
 <41915CE3.4080404@g-house.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Nov 2004, Christian Kujau wrote:
> > 
> > 	bk set -n -d -r1.2462 -r1.2463 | bk -R prs -h -d'<:P:@:HOST:>\n$each(:C:){\t(:C:)\n}\n' -
> > 
> > which is black magic that does a set operation and shows all the changes 
> > in between the sets of "bk at 1.2462" and "bk at 1.2463".
> 
> hm, i still fail to see the "magic" part here. from a current tree i get:

You don't see any magic, unless there are merges involved. And you've 
already narrowed the thing down to a single non-merge changeset, at which 
point the "magic" way is just a very slow way of doing the same thing.

The magic hits you only when you have non-trivial merges, in which case 
the set operation shows you more than the "just walk from one top-of-tree 
to the other".

		Linus
