Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbRGGXB4>; Sat, 7 Jul 2001 19:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265994AbRGGXBg>; Sat, 7 Jul 2001 19:01:36 -0400
Received: from zero.tech9.net ([209.61.188.187]:65028 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S265446AbRGGXB3> convert rfc822-to-8bit;
	Sat, 7 Jul 2001 19:01:29 -0400
Subject: Re: OOM: A Success Report
From: Robert Love <rml@tech9.net>
To: =?ISO-8859-1?Q?Jos=E9?= Luis Domingo =?ISO-8859-1?Q?L=F3pez?= 
	<jldomingo@crosswinds.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010708004051.A4765@dardhal.mired.net>
In-Reply-To: <20010708004051.A4765@dardhal.mired.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 07 Jul 2001 19:01:31 -0400
Message-Id: <994546903.1747.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 Jul 2001 00:40:51 +0000, José Luis Domingo López wrote:
> <snip>
> Another interesting thing I noted is the fact (as shown by Robert Love's
> message) that oom_kill() seems to kill processes without taking into
> account whether the selected process is a full application or just one
> of more "threads" in some application. This happened to me when OpenOffice
> went crazy and OOM hit, but instead of killing the parent process, it just
> killed one of the children and, though OOM recoverd memory, OpenOffice 
> ended useless. Maybe OOM should have killed the parent in the first place.

for whatever reason, i did not even notice this.  i guess because
evolution itself exited, for some reason (normally if a single component
dies, say mail, it just puts a dialog up saying `mail component died').

i think there may be problems with determining what the parent app is,
or if there is a parent app. killing the PPID may not always be the
answer (but in many cases, like what you gave, is a very good answer).

> Final question: a 2.4.4 kernel with no swap activated, and OOM hit (thanks
> to a purposedly executed ls ../*/../*/..) takes much more time to recover
> than the same setup but with swap activated (exact numbers missing,
> sorry). Moreover, when swap is of, the hard disk goes crazy as if it where
> using swap, when in fact it isn't). Is this expected behaviour ?

i think i recall hearing about this, and the reply was something to the
effect of `its known but not wanted'.

> If someone wants some test with real numbers, please let me know and
> though I'm on vacation, I'll go where I work to make some test :)

i forgot to give any stats from my incident. i couldnt access the
console (the machine was almost locked, the mouse barely moved), so i
dont have any hard numbers.

from my gnome applets <g> i see load was approaching 10, memory was (or
was close to) 100%, and swap was growing close to 100%.

this is kernel 2.4.6-ac2, x86, with 256MB memory, 768MB swap.

after the incident memory was done to the bare load with only 30MB of
cache and swap was only at about 20MB use.

i restarted X but not the system, and all is well.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

