Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267266AbTBDOJi>; Tue, 4 Feb 2003 09:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267280AbTBDOJi>; Tue, 4 Feb 2003 09:09:38 -0500
Received: from main.gmane.org ([80.91.224.249]:63446 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S267266AbTBDOJg>;
	Tue, 4 Feb 2003 09:09:36 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: John Goerzen <jgoerzen@complete.org>
Subject: Re: Kernel 2.4.20 panic in scheduler
Date: Tue, 04 Feb 2003 08:18:30 -0600
Organization: Complete.Org
Message-ID: <87vg005du1.fsf@christoph.complete.org>
References: <877kch8286.fsf@christoph.complete.org> <002901c2cc1a$bc53f4f0$3f00a8c0@witbe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@complete.org
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (powerpc-unknown-linux-gnu)
Cancel-Lock: sha1:RWy4gc++Ly2xfBaBgc8nWc5LsPQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul Rolland" <rol@as2917.net> writes:

> Maybe unrelated, maybe not...
> I too have a Dell 2650, Perc 3/Di and bcm5700, running 2.4.20...

Are you running the RedHat kernel?

If so, check out:

http://lists.us.dell.com/pipermail/linux-poweredge/2002-November/010486.html

There have been many reports on the PowerEdge list of trouble with the
tg3 driver in various RedHat kernels.  To date, it seems that the tg3
driver in the stock Linus kernels does not cause the hang, though
there may be some other bugs, especially wrt IPv6.  Specifically,
there are serious incompatibilities with Apache when running IPv6:

http://lists.us.dell.com/pipermail/linux-poweredge/2003-February/011532.html

> What I see is the machine hang (really hang, nothing on the console,
> still pinging but nothing else) why doing two or three simultaneous
> copy of a 2 Gb file between the three 75Gb disks I have...

Sounds like the tg3 bug people have been complaining of.

> I other question : bcm5700 is supported in RedHat, as a module
> only. At the same time, Kernel includes support for Broadcomm
> Tigon3... Is it safe to use Tigon3 driver with a bcm5700 hardware ?

As above, it seems it is OK to do so if you are NOT running a RedHat
kernel and you are NOT using IPv6.

The PowerEdge list is a good one.  A couple of Dell and RedHat hackers
hang out there, and although I run Debian exclusively, if you want
info about your particular hardware, it's a good place to check.

-- John

