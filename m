Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318069AbSHPChw>; Thu, 15 Aug 2002 22:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318075AbSHPChw>; Thu, 15 Aug 2002 22:37:52 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:63712 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318069AbSHPChv>; Thu, 15 Aug 2002 22:37:51 -0400
Date: Fri, 16 Aug 2002 00:29:29 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
Message-ID: <20020816002929.A30262@kushida.apsleyroad.org>
References: <20020815113148.A28398@kushida.apsleyroad.org> <Pine.LNX.4.44.0208151502001.7855-100000@localhost.localdomain> <20020815222731.A28998@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020815222731.A28998@kushida.apsleyroad.org>; from lk@tantalophile.demon.co.uk on Thu, Aug 15, 2002 at 10:27:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> It's probably most simple to use two consecutive words, for simplicity
> and to avoid needing an atomic store (which is slower on some
> architectures).

Ignore the above bit, I missed that you are already using two
independent addresses (in edx and edi), so atomicity is not an issue.
It might be cleaner to use a single address pointing to two consecutive
words anyway (for CLONE_SETTID and CLONE_VM_RELEASE) just to save a
register for future use - register pressure around clone() being a
precious thing, occasionally.

-- Jamie
