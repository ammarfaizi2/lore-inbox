Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287474AbRLaJGD>; Mon, 31 Dec 2001 04:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287473AbRLaJFx>; Mon, 31 Dec 2001 04:05:53 -0500
Received: from lafontaine.noos.net ([212.198.2.72]:56140 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id <S287472AbRLaJFp>;
	Mon, 31 Dec 2001 04:05:45 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timothy Covell <timothy.covell@ashavan.org>
Cc: <linux-kernel-owner@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>,
        <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
Date: Mon, 31 Dec 2001 10:05:33 +0100
Message-Id: <20011231090533.14848@smtp.noos.fr>
In-Reply-To: <Pine.LNX.4.33.0112301618310.1011-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0112301618310.1011-100000@penguin.transmeta.com>
X-Mailer: CTM PowerMail 3.1.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Sun, 30 Dec 2001, Timothy Covell wrote:
>>
>> 	When X11 locks up, I can still kill it and my box lives.  When
>> framebuffers crash, their is no recovery save rebooting.  Back in 1995
>> I thought that linux VTs and X11 implemenation blew Solaris out of the
>> water, and now we want throw away our progress?  I'm still astounded
>> by the whole "oooh I can see  a penquin while I boot-up" thing?
>> Granted, frame buffers have usage in embedded systems, but do they
>> really have to be so deeply integrated??
>
>They aren't.
>
>No sane person should use frame buffers if they have the choice.
>
>Like your mama told you: "Just say no". Use text-mode and X11, and be
>happy.
>
>Some people don't have the choice, of course.

Heh... well, text mode isn't that nice regarding the need for having
the "ISA memory" window available on the bus, and in general, those legacy
ISA memory and IO space needed by VGA text mode are rather a painful pile of
hack to carry on on non-x86 platforms ;)

And just my 2 cents: X11 is perfectly able to lock up the box solid. It
has root access to /dev/mem, it has direct access to video card registers,
that is enough to lockup the bus in quite a number of cases (shame on
nasty hardware). Add to that DRI with it's kernel module and bus mastering
hardware, and you obtain something with has as much chances as fbdev to
kill your box once it starts behaving erratically.

Ben.


