Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316677AbSICPv6>; Tue, 3 Sep 2002 11:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317068AbSICPv5>; Tue, 3 Sep 2002 11:51:57 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44294 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316677AbSICPv5>; Tue, 3 Sep 2002 11:51:57 -0400
Date: Tue, 3 Sep 2002 09:04:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Benjamin LaHaise <bcrl@redhat.com>, Pavel Machek <pavel@suse.cz>,
       Peter Chubb <peter@chubb.wattle.id.au>, <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Large block device patch, part 1 of 9
In-Reply-To: <15732.34929.657481.777572@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.44.0209030900410.1997-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Sep 2002, Neil Brown wrote:
> 
> Effectively, this is a type-safe cast.  You still get the warning, but
> it looks more like the C that we are used to.

I wonder if the right answer isn't to just make things like "__u64" be
"long long" even on 64-bit architectures (at least those on which it is 64
bit, of course. I _think_ that's true of all of them). And then just use 
"llu" for it all.

Of course, the really _best_ option would be to have gcc's printf string 
format be extensible and dynamic.

Davem, is sparc64 "long long" 64-bit?

		Linus

