Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264271AbRFLIji>; Tue, 12 Jun 2001 04:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264260AbRFLIj3>; Tue, 12 Jun 2001 04:39:29 -0400
Received: from eins.siemens.at ([193.81.246.11]:56838 "EHLO eins.siemens.at")
	by vger.kernel.org with ESMTP id <S264264AbRFLIjT> convert rfc822-to-8bit;
	Tue, 12 Jun 2001 04:39:19 -0400
Message-ID: <D9F2B9CD7BD5D21196BC0800060D9ED604ED6344@vies186a.sie.siemens.at>
From: Boenisch Joerg <joerg.boenisch@siemens.at>
To: "Linux-Kernel (E-Mail)" <linux-kernel@vger.kernel.org>
Subject: AVM A1 pcmcia, kernel 2.4.5-ac11 problem
Date: Tue, 12 Jun 2001 10:37:58 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear experts,

I hope not to be off topic! (In that case could you tell me where to ask?)
I can´t get my avm a1 pcmcia card running.

My system:
kernel 2.4.5-ac11
pcmcia-cs-3.1.26

Kernel of course is compiled with ISDN support and low-level AVM-A1-PCMCIA.
After installation in /lib/modules hisax.o can be found, but not avma1_cs.o
.

My /etc/pcmcia/config looks like:
---begin---cut---
device "avma1_cs"
	class "isdn" module "net/slhc", "misc/isdn", "misc/hisax" opts
"type=26 protocol=2", "avma1_cs"
---cut---
card "AVM ISDN-Controller A1"
	version "AVM", "ISDN A"
	bind "avma1_cs"
---cut---end---

syslog:

cardmgr[1070]: executing: ´modprobe hisax type=26 protocol=2´
kenel: HiSax: Linux Driver for passive ISDN cards
kenel: HiSax: Version 3.5 (module)
kenel: HiSax: Layer1 Revision 2.41.6.3
kenel: HiSax: Layer2 Revision 2.25.6.2
kenel: HiSax: TeiMgr Revision 2.17.6.2
kenel: HiSax: Layer3 Revision 2.17.6.3
kenel: HiSax: LinkLayer Revision 2.51.6.3
kenel: HiSax: Approval certification valid
kenel: HiSax: Approved with ELSA Microlink PCI cards
kenel: HiSax: Approved with Eicon Technology Diva 2.01 PCI cards
kenel: HiSax: approved with Sedlbauer Speedfax + cards
cardmgr[1070]: executing: ´modprobe avma1_cs´
cardmgr[1070]: + modprobe: Can´t locate module avma1_cs
cardmgr[1070]: modprobe exited with status 255
cardmgr[1070]: module /lib/modules/2.4.5-ac11/pcmcia/avma1_cs.o not
available
cardmgr[1070]: get dev info on socket 1 failed: Resource temporarily
unavailable

------

Maybe someone can tell me, what´s wrong or what i have forgotten to do.

TIA!
Joerg Boenisch
