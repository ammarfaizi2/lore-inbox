Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbQLaA2n>; Sat, 30 Dec 2000 19:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQLaA2e>; Sat, 30 Dec 2000 19:28:34 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:15320 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129348AbQLaA2S>;
	Sat, 30 Dec 2000 19:28:18 -0500
Date: Sat, 30 Dec 2000 18:57:43 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Ton Hospel <linux-kernel@ton.iguana.be>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: multiple mount of devices possible 2.4.0-test1 -   
 2.4.0-test13-pre4
In-Reply-To: <92lpm4$nvr$1@post.home.lunix>
Message-ID: <Pine.GSO.4.21.0012301829190.4082-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Dec 2000, Ton Hospel wrote:

> It should still need a special flag or something, since it's
> impossible for userspace to check this atomically.

To check _what_? Having the same tree mounted in several places is
allowed. End of story. Atomicity of any kind is a non-issue - if you
have processes that do not cooperate and do random mounts you are
getting exactly what you are asking for.

BTW, mount(2) is outside of POSIX scope. Ditto for SuS, so references to
standards are not likely to work. Not allowing multiple mounts of the same
fs was an artifact of original namei() implementation. At some point
(late 80s) it had been fixed by Bell Labs folks in their branch. In Linux
it had been fixed during the last spring. That's it. You were never promised
that multiple mounts will not work. Moreover, in special cases they did work
since long - e.g. Linux procfs could be mounted in several places since
'94, if not earlier. AFAIK NFS implementations allowed the same thing
since mid-80s...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
