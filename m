Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262276AbSKCSSH>; Sun, 3 Nov 2002 13:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262298AbSKCSSH>; Sun, 3 Nov 2002 13:18:07 -0500
Received: from unet4-112.univie.ac.at ([131.130.233.112]:3076 "EHLO
	darkstar.coarse.univie.ac.at") by vger.kernel.org with ESMTP
	id <S262276AbSKCSSG>; Sun, 3 Nov 2002 13:18:06 -0500
Message-ID: <3DC5D98D.E62A9883@unet.univie.ac.at>
Date: Mon, 04 Nov 2002 02:21:01 +0000
From: Piotr Sawuk <a9702387@unet.univie.ac.at>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.21 i586)
X-Accept-Language: de-AT, de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: modem-connection doesn't work in linux
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a new computer with k7d-master-l mobo and athlon-XP1600, I simply
copies everything from my old k6-200 and linux runs, except for the
modem. the modem works with the old k6-200 in linux and windows, but
it doesn't work for the new athlon -- especially as I re-compiled the
kernel to match the new hardware. the error is simple: after the chat
with dialing in and syncronizing (the whole thing with the sound), it
just gets stalled with the message

sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x494c248d> <pcomp> <accomp>]

repeated 9 times because of time-out and then ppp gives up. the interesting
thing is that I didn't change anything on the system except for the kernel
and one thing: strangely the chat-script does also stall (till time-out)
on the AT-command "AT%V" which is supposed to output firmware-infos, and
which of course works with the old k6 -- so I removed that command. so
there is no difference between the 2 systems except for hardware and the
resulting speed-up by factor 10. In windows98 the connection does work
on the new athlon. one difference between win98 and linux is that in
windows I got the possibility to set up my com-port to twice the speed
as reported by linux upon giving the spd_vhi option to setserial. they
say "never touch a running system", so my software is quite old and could
be the thing causing problems:

pppd version 2.3 patch level 5
kernel 2.2.21 (I don't know if the newer 2.4 kernel will take
               my old .config without tweaking, and I don't
               have time to check.)
compiled with the gcc from redhat6.2
setserial Version 2.12

apart from the kernel the programs originate from the old stampede
distribution version 0.89 (the newest would have been 0.90 from
a few years ago) -- all with pentium-optimization of a buggy pgcc.
Since I didn't change anything else I suspect the error in the
old kernel. am I wrong? please point me in the right direction.
I already tried to throw out everything from my chat-script except
for the &F and the actual connection-command, still no luck. I
really don'T know what to do next. is there any chance that the
new 2.4 kernel would change the situation? was anything changed
to that effect? did anybody else have a similar problem?

Please send me CC of this thread since I'm not subscribed...

P
