Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSE2TBv>; Wed, 29 May 2002 15:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315429AbSE2TBu>; Wed, 29 May 2002 15:01:50 -0400
Received: from [213.187.195.158] ([213.187.195.158]:57583 "EHLO
	kokeicha.ingate.se") by vger.kernel.org with ESMTP
	id <S315427AbSE2TBs>; Wed, 29 May 2002 15:01:48 -0400
To: linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Loosing packets with Dlink DFE-580TX and SMC 9462TX
From: Marcus Sundberg <marcus@ingate.com>
Date: 29 May 2002 21:01:47 +0200
Message-ID: <ved6vepylg.fsf@inigo.ingate.se>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing severe packet-loss with two different types of network
cards:
D-link DFE-580TX (DL10050B aka OEM:ed Sundance ST201 chip) and
SMC 9462TX (NS83820 chip)

The machine is an Athlon XP1800+ with VIA KT266 chipset and what
I'm doing is to send several bi-directional streams of small UDP
packets through the machine. Each stream consists of 50 UDP
packets per second in each direction, with 200 bytes payload.

Using either Intel 21143 based cards (tulip driver) or Intel 82559
(eepro100 driver) I can send 100 such streams through the machine
with no packet loss (the load generators starts walking on their
knees a bit over 100). This equals 10000 packets/second or about
19 Mbit/s.

However using either the Dlink cards or the SMC cards I start getting
severe packet loss at between 50 and 70 streams. After fixing the
sundance driver so it doesn't turn off interrupts for 3.2ms whenever
the boguscnt counter in the interrupt handler happens to reach zero
I can't find anything particularly bad neither in the driver nor
in the ST201 chip spec, but packets keep getting dropped.
(The 83820-driver I haven't looked at at all)

Before digging further into this I'd like to know if anyone have
had similiar problems, or are using any of these cards/drivers
without problems, or have an idea if it is the chips or the drivers
which are broken? Or can just tell me whether these cards are
exceptionally bad or if eepro100/tulip are exceptionally good?

I migh also take the opportunity to ask if anyone can recommend
another 4-port (or more) 100Mbit ethernet card than the DFE-580TX?

//Marcus
-- 
---------------------------------------+--------------------------
  Marcus Sundberg <marcus@ingate.com>  | Firewalls with SIP & NAT
 Firewall Developer, Ingate Systems AB |  http://www.ingate.com/
