Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318845AbSIIULc>; Mon, 9 Sep 2002 16:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318842AbSIIULc>; Mon, 9 Sep 2002 16:11:32 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:56512 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318845AbSIIULb>;
	Mon, 9 Sep 2002 16:11:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Subject: Re: Question about pseudo filesystems
Date: Mon, 9 Sep 2002 22:18:31 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alexander Viro <viro@math.psu.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
References: <20020907192736.A22492@kushida.apsleyroad.org> <E17o4UE-0006Zh-00@starship> <20020909204834.A5243@kushida.apsleyroad.org>
In-Reply-To: <20020909204834.A5243@kushida.apsleyroad.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oUzP-0006tu-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 21:48, Jamie Lokier wrote:
> The expected behaviour is as it has always been: rmmod fails if anyone
> is using the module, and succeeds if nobody is using the module.  The
> garbage collection of modules is done using "rmmod -a" periodically, as
> it always has been.

Actually, it would be more useful if I stated the following simple fact:
Returning a flag from __exit definitively gets rid of one race, that is
the race where a module's memory can be freed while __exit is active.

To get rid of this race by other means you have to put in place some
fancy mechanism.  This alone should be enough reason to do it the way
I suggest, besides the fact that it is a simpler, more obvious and more
robust interface.

-- 
Daniel
