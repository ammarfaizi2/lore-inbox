Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293111AbSCAWdX>; Fri, 1 Mar 2002 17:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293167AbSCAWdR>; Fri, 1 Mar 2002 17:33:17 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:1181 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S293111AbSCAWc5>; Fri, 1 Mar 2002 17:32:57 -0500
Message-Id: <5.1.0.14.2.20020301143010.0d552be8@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 01 Mar 2002 14:32:24 -0800
To: Robert Love <rml@tech9.net>, fisaksen@bewan.com
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: [PATCH] spinlock not locked when unlocking in
  atm_dev_register
Cc: mitch@sfgoth.com, linux-kernel@vger.kernel.org
In-Reply-To: <1015020950.11295.25.camel@phantasy>
In-Reply-To: <20020301163936.7FA725F963@postfix2-2.free.fr>
 <20020301163936.7FA725F963@postfix2-2.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > If you compile the kernel with SMP and spinlock debugging, BUG() will be
> > called when registering your atm driver, since the "atm_dev_lock" 
> spinlock is
> > not locked when unlocking it.
>
>I don't have any knowledge of the source in question, but wouldn't a
>possibility (perhaps even more likely) be that you should _add_ the
>spin_lock instead of remove the spin_unlocks ?
Absolutely correct :)
I've got a patch for that, tested on SMP. I'll send it today or tomorrow.

btw ATM locking seems to be messed up. Is anybody working on that ?

Max

