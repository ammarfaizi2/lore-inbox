Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265459AbRF1AeM>; Wed, 27 Jun 2001 20:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265460AbRF1Adw>; Wed, 27 Jun 2001 20:33:52 -0400
Received: from [64.21.52.68] ([64.21.52.68]:48136 "HELO lithium.nac.net")
	by vger.kernel.org with SMTP id <S265459AbRF1Adp>;
	Wed, 27 Jun 2001 20:33:45 -0400
Date: Wed, 27 Jun 2001 20:33:32 -0400
To: linux-kernel@vger.kernel.org
Subject: Freezing bug in all kernels greater than 2.4.5-ac13 *AND* 2.4.6-pre2
Message-ID: <20010627203331.B1615@debian>
In-Reply-To: <20010623222954.A9031@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010623222954.A9031@debian>
User-Agent: Mutt/1.3.18i
From: <tcm@nac.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I decided, for the hell of it, to test the pre series as I've been
nudged by many people to try it in favor of the ac kernel series that
I've been having problems with. Well, it turns out I have ran into
exactly the same problem I had with the ac kernel series, which quite
frankly is surprising the hell out of me.

To make the kernel freeze/slow down to a crawl with affected kernels on
my machine I do this test:

Load X (This fills up my ram and causes me to swap a bit)
run a rxvt and su to root (proboably unnecessary)
du /

Now, somewhere in this test I start swapping a little bit, nothing
big... then BAM. hard disk, mouse, keyboard, all completely and utterly
stop. Video continues to work, but my cpu's load goes absolutely INSANE.
(If it recovers, gkrellm generally says I've gotten a loadavg somewhere
between 3-20, depending on how long it was stuck) This can last for
seconds (usually) minutes (once) or it can simply get worse and hang the
machine (many, many many times)

When it recovers from this, I generally see a MASSIVE write to swap,
(I'm using gkrellm to monitor it) and the system continues on as if
nothing happened - until, of course, this happens again. A kernel
compile can cause it. a rm -R of a large directory can cause it. Loading
a large application can cause it.

On some kernels this is more noticable than others - ac15 does it the
worst, although pre3 rivals it, and the symptoms are different on
ac17/18 - it'll simply freeze randomly and with no recovery instead of
sometimes freezing or sometimes slowing down to a crawl and recovering
or freezing. (Which is worse? You decide.)

Now, as before, I tested this with swap and without swap. With swap, I
get the hangs/freezes in all the affected kernels. Without swap, I
don't. Nada.

Now, the big question of the day folks: What changed between 2.4.6-pre2
and 2.4.6-pre3 that ALSO changed between 2.4.5-ac13 and 2.4.5-ac14 - and
now, what part of those patches were the VM? Anyone? I don't see in
2.4.6-pre3 what changed that was part of the VM... So I am trying to
narrow it down a bit :)

This bug is driving me slightly nuts, so I want it dead. Anyone got a
exterminator handy? =)

Refer to my previous post with this subject for my original description
of this problem. It's still there in ac18, though I've not tested 19
(Some have said it's not likely to have been fixed, and I've been
regress testing 2.4.6pre's today.)

Subject: Possible freezing bug located after ac13

Let me know if I can provide any additional information that will help
nail this bug to the wall. (I want to torture it. =)

Tim
