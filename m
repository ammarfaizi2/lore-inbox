Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270824AbRHSWaB>; Sun, 19 Aug 2001 18:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270825AbRHSW3v>; Sun, 19 Aug 2001 18:29:51 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:7652 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S270824AbRHSW3l>;
	Sun, 19 Aug 2001 18:29:41 -0400
Date: Sun, 19 Aug 2001 23:29:51 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
Message-ID: <482526995.998263790@[169.254.45.213]>
In-Reply-To: <20010819151913.G30309@thune.mrc-home.com>
In-Reply-To: <20010819151913.G30309@thune.mrc-home.com>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike,

(off list - as I've posted this elsewhere)

>> This is not the issue; some of use _are_ worried whether or not we
>> have enough entropy (and want a read that blocks until sufficient
>
> If you are that worried, shouldn't you be using a hardware generator?

You could say the same thing to anyone who uses /dev/random
rather than /dev/urandom. Why use /dev/random when it can
block (inconvenient) instead of a h/w random number generator?

I'm sufficiently concerned that I want to have some 'external'
entropy, and on the machine in which it is causing me problems,
in an idle state, there is no other entropy source, but lots of
network activity which I trust can't be snooped on.

The machine was bought and tested in one config. A hardware
random number generator is something else to go wrong, and
additional expense.

Using an entropy estimate which includes network event timings
is no[1] worse (in this situation) than using (say) IDE interrupt
timings. And no better. It certainly isn't as good as using
an external random number generator. However, it is better
than using /dev/urandom and leaving the kernel unpatched
(see previous analysis). It's a trade-off. But if we can make
(depending on circumstance) the OS (s/w) perform better
with given h/w, that sounds like a good thing to do to me.

[1]=certainly not a lot worse.

--
Alex Bligh
