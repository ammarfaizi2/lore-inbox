Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282842AbRK0Hwp>; Tue, 27 Nov 2001 02:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282844AbRK0Hwf>; Tue, 27 Nov 2001 02:52:35 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:38817 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S282842AbRK0HwV>;
	Tue, 27 Nov 2001 02:52:21 -0500
Message-ID: <XFMail.20011127085220.backes@rhrk.uni-kl.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Tue, 27 Nov 2001 08:52:20 +0100 (CET)
X-Face: B^`ajbarE`qo`-u#R^.)e]6sO?X)FpoEm\>*T:H~b&S;U/h$2>my}Otw5$+BDxh}t0TGU?>
 O8Bg0/jQW@P"eyp}2UMkA!lMX2QmrZYW\F,OpP{/s{lA5aG'0LRc*>n"HM@#M~r8Ub9yV"0$^i~hKq
 P-d7Vz;y7FPh{XfvuQA]k&X+CDlg"*Y~{x`}U7Q:;l?U8C,K\-GR~>||pI/R+HBWyaCz1Tx]5
Reply-To: Joachim Backes <backes@rhrk.uni-kl.de>
Organization: University of Kaiserslautern,
 Computer Center [Supercomputing division]
From: Joachim Backes <backes@rhrk.uni-kl.de>
To: LINUX Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.12 ... 2.4.16, /dev/tty
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

still having problems (starting with kernel 2.4.12) with
the /dev/tty device:

When logging in on the console and trying the "ps" command,
is will list  _all_ processes and not only those which are
attached to the controlling terminal. This seemed a little
bit suspicious.

Now, trying

        echo some text >/dev/tty

returns 

        bash: /dev/tty: No such device or address

Now trying the command

        tty

says 

        /dev/tty1

Now, I tried

        echo some text >/dev/tty1

It echoed correctly

        some text

on the console.

Then, I tried

        echo some text >/dev/tty

Now (!!!???) it echoes correctly "some text".

It seems that the cmd

        echo some text > `tty`

will repair something, but I don't no what and why.

-----------------------------------------------------

The above described problem first appeared with Kernel 2.4.12,
I tried the following kernels (now 2.4.16), BUT WITH NO SUCCESS.
Kernel 2.4.10 was _not buggy_.

Additionally, the problem does not arise on all my LINUX workstations,
but only on some. And it does not depend on the harware platform.
And is does not depend on the distribution. Both on RedHat 7.1 ans
Redhat 7.2 having the problem.

Regards


Joachim Backes

--

Joachim Backes <backes@rhrk.uni-kl.de>       | Univ. of Kaiserslautern
Computer Center, High Performance Computing  | Phone: +49-631-205-2438 
D-67653 Kaiserslautern, PO Box 3049, Germany | Fax:   +49-631-205-3056 
---------------------------------------------+------------------------
WWW: http://hlrwm.rhrk.uni-kl.de/home/staff/backes.html  

