Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312415AbSCYMda>; Mon, 25 Mar 2002 07:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312417AbSCYMdR>; Mon, 25 Mar 2002 07:33:17 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:62445 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S312415AbSCYMdC>; Mon, 25 Mar 2002 07:33:02 -0500
Date: Mon, 25 Mar 2002 13:32:22 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: lkml <linux-kernel@vger.kernel.org>
Subject: Keyboard problem under heavy load in recent -ac kernels
Message-ID: <Pine.NEB.4.44.0203241652330.2125-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've seen several times the following problem (it's not 100% but
relatively good reproducible) in 2.4.19-pre3-ac kernels (I've seen it in
at least ac4 and ac6) but not in -pre3 or -pre4:

Hardware:
- AMD K6/300
- VIA vt82c586b (rev 41) IDE with two 20 GB drives (using UDMA(33))
- 128 MB RAM

Workload:
- X (fvwm, XFree86 4.1 on a Debian unstable)
- xmms
- heavy disk IO on the same HD, e.g:
  - two "tar xzf linux-2.4.18.tar.gz"
  - one "nice rm -rf linux-2.5.7"

Starting from some point no single letter I type on my keyboard reaches an
xterm when I try to write something there but X is still responsive. This
means I can start applications and work inside them - but at the same time
no single letter arrives when I try to type in an xterm. After this
phenomenon is over all letters I typed in different xterms occur in the
xterm that is active at this time.

To make it more visible:
I tried to start Gimp from the fvwm menu after I typed a letter - and
Gimp has completed its startup before the letter arrived in the xterm.

Is there any information I should collect when I observe this the next
time?

cu
Adrian

BTW: I'll be away from home for one week which means I might not be able
     to reply to emails immediately.


