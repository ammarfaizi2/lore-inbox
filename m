Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129828AbQK0JGH>; Mon, 27 Nov 2000 04:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129793AbQK0JF6>; Mon, 27 Nov 2000 04:05:58 -0500
Received: from 13dyn33.delft.casema.net ([212.64.76.33]:60168 "EHLO
        abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
        id <S129548AbQK0JFv>; Mon, 27 Nov 2000 04:05:51 -0500
Message-Id: <200011270835.JAA16502@cave.bitwizard.nl>
Subject: Re: Universal debug macros.
In-Reply-To: <Pine.LNX.4.10.10011270302570.24716-100000@yle-server.ylenurme.sise>
 from Elmer Joandi at "Nov 27, 2000 03:11:21 am"
To: Elmer Joandi <elmer@ylenurme.ee>
Date: Mon, 27 Nov 2000 09:35:45 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elmer Joandi wrote:
> 
> 
> On Mon, 27 Nov 2000, Rogier Wolff wrote:
> 
> > Now, how is say "Red Hat" (*) going to ship kernels? Of course they are
> > going to turn off debugging. Then I'll be stuck with a non-recompiling
> > user-in-trouble with a non-debugging-enabled kernel. 
> 
> Red Hat will ship two kernels. Well, they actually ship now about 4 ones
> or something. So they will ship 8.
> 
> Plus they will ship a script that recompiles kernel without user crawling
> in documentation.

It's not that Red Hat can't make a script that automatically recompiles
a certain package like the kernel. That's what a source-RPM actually IS. 

People will want to upgrade to the latest kernel. People happen to
have deselected the compiler, or another essential tool for compiling
the kernel.

I've had LOTS of trouble myself when I wanted to upgrade a certain
machine which happened to be a '486 with 16M RAM intended as a
mail-router. So the machine had a minimal install: It started out with
a 170Mb disk. And you want 100Mb of mail-spool don't you. Well try and
cram a current distribution into 80M. That's kind of hard. So I had
agressively removed all packages I didn't need. Then suddenly there is
stuff that requires a kernel recompile (and it didn't want to work on
the system that I have for kernel-compiles), and you find out that if you
don't do the recommended install you miss quite a lot of packages that
are required for the kernel compile. 

That's the kind of trouble that people end up running into. It took me
a while to figure it out. What do you expect from non-kernel hacking
random citizens?

The idea is, by the way, that you NEVER EVER want to run a kernel
without the double checks. Donald has a define at the top of his
drivers that defines the debug level, and I've never seen that at
"production". Similarly there are lots of "debugging" asserts in the
Linux kernel, that theoretically can go. Those need to stay to keep
Linux from crashing uncontrollably when things go slightly bad.

"Slightly bad" could be that a bit in memory falls over. "Slightly
bad" could be that a new bug in a driver is about to be found. 

Andries calls this "globally correct". If your analysis of the kernel
finds that some assertion always holds, you could remove the check for
this pre-condition (the "assertions). Turns out that people will
prefer to run the "performance" kernel, and they will send in useless
bugreports like "my just hangs" much more often than now.

We'll end up in the current Windows situation where rebooting is
likely to help out. At first Linux will still be as stable as it is
now, but as soon as we start to lose half the useful bugreports to the
"sudden-hang"(*) monster, we'll quickly go downhill towards the
current state-of-affairs with MSWindows. 

				Roger.

(*) Or the "crashes spectacularly a few hours after the problem
actually accurred".

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
