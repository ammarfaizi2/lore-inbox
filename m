Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136045AbREDJzN>; Fri, 4 May 2001 05:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136078AbREDJzD>; Fri, 4 May 2001 05:55:03 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:10758 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S136045AbREDJyv>; Fri, 4 May 2001 05:54:51 -0400
Date: Fri, 4 May 2001 13:54:01 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.4 alpha semaphores optimization
Message-ID: <20010504135401.A2346@jurassic.park.msu.ru>
In-Reply-To: <20010503194747.A552@jurassic.park.msu.ru> <14842.988968173@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14842.988968173@warthog.cambridge.redhat.com>; from dhowells@redhat.com on Fri, May 04, 2001 at 10:22:53AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2001 at 10:22:53AM +0100, David Howells wrote:
> Hello Ivan,

Hello David!

> I don't know whether it will (a) compile, or (b) work... I don't have an alpha
> to play with.

It looks ok at a first glance, I can try it today.

> I also don't know the alpha function calling convention, so I can't put direct
> calls to the fallback routines in lib/rwsem.c from the ".subsection 2"
> bits. Can you do that, or can you tell me how the calling convention works?

Calling C routines from inline asm is quite painful on alpha. Lots of
registers will be clobbered, so you need some wrapper functions preserving
them. It was done in 2.2 this way, but that code was hardly maintainable...

Ivan.
