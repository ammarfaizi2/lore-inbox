Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261937AbSIYICM>; Wed, 25 Sep 2002 04:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261940AbSIYICM>; Wed, 25 Sep 2002 04:02:12 -0400
Received: from angband.namesys.com ([212.16.7.85]:43436 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261937AbSIYICL>; Wed, 25 Sep 2002 04:02:11 -0400
Date: Wed, 25 Sep 2002 12:07:25 +0400
From: Oleg Drokin <green@namesys.com>
To: "David S. Miller" <davem@redhat.com>
Cc: zaitcev@redhat.com, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: cmpxchg in 2.5.38
Message-ID: <20020925120725.A23559@namesys.com>
References: <20020925010044.A4464@devserv.devel.redhat.com> <20020925111820.A23225@namesys.com> <20020925.004719.61852840.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020925.004719.61852840.davem@redhat.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Sep 25, 2002 at 12:47:19AM -0700, David S. Miller wrote:

>    Ingo said that arches that cannot do cmpxchg in hardware should
>    provide spinlock-based version.
> That doesn't make any sense.

Yes, I know.

> If cmpxchg cannot work with user bits of memory, like
> cmpxchg is supposed to, it's really a crutch more than
> anything else.

Ingo's argument was that since there is only one place in code that accesses
that variable (map->page), it is safe to rely on such a crippled
cmpxchg implementation.

To not retell you whole story and avoid the role of broken phone,
here's info on prevous discussion on this topic:
Subject: Re: [patch] generic-pidhash-2.5.36-D4, BK-curr
September 20, From Ingo Molnar <mingo@elte.hu>, Message-ID: <Pine.LNX.4.44.0209201139290.1261-100000@localhost.localdomain>
September 20, From Ingo Molnar <mingo@elte.hu>, Message-ID: <Pine.LNX.4.44.0209201828090.8547-100000@localhost.localdomain>

Bye,
    Oleg
