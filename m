Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVDZCPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVDZCPy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 22:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVDZCPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 22:15:53 -0400
Received: from smtpout.mac.com ([17.250.248.73]:31439 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261273AbVDZCPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 22:15:40 -0400
In-Reply-To: <426D9AC0.5020908@lab.ntt.co.jp>
References: <4263275A.2020405@lab.ntt.co.jp> <m1y8b9xyaw.fsf@muc.de> <426C51C4.9040902@lab.ntt.co.jp> <e83d0cb60cb50a56b38294e9160d7712@mac.com> <426CC8F7.8070905@lab.ntt.co.jp> <200504251636.j3PGa9SJ015388@turing-police.cc.vt.edu> <426D9AC0.5020908@lab.ntt.co.jp>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d3d20c47f8bb1b095b6240baf5fa5465@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Date: Mon, 25 Apr 2005 22:15:13 -0400
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 25, 2005, at 21:34, Takashi Ikebe wrote:
> Valdis.Kletnieks@vt.edu wrote:
>> When asked "Why don't you just reboot the affected switches?" his
>> response was "This assumes that the switch had ever been booted in
>> the first place". (Apparently, the *whole thing* had been
>> on-the-fly replaced/patched without an actual reload happening...)
>> Gaaahhh! :)
>
> I think that's the common sense in every carrier.

That is definitely not common sense.  It may be good business
practice, but those are two *entirely* different things.

> If we reboot the switch, the service will be disrupted.

Yes.  My personal favorite solution to this problem is HeartBeat,
some Open-Source software that is very good at maintaining high
availability.  With a properly written multi-system clustering
switch application that utilizes the Linux Virtual-Server tools,
you could reasonably efficiently run a system such that you can
reboot any individual system without any loss of service.

> The phone network is lifeline, and does not allow to be disrupt
> by just bug fix.  I think same kind of function is needed in many
> real enterprise/mission-critical/business area.

But you miss the point.  Linux is *NOT* about "business", or
"enterprise", or "mission-critical".  Linux is (at least to
many hackers) about hacking, having fun, and Good Design(TM).

> All do with ptrace may affect target process's time critical
> task. (need to stop target process whenever fix)

So don't do it with ptrace!!! I've given you one other method
that uses minimal changes to existing software and emulates the
crappy mmap3 call you keep trying to push.

> All implement in user application costs too much,

What about one of the dozen other offered methods?

> need to implement all the application...

So why not write a utility library?  You'd need to "implement
all in the kernel", too, and since it can be done better in
userspace, let's keep out the bloat while we're at it.

> (and I do not know this approach really works on time critical
> applications yet.)

So test it! You're clearly working for a big corporation with
the money and resources to develop something like this, so do
so, and if you get something that works well, *and* uses good
design, we'll welcome patches!

> There are clear demand to realize this common and GPL-ed
> function....

The kernel is not about business, demand, or what the CEO of
some big-name company wants.  The kernel strives for the goal
of "Good Engineering (TM)".


Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


