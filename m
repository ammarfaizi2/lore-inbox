Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWJLS4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWJLS4g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWJLS4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:56:36 -0400
Received: from alnrmhc14.comcast.net ([206.18.177.54]:54158 "EHLO
	alnrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750886AbWJLS4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:56:36 -0400
Message-ID: <452E8FE1.7080503@comcast.net>
Date: Thu, 12 Oct 2006 14:56:33 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Can context switches be faster?
References: <452E62F8.5010402@comcast.net>	 <20061012171929.GB24658@flint.arm.linux.org.uk>	 <452E888D.6040002@comcast.net> <1160678231.3000.451.camel@laptopd505.fenrus.org>
In-Reply-To: <1160678231.3000.451.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
> On Thu, 2006-10-12 at 14:25 -0400, John Richard Moser wrote:
> 
> Hi,
> 
>> So apparently most CPUs virtually address L1 cache and physically
>> address L2; but sometimes physically addressing L1 is better.. hur.
> 
> if you are interested in this I would strongly urge you to read Curt
> Schimmel's book (UNIX(R) Systems for Modern Architectures: Symmetric
> Multiprocessing and Caching for Kernel Programmers); it explains this
> and related materials really really well.
> 

That will likely be more useful when I've got more background knowledge;
right now my biggest problem is I'm inexperienced and haven't yet gotten
my 2-year compsci degree (more importantly, the associated knowledge
that goes with it), so things like compiler design are like "There's a
concept of turning stuff into trees and associating actions with virtual
registers and then turning that into real register accounting and
instructions, but I really don't know WTF it's doing."

I imagine once I get into the 4-year stuff I'll be able to digest
something like that; so I'll keep that in mind.  The '1st year compsci
student' crutch is annoying and I need to get rid of it so I don't feel
so damn crippled trying to do anything.

> 
>>   - Does the current code act on these behaviors, or just flush all
>>     cache regardless?
> 
> the cache flushing is a per architecture property. On x86, the cache
> flushing isn't needed; but a TLB flush is. Depending on your hardware
> that can be expensive as well. 
> 

Mm.  TLB flush is expensive, and pretty unavoidable unless you do stupid
things like map libc into the same address everywhere.  TLB flush
between threads in the same process is probably avoidable; aren't
threads basically processes with the same PID in something called a
thread group?  (Hmm... creative scheduling possibilities...)

> Greetings,
>     Arjan van de Ven
> 
> 

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRS6P4As1xW0HCTEFAQLcjQ//aQF7RWL4INtwl8ZPI35ueTj6y7Ap5vdP
bJUjXOgF4M/yyyRB9KThTaoRxUkTapPbUaNAa2VBU5c8vBW3anyTuGjUXhW7dBUZ
Xfk0611xEVrEsCcwNjpRhpZH55npjaymzSvdDulqdVThLJCDxkYGonL+6K7T5PRF
eRqFvniRur/pNormpkxzXoqxEqhO0dpy/RWbMuhF4hGpCLBz6ZNXWjRDJrzTtoFp
dhDAy5sJuf4gGqG0oQY2FN9FzFYrCguKGReP/xuzWhqUUyxvKrgbJLFBj1Zut3Uc
Gm59FhSpfKyJifJGGvFhrMxMKLL/wVsLxfRUbvFuD8Xki6UxxQ3Kve2AVihKcRz6
RpYDQesAG0TgP9GypM8eT5uezKnzIe1FJpg9619Isem11dogvuMA6h7qgdJH7+gb
E8yWeVFoZx1GPNCpQgZhy2IijztgYS40GMf+0xoUZcanE3pO93+85DNxapcyGkNY
kYIGSiugKDlQlIVaBov8+EtLr6hILBXPT9+PjwD9EWWjjQZB9iJy+ROnKntd+twe
knNYHm6aKuXVxmndfrzW+VDDN4I0TnbD3ctoepkEUQK2RFoBAt5tEceFmI6YILSr
w/h71yBztmvMAzSe6vEVSKN95jEg7UGd09UQN/GbcEJvw2s5l+HL1LGVRIbR0YN/
4gK2kAq28eA=
=Grg2
-----END PGP SIGNATURE-----
