Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315517AbSFYOup>; Tue, 25 Jun 2002 10:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315525AbSFYOuo>; Tue, 25 Jun 2002 10:50:44 -0400
Received: from realimage.realnet.co.sz ([196.28.7.3]:64727 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S315517AbSFYOun>; Tue, 25 Jun 2002 10:50:43 -0400
Date: Tue, 25 Jun 2002 16:21:07 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Martin Dalecki <dalecki@evision-ventures.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] IDE locking #2
In-Reply-To: <874rfrlibx.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.44.0206251619560.29391-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2002, OGAWA Hirofumi wrote:

> > +	BUG_ON(!spin_is_locked(ch->lock));
> 
> spin_is_locked() returns 0 always on the UP system.
> Instead, the following macro may be useful. 
> 
> #ifdef CONFIG_SMP
> #define assert_spin_is_locked(lock)	BUG_ON(!spin_is_locked(lock))
> #else
> #define assert_spin_is_locked(lock)	do {} while(0)
> #endif

Oh my =) thanks i'll change that.

Cheers,
	Zwane
-- 
http://function.linuxpower.ca
		

