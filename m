Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268297AbUIGP0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268297AbUIGP0q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268333AbUIGPWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:22:17 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:63432 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S268297AbUIGPVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:21:45 -0400
Date: Tue, 7 Sep 2004 17:21:18 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Steve French <smfltc@us.ibm.com>
Subject: Re: [PATCH 4/4] copyfile: copyfile
Message-ID: <20040907152118.GA30396@wohnheim.fh-wedel.de>
References: <20040907120908.GB26630@wohnheim.fh-wedel.de> <20040907121118.GA27297@wohnheim.fh-wedel.de> <20040907121235.GB27297@wohnheim.fh-wedel.de> <20040907121520.GC27297@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0409070656150.2299@ppc970.osdl.org> <20040907145118.GA29993@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0409070756410.2299@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0409070756410.2299@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 September 2004 07:59:11 -0700, Linus Torvalds wrote:
> On Tue, 7 Sep 2004, Jörn Engel wrote:
> > 
> > Does that mean that you're ok with the first three patches?
> 
> No, it means that they weren't fundamentally flawed..

It's a start...

> Actually, the 4kB batching one was - if you only max out to using 4kB at a 
> time, sendfile() is kind of pointless, because then it will never do 
> multi-page copies in the first place, and all the complexity at a lower 
> level is worthless..

Give me a better number.  16k?  1M?  Or would it not be fundamentally
flawed if the unit was seconds, instead of bytes?  That makes a lot
more sense, since a floppy and a Ultra320 RAID array differ slightly
in speed and it's response time the users actually care about.

Jörn

-- 
/* Keep these two variables together */
int bar;
