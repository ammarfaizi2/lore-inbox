Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292633AbSBUQwW>; Thu, 21 Feb 2002 11:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292503AbSBUQwN>; Thu, 21 Feb 2002 11:52:13 -0500
Received: from zero.tech9.net ([209.61.188.187]:26635 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292467AbSBUQwJ>;
	Thu, 21 Feb 2002 11:52:09 -0500
Subject: Re: 2.5.5 on Sparc, Ughh...
From: Robert Love <rml@tech9.net>
To: george anzinger <george@mvista.com>
Cc: "David S. Miller" <davem@redhat.com>, bruce.holzrichter@monster.com,
        ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <3C74AA0C.A627B561@mvista.com>
In-Reply-To: <3AB544CBBBE7BF428DA7DBEA1B85C79C01101F6B@nocmail.ma.tmpw.net>
	<20020220.083904.74754277.davem@redhat.com>  <3C74AA0C.A627B561@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 21 Feb 2002 11:52:08 -0500
Message-Id: <1014310329.847.17.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-02-21 at 03:04, george anzinger wrote:

> Uh, Dave, could you expound a bit on why you need a preemption lock
> around the notify parent/ schedule code?  We have not found this to be
> needed on other archs, but maybe we missed something.

2.5 has diverged from the "patch" version of the code.  We removed the
PREEMPT_ACTIVE flag and thus have a race against parent/wake up.  All
arches disable preemption there.

	Robert Love

