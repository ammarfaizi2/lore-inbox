Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268015AbTBWDFu>; Sat, 22 Feb 2003 22:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268020AbTBWDFu>; Sat, 22 Feb 2003 22:05:50 -0500
Received: from almesberger.net ([63.105.73.239]:39688 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S268015AbTBWDFt>; Sat, 22 Feb 2003 22:05:49 -0500
Date: Sun, 23 Feb 2003 00:15:50 -0300
From: Werner Almesberger <wa@almesberger.net>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: Mitchell Blank Jr <mitch@sfgoth.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ATM] who 'owns' the skb created by drivers/atm?
Message-ID: <20030223001550.I2791@almesberger.net>
References: <20030220222404.B11525@sfgoth.com> <200302211608.h1LG8tGi014271@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302211608.h1LG8tGi014271@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Fri, Feb 21, 2003 at 11:08:55AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chas williams wrote:
> In message <20030220222404.B11525@sfgoth.com>,Mitchell Blank Jr writes:
>>Hmmmm.. I guess we've just been getting lucky before in that case - we've
>>always just left the ATM_SKB() stuff in there.

The "cb must be in virgin state" rule is indeed news to me. But
maybe the rule has always been there, and nobody really noticed :-)

> this is one option.  the other would be to clone the skb and pass the
> clone to the ip layer.  the last option, and the one i prefer, would
> be to make the atm drivers not modify skb->cb (or reset it) when passing
> up the skb.  the atm socket layer doesnt rely on it, and it would keep
> the 'extra' processing to a minimum.

I'm not sure this is the problem: as far as I remember, the ATM stack
doesn't assume that other layers leave skb->cb intact. In fact, it
shouldn't even touch an skb once it has been passed on.

BTW, I'm happy that ATM finally has a maintainer again. Thanks, Chas !

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
