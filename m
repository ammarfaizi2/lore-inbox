Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318502AbSHPOPa>; Fri, 16 Aug 2002 10:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318510AbSHPOPa>; Fri, 16 Aug 2002 10:15:30 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:62689 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318502AbSHPOP3>; Fri, 16 Aug 2002 10:15:29 -0400
Date: Fri, 16 Aug 2002 15:19:11 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: CLONE_DETACHED and exit notification (was user-vm-unlock-2.5.31-A2)
Message-ID: <20020816151911.A590@kushida.apsleyroad.org>
References: <20020816133456.A342@kushida.apsleyroad.org> <Pine.LNX.4.44.0208161448190.16655-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208161448190.16655-100000@localhost.localdomain>; from mingo@elte.hu on Fri, Aug 16, 2002 at 03:18:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> Why is CLONE_DETACHED such a big problem for you, why do you want to force
> a more expensive notification method?

Eh?  I _like_ CLONE_DETACHED, and I want notification cheaper, not
more expensive.

You've said that pthread_exit() _always_ notifies a sibling thread using
a futex.

Well, can we please move the futex wakeup into the kernel?  That is all
I ask.  It will make pthread_exit() _faster_, and me happy because
all exits are notified.

-- Jamie
