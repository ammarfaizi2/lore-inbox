Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314587AbSD0Evl>; Sat, 27 Apr 2002 00:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314589AbSD0Evk>; Sat, 27 Apr 2002 00:51:40 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:26086 "EHLO
	pimout4-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S314587AbSD0Evj>; Sat, 27 Apr 2002 00:51:39 -0400
Subject: The tainted message
From: Richard Thrapp <rthrapp@sbcglobal.net>
To: linux-kernel <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 26 Apr 2002 23:51:41 -0500
Message-Id: <1019883102.8819.48.camel@wizard>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I originally took this up with Keith Owens, but he said I should bring
the discussion here since the message was chosen here (although I  could
not find where in the archives), and that he might change it if I get
the approval of Alan Cox.

I just discovered semi-recently (a couple of months ago) that newer
versions of modutils have an insmod that prints out the tainted warnings
for non-GPL licenses.  While I agree that printing a warning when
installing a non-GPLed module is important to inform the user that their
kernel is no longer supported by the kernel maintainers, I have issues
with the exact message printed.

First of all, the current tainted message is not really useful. 
"Warning: Loading %s will taint the kernel..." isn't very informative at
all.  Most people don't know what it means to "taint the  kernel".  It's
a vague phrase in English, and only if you know the current kernel
source (or at least some of the semi-recent discussions on kernel
tainting) is its meaning clear.  As a matter of fact, it makes it sound
like the module has a virus in it that has just infected your kernel. 
As Linux becomes more common for non-experts, it becomes even more
important for error and informational messages to be clear.

Secondly, loading the module doesn't actually 'taint' the kernel, but
instead it mostly invalidates your chances for support from the core
kernel maintainers.

Thirdly, the warning that loading the module "will" taint the kernel is
an inaccurate use of tense.  It implies that the module wasn't loaded
(which might be true at that time from the point of view of the code,
but is not true from the point of view of the user, which is who the
message is written for).  I have actually had bug reports where users
complain that a module won't load because of the tense of this message.

I would like to propose that a clearer, more direct message be used. 
Something like "Warning: kernel maintainers may not support your kernel
since you have loaded %s: %s%s\n" would be much more informative and
correct.

Opinions?  Comments?

Thanks!

-- Richard Thrapp


