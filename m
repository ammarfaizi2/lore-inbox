Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129572AbQLaEkI>; Sat, 30 Dec 2000 23:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135698AbQLaEj5>; Sat, 30 Dec 2000 23:39:57 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:3252 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129572AbQLaEjp>;
	Sat, 30 Dec 2000 23:39:45 -0500
Date: Sat, 30 Dec 2000 23:09:02 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Ton Hospel <linux-kernel@ton.iguana.be>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: multiple mount of devices possible 2.4.0-test1 -
In-Reply-To: <200012310348.eBV3mVA159133@saturn.cs.uml.edu>
Message-ID: <Pine.GSO.4.21.0012302254040.4082-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Dec 2000, Albert D. Cahalan wrote:

> Alexander Viro writes:
> 
> > [...] Not allowing multiple mounts of the same
> > fs was an artifact of original namei() implementation. At some point
> > (late 80s) it had been fixed by Bell Labs folks in their branch. In Linux
> > it had been fixed during the last spring. That's it. You were never promised
> > that multiple mounts will not work. Moreover, in special cases they did work
> 
> Heh. :-)
> 
> 1. go to http://www.linuxcertification.com/resources/quizzes/
> 2. take the "System Administration" quiz
> 3. try answering question 6 correctly

ITYM s/6/7/.
 
None of the variants. A: version-dependent and "just like" part is seriosuly
misleading. B: would be correct for old versions _if_ they would add "and
filesystem is presumed to be block-based". As it is, statement is blatantly
incorrect - some filesystems always could be mounted in many places. C:
not even funny. _None_ of the UNIX flavours I've seen has such limitation -
they either refuse to do second mount at all or they do not care about
relative location in the tree. D: see C.

Correct answer: on versions prior to 2.4 block-based filesystems can be
mounted only once. On 2.4 either do mount -t <whatever> /dev/hda2 /users
or mount --bind /var /users.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
