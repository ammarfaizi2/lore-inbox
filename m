Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292702AbSCJCch>; Sat, 9 Mar 2002 21:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292727AbSCJCcR>; Sat, 9 Mar 2002 21:32:17 -0500
Received: from mx0.gmx.net ([213.165.64.100]:45350 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S292702AbSCJCcL>;
	Sat, 9 Mar 2002 21:32:11 -0500
Date: Sun, 10 Mar 2002 03:31:51 +0100 (MET)
From: Kai Engert <kai.engert@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: kai.engert@gmx.de
MIME-Version: 1.0
Subject: [patch] Missing module for ISDN / AVM PCMCIA card
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0002126097@gmx.net
X-Authenticated-IP: [62.144.236.48]
Message-ID: <21752.1015727511@www61.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel developers,

when using the stock 2.4.x kernel on RedHat 7.x, the
device
http://www.avm.de/en/products/hardware/FRITZ_Card/FRITZ_Card_PCMCIA/index.html
does not work, because of a missing module (avma1_cs). However, it works
with RedHat's kernel.

You can look at
  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=50999
for a discussion, that led to the inclusion of the missing patch in the
RedHat kernel.

When I apply the patch posted at:
  ========================>
  http://uwsg.iu.edu/hypermail/linux/kernel/0103.1/att-0957/01-avmdiff
  <========================
into any 2.4.x kernel (including 2.4.18), the card immediately works on my
Dell Laptop.

Could you please consider including this patch in the standard kernel?

The patch was attached to a message available at:
  http://uwsg.iu.edu/hypermail/linux/kernel/0103.1/0957.html

I think, this patch is based on a work described at:
  http://www.wimmer-net.de/avm-pcmcia/
(looks outdated, patches there did not help me)

Cheers,
Kai

(Please note that Red Hat seems to have modified that patch a little, the
file included in their kernel 2.4.9-31 has 3 lines changed. Let me know if you
want me to send you their file, I can't judge whether their changes are
needed for 2.4.18. They also moved the file to drivers/isdn/hisax/avma1_cs.c,
while the above patch places it at drivers/isdn/pcmcia/avma1_cs.c.)

(I'm not subscribed to this list, please CC me on answers, thanks a lot!).

