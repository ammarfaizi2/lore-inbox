Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWEVTcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWEVTcg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWEVTcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:32:35 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:3566 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751140AbWEVTcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:32:35 -0400
Message-ID: <447210B3.10401@comcast.net>
Date: Mon, 22 May 2006 15:27:47 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060518)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.16 Parameter-controlled mmap/stack randomization
References: <1148132838.3041.3.camel@laptopd505.fenrus.org> <446F3483.40208@comcast.net> <20060522010606.GC25434@elf.ucw.cz> <44712605.4000001@comcast.net> <20060522083352.GA11923@elf.ucw.cz> <4471E77F.1010704@comcast.net> <20060522170036.GD1893@elf.ucw.cz> <4471FAD0.9060403@comcast.net> <20060522184003.GD2979@elf.ucw.cz> <44720ACB.7040808@comcast.net> <20060522191230.GE2979@elf.ucw.cz>
In-Reply-To: <20060522191230.GE2979@elf.ucw.cz>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Pavel Machek wrote:
> Hi!
> 
>>>>> Well, fix emacs then. We definitely do not want 10000 settable knobs
>>>>> that randomly break things. OTOH per-architecture different randomness
>>>>> seems like good idea. And if Oracle breaks, fix it.
>>>> Fix this, fix that.  In due time perhaps.  I'm pretty sure Linus isn't
>>>> going to break anything, esp. since his mail client breaks too.
>>> Good. So fix emacs/oracle/pine, and year or so and some time after it
>>> is fixed, we can change kernel defaults. That's still less bad than
>>> having
>>>
>>> [ ] Break emacs
>>>
>>> in kernel config.
>> Nobody is going to fix emacs/oracle/pine, they don't have to.  Nothing
>> is making them.  The kernel will wait for them so who cares.
> 
> No, _you_ have to fix emacs/oracle/pine. You claimed your patch is
> interesting for secure distros, so you obviously have manpower for
> that, right?

RHAT probably fixed Emacs already since it broke on them.  Adamantix and
Hardened Gentoo are most likely to put manpower into things like pine..
they put a lot of work into removing textrels on i386.

Oracle we can't do anything about.  It's commercial.  If we break it,
they will recommend running it on Solaris or Windows 2003.

> 
>>>> Why should it NOT be configurable anyway?  If you don't configure it,
>>>> then it behaves just like it would if it wasn't configurable at all.
>>>> This is called "having sane defaults."
>>> Because if it is configurable, someone _will_ configure it wrong, and
>>> then ask us why it does not work.
>> Oh big deal.  People configure out ide drivers and ask why their kernel
>> doesn't boot all the time.  Distro maintainers do most of the work.
> 
> As you may have noticed, I'm at receiving end of those bug
> reports. And what you propose is actually *worse* than IDE, because at
> least you get relatively clear error message when misconfiguring IDE.
> 

Yes but when you misconfigure IDE the system doesn't boot.  When you
turn up randomization too high, everything works but 1 or 2 programs.
You bitch to your distro or to the upstream programmer and they tell you
"It won't function like that, do this" or "We don't know right now" and
you make the connection and turn it back down or wind up here.

If you get that far, at least you know what you did and how to undo it.

>>> And if it is configurable, applications will not get fixed for
>>> basically forever.
>> FUD.  If it's not configurable, applications will not get fixed for
>> basically forever, and nobody will put the breaking code into mainline.
>>  Linus is NOT giving 256M/256M randomization on mainline as default
>> ever.
> 
> For x86-64... why not?

On x86-64 he may, if you can convince him it's useful (asserting that
turning entropy up on i386 is non-useful is not a good start hinthint).
 On i386 or other 32-bit where TASK_SIZE is a few GiB, no chance in
hell, but it'd be nice to be able to tweak it upwards if desired.

> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRHIQsQs1xW0HCTEFAQK8rw/+O63a9cVnA+eth3lXRlXPfX/Bi3VEu9QL
ELk3IRw6iN2upFMY7HMcxoec4qLpx52yaqFWepUU9DWPgvmwq/GSM0XNDJ1SRQTc
N/yAKvHsfcir4Y/MIn5byWMSEGUbUIokMmOGUlWLICQCTMBSo7AQGmoXQnLP/kNP
6b2jqXWGVoT+4nDPAi0rItO+g+YWrV8Nnx4BTS9SsiRrcAt7F2PsqrnScSRlRV49
2n4WjFkrFhb89173qEew760ZsBuMpM0q+vY203zclVvaS4Oh/mlZuPN98iOaG182
9PE3AtSJAhj6uUuaIsxsxNsO17OwpsVXniIKiogD7Z0Wqfjzp/+tIGMXXB0JoF8j
+88uLTUywCqYeKViUuyhzdMoBYN3aKPzx0Ye/m6PoILH5QbsfR3trGiec7bP/jeN
wsMi4LdmnkOu6y96liwyIiyNS4bGQUa0rroI/XreUT/HJOqIC0kwDhDwKze2m91o
bN8K4ZmD2KW/zPvUQn5Atp36UdD8fu3UER1b1ecS0gtf3HOvJvaEXoyileFNHZcg
7QD88daKOY8WI+Yi2ZsQBr+j9IZzPsNhpXwaEozfLSjm0AfsgY7rJtwIioZMMNxy
wWLp/myHU0cYQTr6UADV2Mb10GxvMBkwluGiFPMgUu2qh7MSHPJq2qhjlJiCPWij
pnqRL7cPcDs=
=9G6c
-----END PGP SIGNATURE-----
