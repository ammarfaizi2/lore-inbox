Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293005AbSCAWQN>; Fri, 1 Mar 2002 17:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292879AbSCAWPy>; Fri, 1 Mar 2002 17:15:54 -0500
Received: from zero.tech9.net ([209.61.188.187]:52743 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292846AbSCAWPs>;
	Fri, 1 Mar 2002 17:15:48 -0500
Subject: Re: [PATCH] spinlock not locked when unlocking in atm_dev_register
From: Robert Love <rml@tech9.net>
To: fisaksen@bewan.com
Cc: mitch@sfgoth.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020301163936.7FA725F963@postfix2-2.free.fr>
In-Reply-To: <20020301163936.7FA725F963@postfix2-2.free.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 01 Mar 2002 17:15:48 -0500
Message-Id: <1015020950.11295.25.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-03-01 at 12:46, Frode Isaksen wrote:
> If you compile the kernel with SMP and spinlock debugging, BUG() will be 
> called when registering your atm driver, since the "atm_dev_lock" spinlock is 
> not locked when unlocking it.

I don't have any knowledge of the source in question, but wouldn't a
possibility (perhaps even more likely) be that you should _add_ the
spin_lock instead of remove the spin_unlocks ?

	Robert Love

