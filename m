Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286786AbRL1IkD>; Fri, 28 Dec 2001 03:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286788AbRL1Ijy>; Fri, 28 Dec 2001 03:39:54 -0500
Received: from f199.law10.hotmail.com ([64.4.15.199]:42505 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S286786AbRL1Ijn>;
	Fri, 28 Dec 2001 03:39:43 -0500
X-Originating-IP: [212.150.104.104]
From: "Q ED" <nib_maps@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] new aty128fb supported card?
Date: Fri, 28 Dec 2001 08:39:37 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F199vFC496l4XUXALZz0000df6d@hotmail.com>
X-OriginalArrivalTime: 28 Dec 2001 08:39:38.0006 (UTC) FILETIME=[2F47AB60:01C18F7B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a recent ATI 128 card (XPERT 2000 or something?).  In any case, lspci 
gives:

01:05.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro TF

or numerically:

01:05.0 Class 0300: 1002:5446

Now the aty128fb driver just ignores it gracefully.  Being no kernel hacker, 
it took me some time to discover the remedy, namely:

--- linux.old/drivers/video/aty128fb.c  Fri Dec 28 10:21:52 2001
+++ linux/drivers/video/aty128fb.c      Fri Dec 28 10:22:36 2001
@@ -154,6 +154,7 @@
     {"Rage128 RL (AGP)", PCI_DEVICE_ID_ATI_RAGE128_RL, rage_128},
     {"Rage128 Pro PF (AGP)", PCI_DEVICE_ID_ATI_RAGE128_PF, rage_128_pro},
     {"Rage128 Pro PR (PCI)", PCI_DEVICE_ID_ATI_RAGE128_PR, rage_128_pro},
+    {"Rage128 Pro TF (AGP)", PCI_DEVICE_ID_ATI_RAGE128_U1, rage_128_pro},
     {"Rage Mobility M3 (PCI)", PCI_DEVICE_ID_ATI_RAGE128_LE, rage_M3},
     {"Rage Mobility M3 (AGP)", PCI_DEVICE_ID_ATI_RAGE128_LF, rage_M3},
     {NULL, 0, rage_128}

Any chance of getting it into the kernel?

Please CC answers, as I am not subscribed.

Thanks :)


_________________________________________________________________
Chat with friends online, try MSN Messenger: http://messenger.msn.com

