Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130918AbQKPQV4>; Thu, 16 Nov 2000 11:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130789AbQKPQVq>; Thu, 16 Nov 2000 11:21:46 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:21492 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130918AbQKPQVg>; Thu, 16 Nov 2000 11:21:36 -0500
Date: Thu, 16 Nov 2000 13:51:01 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: pavel-velo@bug.ucw.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>
Subject: RE: KPATCH] Reserve VM for root (was: Re: Looking for better VM)
In-Reply-To: <Pine.LNX.4.30.0011161513480.20626-100000@fs129-190.f-secure.com>
Message-ID: <Pine.LNX.4.21.0011161313310.13085-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2000, Szabolcs Szakacsits wrote:

	[snip exploit that really shouldn't take Linux down]

> This or something similar didn't kill the box [I've tried all local
> DoS from Packetstorm that I could find]. Please send a working
> example. Of course probably it's possible to trigger root owned
> processes to eat memory eagerly by user apps but that's a problem in
> the process design running as root and not a kernel issue.

Not necessarily, but your patch will probably make a difference
for quite a number of people...

> If you think fork() kills the box then ulimit the maximum number
> of user processes (ulimit -u). This is a different issue and a
> bad design in the scheduler (see e.g. Tru64 for a better one).

My fair scheduler catches this one just fine. It hasn't
been integrated in the kernel yet, but both VA Linux and
Conectiva use it in their kernel RPM.

> BTW, I have a new version of the patch with that Linux behaves
> much better from root's point of view when the memory is more
> significantly overcommited. I'll post it if I have time [and
> there is interest].

There is interest, believe me ;)

While this is not one of the sexy new kernel
features, this will help quite a few system
administrators and is destined to a long and
healthy life inside kernel RPMs, maybe even
in the main kernel tree (when 2.5 splits?).

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
