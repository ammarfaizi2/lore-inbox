Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316886AbSGURqb>; Sun, 21 Jul 2002 13:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316928AbSGURqb>; Sun, 21 Jul 2002 13:46:31 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:52214 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316886AbSGURqa>; Sun, 21 Jul 2002 13:46:30 -0400
Subject: Re: [PATCH] strict VM overcommit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Adrian Bunk <bunk@fs.tum.de>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0207211705220.701-100000@divine.city.tvnet.hu>
References: <Pine.LNX.4.30.0207211705220.701-100000@divine.city.tvnet.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Jul 2002 20:01:48 +0100
Message-Id: <1027278108.17234.109.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 16:23, Szakacsits Szabolcs wrote:
> What about the many hundred counter-examples (e.g. umount gives EBUSY,

umount -f.

> kill can't kill processes in uninterruptible sleep, etc, etc)? Why the

In these cases the kernel infrastructure doesn't support the ability to
recover from such a state, very different from stopping a user doing
something it can handle perfectly well.

You'll find plenty of people who believe the umount behaviour is
incorrect (and it should just GC them) as wel as the fact that
uninterruptible sleep is a bad idea

