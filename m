Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319081AbSIDH3E>; Wed, 4 Sep 2002 03:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319088AbSIDH3E>; Wed, 4 Sep 2002 03:29:04 -0400
Received: from mta.sara.nl ([145.100.16.144]:3515 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S319081AbSIDH3D>;
	Wed, 4 Sep 2002 03:29:03 -0400
Date: Wed, 4 Sep 2002 09:33:19 +0200
Subject: Re: [PATCH] include/linux/ptrace.h Re: Kernel 2.5.33 compile errors (Re: Kernel 2.5.33 successfully compiled)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: Oliver Pitzeier <o.pitzeier@uptime.at>, <donaldlf@cs.rose-hulman.edu>,
       <linux-kernel@vger.kernel.org>, <ink@jurassic.park.msu.ru>
To: Thunder from the hill <thunder@lightweight.ods.org>
From: Remco Post <r.post@sara.nl>
In-Reply-To: <Pine.LNX.4.44.0209031635160.3373-100000@hawkeye.luckynet.adm>
Message-Id: <9556288E-BFD8-11D6-8DD9-000393911DE2@sara.nl>
Content-Transfer-Encoding: 7bit
X-Pgp-Agent: GPGMail 0.5.3 (v20)
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


On woensdag, september 4, 2002, at 12:37 , Thunder from the hill wrote:

> Hi,
>
> On Wed, 4 Sep 2002, Remco Post wrote:
>> Attached patch worked for _compiling_ on my powermac, it might help for
>> you as well....
>
> I'd rather not include sched.h into ptrace.h, for that way lies madness.
> You get all the crappy headers when you only include one of them. I'm 
> not
> saying the change itself is wrong. It's indeed effective. But it's that
> cleanup vs. messup thing.
>

Hmm, that depends,

I do not fully agree with you on this.

_if_ the defenitions in ptrace.h depend on definitions in sched.h _then_ 
we _MUST_ include sched.h in ptrace.h or repeat that definitions in 
ptrace.h, which will become messier even, since that will introduce two 
places to update when that defintion changes. If otoh it is irq.c that 
depends on the definitions from sched.h, than that is the place to 
include sched.h.

Now, for what I've seen, in this case ptrace.h is the file to patch, 
unless I remember the output wrong (I do not have it in front of me 
right now), my patch (which I got of this list as well, or the hint on 
what to do) is the patch for this problem.

- ---
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam    http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167
PGP keys at http://home.sara.nl/~remco/keys.asc

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer 
industry
didn't even foresee that the century was going to end." -- Douglas Adams


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (Darwin)

iD8DBQE9dbdIBIoCv9yTlOwRAiCrAJ9wwhRp19/oFjABVXcUsunsQ4ZW+gCeIOqD
pjnua0Vw5woZvT87Q/FXQcU=
=aNu2
-----END PGP SIGNATURE-----

