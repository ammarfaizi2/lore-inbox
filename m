Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293269AbSCAWfd>; Fri, 1 Mar 2002 17:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293457AbSCAWfY>; Fri, 1 Mar 2002 17:35:24 -0500
Received: from zero.tech9.net ([209.61.188.187]:2824 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293375AbSCAWfH>;
	Fri, 1 Mar 2002 17:35:07 -0500
Subject: Re: [PATCH] spinlock not locked when unlocking in atm_dev_register
From: Robert Love <rml@tech9.net>
To: Maksim Krasnyanskiy <maxk@qualcomm.com>
Cc: fisaksen@bewan.com, mitch@sfgoth.com, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020301143010.0d552be8@mail1.qualcomm.com>
In-Reply-To: <20020301163936.7FA725F963@postfix2-2.free.fr>
	<20020301163936.7FA725F963@postfix2-2.free.fr> 
	<5.1.0.14.2.20020301143010.0d552be8@mail1.qualcomm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 01 Mar 2002 17:35:08 -0500
Message-Id: <1015022109.11499.47.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-03-01 at 17:32, Maksim Krasnyanskiy wrote:

> > I don't have any knowledge of the source in question, but wouldn't a
> > possibility (perhaps even more likely) be that you should _add_ the
> > spin_lock instead of remove the spin_unlocks ?
>
> Absolutely correct :)
> I've got a patch for that, tested on SMP. I'll send it today or tomorrow.

Yah, I just looked at the code - again, I don't profess to know the atm
driver - but it seems to need the lock.  Thanks.
 
> btw ATM locking seems to be messed up. Is anybody working on that ?

Not that I know of.  Volunteer? :)

	Robert Love

