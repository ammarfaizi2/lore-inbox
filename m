Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbSIWTgj>; Mon, 23 Sep 2002 15:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261328AbSIWSle>; Mon, 23 Sep 2002 14:41:34 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261306AbSIWSl1>;
	Mon, 23 Sep 2002 14:41:27 -0400
Date: Mon, 23 Sep 2002 17:53:55 +0200
From: Norbert Nemec <nobbi@theorie3.physik.uni-erlangen.de>
To: linux-kernel@vger.kernel.org
Subject: Serious Problems with PCI and SMP
Message-ID: <20020923155355.GA565@cognac.physik.uni-erlangen.de>
Reply-To: Norbert Nemec <nobbi@theorie3.physik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

after some more tests, I couldn't find a solution for this problem:

We have a number of machines with identical dual PPro 200 mainboards. They all
run fine on 2.2.13 kernels. Trying 2.4.18,2.4.19,2.4.20-pre7 and even 2.2.19, the same
problem shows up:

With SMP activated in the kernel, I get the boot-messages

---------
PCI: PCI BIOS revision 2.10 entry at 0xfb0a0, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
Limiting direct PCI/PCI transfers.
---------

Afterwards, everything runs fine, except that PCI seems to be only half-way functional:
network-cards don't give any error messages but behave just as if the cable was disconnected
scsi-cards give strange errors (don't recall what exactly)

With SMP disabled in the kernel, everything works just fine.

Neither lspci nor any other status report tool does show any signs of a problem.
Everything looks identical with or without SMP, except of course for the
missing second processor and all the signs that would show up if I disconnected
the network cable.

I tried CONFIG_PCI_GOBIOS and CONFIG_PCI_DIRECT, but it didn't make any difference.

I would really appreciate help! There's a number of rather important tasks here
that require a kernel-update, and obviously it is not a problem that might just 
disappear by itself with the next kernel-release...

Ciao,
Nobbi

PS: Please CC me, I'm not subscribed.

-- 
-- _____________________________________Norbert "Nobbi" Nemec
-- Hindenburgstr. 44   ...   D-91054 Erlangen   ...   Germany
-- eMail: <Norbert@Nemec-online.de>  Tel: +49-(0)-9131-204180
