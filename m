Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136673AbREAR06>; Tue, 1 May 2001 13:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136672AbREAR0s>; Tue, 1 May 2001 13:26:48 -0400
Received: from wire.cadcamlab.org ([156.26.20.181]:60175 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S136674AbREAR0k>; Tue, 1 May 2001 13:26:40 -0400
Date: Tue, 1 May 2001 12:23:16 -0500
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: "J . A . Magallon" <jamagallon@able.es>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] [PATCH] automatic multi-part link rules (fwd)
Message-ID: <20010501122316.A23391@cadcamlab.org>
In-Reply-To: <20010501013120.A15120@werewolf.able.es> <Pine.LNX.4.33.0105010944370.24511-100000@vaio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.33.0105010944370.24511-100000@vaio>; from kai@tp1.ruhr-uni-bochum.de on Tue, May 01, 2001 at 10:16:44AM +0200
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Kai Germaschewski]
> However, I don't think it's hard to verify that my patch works as
> well, it's about ten lines added to Rules.make.  It's particularly
> easy to verify that it doesn't change behavior for objects listed in
> $(list-multi) at all.

Yes, we can say this, but people are right to be paranoid.  Remember
that the first version of your patch (several months ago) required a
particular version of GNU Make....

I submitted a cleanup patch for 2.2.18pre that was 100% safe in that it
just made use of a script that was already in the tree
(scripts/kwhich).  But sure enough, it broke for users of older Red Hat
installations who were still on bash 1.x.  It seems scripts/kwhich
hadn't been used that way before, so nobody had noticed that it didn't
work with bash 1.

That said, I think your current version is in fact bug-free and if it
were up to me I would put it in the tree.  But I also understand why
others are hesitant to trust it.  The bugs it fixes are fairly minor,
after all.

Peter
