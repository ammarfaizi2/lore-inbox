Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265947AbTBCU6R>; Mon, 3 Feb 2003 15:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266043AbTBCU6R>; Mon, 3 Feb 2003 15:58:17 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:39436 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265947AbTBCU6Q>; Mon, 3 Feb 2003 15:58:16 -0500
Date: Mon, 3 Feb 2003 16:04:48 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not  2.4.x,
In-Reply-To: <5.2.0.9.2.20030203151616.019a5900@mail.lauterbach.com>
Message-ID: <Pine.LNX.3.96.1030203155651.28323A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Feb 2003, Franz Sirl wrote:

> On 2003-02-02 15:40:33 Bill Davidsen wrote:

> >The problem which I have been seeing with some regularity is not the hang
> >you describe (I see that infrequently) but rather a hang after I exit an
> >ssh connection. I open several dozen windows at a time to a cluster when I
> >do admin, and when I close almost always at least one doesn't drop without
> >"~." to help. So far in a hour I haven't seen that.
> 
> That's some internal problem in OpenSSH, can be seen on Solaris as well. 
> Can be easily reproduced in a ssh session:
> 
> nohup sleep 60 &
> logout
> 
> The ssh session will terminate only after the sleep exited.

That is a problem with processes left running. I do not forward
connections, I do not forward X, I do not (in normal practice) leave
anything running. A typical thing to do is to go to each machine in a
cluster and look for a user activity:
  grep "user" log/stats.readers
  exit
nothing more. And every once in a while that hangs after executing the
logout sequence. With the patch it hasn't to date.

That doesn't mean it's a fix, I don't see it every day, I just haven't
seen it in a few days since I put in the patch.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

