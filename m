Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265758AbSKFQQW>; Wed, 6 Nov 2002 11:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265777AbSKFQQW>; Wed, 6 Nov 2002 11:16:22 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:2969 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265758AbSKFQQV>; Wed, 6 Nov 2002 11:16:21 -0500
Subject: Re: Voyager subarchitecture for 2.5.46
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211060758440.2545-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0211060758440.2545-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 16:45:02 +0000
Message-Id: <1036601102.9781.58.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 16:12, Linus Torvalds wrote:
> Basically, I think NTP itself would be _way_ overkill between CPU's, I 
> wasn't really suggesting we use NTP as the main mechanism at that level. I 
> just suspect that a lot of the data structures and info that we already 
> have to have for NTP might be used as help.

I don't think the NTP algorithms are overkill. We have the same problem
space - multiple nodes some of which can be rogue (eg pit misreads, tsc
weirdness), inability to directly sample the clock on another node, need
for an efficient way to bend clocks. The fundamental algorithm is
extremely simple its all the networks, security, ui and glue that isnt -
stuff we can skip.


