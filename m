Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbUCMS0j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 13:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUCMS0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 13:26:39 -0500
Received: from smtp.wp.pl ([212.77.101.160]:23718 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S263158AbUCMS0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 13:26:37 -0500
Date: Sat, 13 Mar 2004 19:27:12 +0100
From: Marek Szuba <scriptkiddie@wp.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.4, or what I still don't quite like about the new stable branch
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-ChangeAV: 0
X-WP-AntySpam-Rezultat: NIE-SPAM
Message-Id: <S263158AbUCMS0h/20040313182637Z+893@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

First of all, let me get one thing clear: I really like what has been
done in the 2.5/2.6 kernel branch and am full of admiration for the
efforts of everyone who made it possible. In fact, I've been following
the new line since late 2.5s and am running 2.6.4 right now... I'll say
that again, it's a fine piece of work.
However, there have been some - pretty much minor considering the whole
image, but rather annoying neverthless - issues which make the
experience far from the optimum. Knowing "stable" doesn't necessarily
equal "mature", I waited for them to be resolved and indeed most of them
have; now that 2.6.4 has been released and the list has shrunk to minute
size, I've decided to share my reservations and (it is quite likely that
some of these things only require an answer and not a bug fix) with the
High Instance.

Anyhow, what I still don't quite like, or would like to know more, about
the 2.6.x branch:

1. Matrox framebuffer keeps on messing up the consoles when I have X
running and switch back and forth. As far as I know this problem is
known to you (in fact, I use the temporary workaround patch Petr has
released which as far as I can see only leaves the issue of scrolling
lines occasionally losing the screen bottom, especially with programs
using ncurses) and besides things seem to have got much better thanks to
the general-fbcon patches introduced in 2.6.3 and 2.6.4, so I only
mention it here pro forma.

2. While fbcon is active, setfont only works on the foreground VT. It
happens with X both running and not running, as well as on both matroxfb
and vesafb (I haven't tested the others); I don't think this is a kbd
bug (my version is 1.10 and I don't see anything in the 1.10->1.12
changelog which could be related with the issue). Hope this one gets
fixed soon, as it's the most annoying of the whole bunch.

3. Junk left in the source root after 'make clean'. Is it really
supposed to stay there? If so, could I get told why? By "it" I mean the
two .tmp_vmlinux and the four .tmp_kallsyms files, taking up
approximately 8 MB of disk space on my system.

4. Module autounloading. Is it actually possible? Will it be possible?
If not, why? The old method of periodically invoking "modprobe -ras" via
cron doesn't seem to accomplish anything and I really liked the idea of
keeping only the required modules in memory at any given moment without
having to log in as root to unload the unneeded ones - after all, if the
autoloader can only add them what's the point of not going the
monolithic way? The docs on the new approach towards modules are
virtually nonexistent in the kernel source package and while I suppose I
could simply write a script which would scan the list of
currently-loaded modules for the unused ones and remove them one by one,
but this approach feels terribly crude comparing with the elegance of
the old solution. I use module-init-tools-3.0, a serious improvement
over 0.9.15 if I may say so but, unless I'm thinking about it with
completely wrong base assumptions, still far from perfect.

That's all. Not much, isn't it? Since at least in case of the latter two
I seem to be wandering in the dark rather than facing actual bugs, I'll
be grateful for all the explanations and sound advice you'd care to give
me. And once again, keep up the good work!

Regards,
-- 
MS
