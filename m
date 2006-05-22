Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWEVTHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWEVTHX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWEVTHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:07:23 -0400
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:37631 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750951AbWEVTHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:07:22 -0400
Message-ID: <44720ACB.7040808@comcast.net>
Date: Mon, 22 May 2006 15:02:35 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060518)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.16 Parameter-controlled mmap/stack randomization
References: <446E6A3B.8060100@comcast.net> <1148132838.3041.3.camel@laptopd505.fenrus.org> <446F3483.40208@comcast.net> <20060522010606.GC25434@elf.ucw.cz> <44712605.4000001@comcast.net> <20060522083352.GA11923@elf.ucw.cz> <4471E77F.1010704@comcast.net> <20060522170036.GD1893@elf.ucw.cz> <4471FAD0.9060403@comcast.net> <20060522184003.GD2979@elf.ucw.cz>
In-Reply-To: <20060522184003.GD2979@elf.ucw.cz>
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
>>> Well, fix emacs then. We definitely do not want 10000 settable knobs
>>> that randomly break things. OTOH per-architecture different randomness
>>> seems like good idea. And if Oracle breaks, fix it.
>> Fix this, fix that.  In due time perhaps.  I'm pretty sure Linus isn't
>> going to break anything, esp. since his mail client breaks too.
> 
> Good. So fix emacs/oracle/pine, and year or so and some time after it
> is fixed, we can change kernel defaults. That's still less bad than
> having
> 
> [ ] Break emacs
> 
> in kernel config.

Nobody is going to fix emacs/oracle/pine, they don't have to.  Nothing
is making them.  The kernel will wait for them so who cares.

> 
>> Why should it NOT be configurable anyway?  If you don't configure it,
>> then it behaves just like it would if it wasn't configurable at all.
>> This is called "having sane defaults."
> 
> Because if it is configurable, someone _will_ configure it wrong, and
> then ask us why it does not work.

Oh big deal.  People configure out ide drivers and ask why their kernel
doesn't boot all the time.  Distro maintainers do most of the work.

This is a weak argument, bordering FUD.  It's the same argument as
everything else, except we just said, "Well not really important"
everywhere else.

> 
> And if it is configurable, applications will not get fixed for
> basically forever.

FUD.  If it's not configurable, applications will not get fixed for
basically forever, and nobody will put the breaking code into mainline.
 Linus is NOT giving 256M/256M randomization on mainline as default ever.

> 
>>> Per-architecture ammount of randomness would be welcome, I
>>> believe. That will force Oracle to fix their code, but that's okay,
>>> and you can use disable PF_RANDOMIZE for Oracle in meantime.
>> No, this would leave Oracle shipping binaries with PF_RANDOMIZE
>> (PT_GNU_STACK still?) disabled.  Also if PF_RANDOMIZE is still connected
>> to PT_GNU_STACK, then this means that randomization is turned off BY
>> MAKING THE STACK EXECUTABLE.  You should notice the obvious problem
>> here.  You should also understand that as long as they can simply switch
>> randomization off, they're not going to fix it; and as long as it breaks
>> Oracle/Emacs/anything, Linus is not going to impose non-disablable,
>> non-adjustable randomization.
> 
> I believe that Linus is going to apply this one even less likely.

Apply what?  It's already like that.  The kernel is set to be able to
switch randomization off based on a header in the binary.  That header,
as of 2.6.12, was PT_GNU_STACK if I recall correctly; this same header
switches the stack to non-executable.  Unless Linus accepted a patch to
follow ANOTHER field, and upstream binutils has changed it, and all
distributions have reflexed to use the new toolchain, it's still like this.

> 
> 								Pavel

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

iQIVAwUBRHIKyQs1xW0HCTEFAQJMVQ//WM+FqtIvJZdNFhbISZAcdQbklYVYtZds
oo+ea2/lgD+4JDTDUWVphlsyjiCHL+7QMGSQJ2t6WMFBOPFyKlW98/Q9TYksAady
cDkVecY1XJ/iLaRnOoxu+GlZFVkNARG50bYVTkbWnNiHZezu1c8kZ7p/0XrlkxEl
zDql/0281vE6/pkGAnRsgaCCGPZVYAtq06zteCIIdcb+UIoRssOpCZb8ldDGQKGw
Kw3Lguc7ynJCOS9eS2rm92aq+Mh/XC7SEb7VJu5H5lTjAkMJVVvDvE0C+BJ+lFuc
uaU8zjkhLBrYHu1jsHpDwCkrGf0jIhjjctfNaWfab6rW92JrcNpY+Jp+nGPz67x/
DxAG3ZPcQA/o+ltaVdcGFYPcDPhJ0soXrtVAjBAe5NnbE606ELnhTq2d85n8ZWBh
7SxDEN9pIyyFfVbvs0TubUC/5icb7Y4Bn1c3PoUKO4HHaSkKvIp5jWvd6daaD57d
AqeaSqSXU+Hs5reXL2hLV+C0/wTKggs6bsapu3P8/pETgr8/odsX3wAUz6YVfvI1
vF9ybN3kNYJTNoGpFoCH4buUJJBsXIhLLfautcb9d2mJ0j2kwm4CQOInyob4Tp/A
k8WYKSwlKuKSsgCdQinjjEDAqKs8GOVO7OO/nw1se7yCKHsTFC3Wc4or8iWMyyiP
IBKcRKkSzIg=
=iyBd
-----END PGP SIGNATURE-----
