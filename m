Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291962AbSBTQYF>; Wed, 20 Feb 2002 11:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291963AbSBTQX4>; Wed, 20 Feb 2002 11:23:56 -0500
Received: from dyn-212-129-46-228.ppp.libertysurf.fr ([212.129.46.228]:34334
	"EHLO quark.albert-inc.com") by vger.kernel.org with ESMTP
	id <S291962AbSBTQXp> convert rfc822-to-8bit; Wed, 20 Feb 2002 11:23:45 -0500
Message-ID: <3C73CD8D.A92548EC@club-internet.fr>
Date: Wed, 20 Feb 2002 17:23:41 +0100
From: Frederic Olivie <alf@club-internet.fr>
Organization: None
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Weird behavior on network shells. e.g.: nanosleep hangs forever
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When connecting to this box with either ssh or telnet, I
experience very weird behaviors :

- ssh delays typed characters (each time I type in something,
it displays the previous character I typed). Like if the output
buffer would be flushed one step late.

- top won't display.

- And, the most intriguing : nanosleep will hang forever.
The top problem seems related to the nanosleep one (according
to strace).
The ssh one, maybe also. I haven't been able to trace properly.

I could reproduce this easily with "strace sleep 1".
The last line gives : nanosleep({1, 0}
and hangs there until interrupted by a ctrl-c (or, I guess lots
of different signals).

1) It does NOT happen on the console.
2) It does happen sometimes suddenly (even if idle for a while).
I know that the definition of "sudden" seems weird, but it's the case.
3) If I disconnect the network cable and reconnect it, the problem
disappears.....

The box is :

- DELL Dimension 8100
- Pentium 4 1.3G
- 512M RAMbus (non-ECC)
- SuSE 7.3 with recompiled kernel 2.4.16.SuSE + freeswan 1.92
- No load at all. Nothing on the box yet. I actually just
work on different scripts for configuring it (so, emacs + ssh).
- 2 network interfaces:
	* 1 builtin 3c905C which I use
	* 1 added basic PCI 8139 chipset card. Unused. Unconfigured.

The problem might be tied in some way to the 3c59x driver. I can't tell.
I have not toroughly tested the other interface yet.

Previously, I'd use the stock SuSE 7.3 kernel (2.4.10.SuSE). The problem
would happen much more often. It's the first time since I upgraded
to 2.4.16.SuSE (I shut it down often. Last uptime ~ 22h before the
problem).

I know this sounds weird, and I also know I don't bring in much help.
I'm ready for any testings any of you guys would be interested in.

Thanks a lot in advance for any help.

--
Frédéric Olivié (Alf)
Mailto: alf@club-internet.fr
Phoneto: +33 603 03 33 50

Very funny Scotty... Now beam down my clothes (Capt. James T. Kirk.
Starship Enterprise).
