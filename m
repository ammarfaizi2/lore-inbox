Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283577AbRK3Ja1>; Fri, 30 Nov 2001 04:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283581AbRK3JaO>; Fri, 30 Nov 2001 04:30:14 -0500
Received: from web20506.mail.yahoo.com ([216.136.226.141]:8200 "HELO
	web20506.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S283577AbRK3J2y>; Fri, 30 Nov 2001 04:28:54 -0500
Message-ID: <20011130092853.20937.qmail@web20506.mail.yahoo.com>
Date: Fri, 30 Nov 2001 10:28:53 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Did someone try to boot 2.4.16 on a 386 ?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I just happened to test 2.4.16 on my 386 (firewall)
and 
just after the message "Uncompressing kernel", the PC
reboots just as after an illegal op, or a triple
fault. I tried
to diff between 2.4.13-ac8 (which previously worked)
and 2.4.16, but I don't see many changes (except the
CR2 patch that I reverted in 2.4.13-ac8 anyway, and
which is still not present in 2.4.16).

I also checked for illegal instructions like there has
already been in the past (cmov, bswap, cmpxchg) but
couldn't find any. I could only find some rdmsr, wrmsr
and cpuid in functions which, to my knowledge, are not
called when an i386 boots.

I'm sorry I don't have the .config right here, but
it's
simply minimalistic : module, ide, iptables, serial
console. Of course, I've already checked there were no
accidental CONFIG_SMP nor MTRR ...

The system has 8 MB of RAM, and 16 MB of
CompactFlash connected to the IDE controller. The
onboard VGA is enabled and didn't cause any problem
before, but it may be possible that the reboots
happens
when the system tries to change the video mode.

Since I spent a long time recompiling with several
options, I didn't yet test if vanilla 2.4.13-2.4.15
could
boot on this PC. I didn't test with a serial console
either.

So my two questions are :
  - does anybody happen to boot 2.4.16 on a 386 ?
  - does someone have an idea of another change in the

    kernel that could affect its boot on such a
machine ?

Regards,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Courrier : http://courrier.yahoo.fr
