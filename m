Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135678AbREFNV6>; Sun, 6 May 2001 09:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135682AbREFNVr>; Sun, 6 May 2001 09:21:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44805 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135678AbREFNVi>; Sun, 6 May 2001 09:21:38 -0400
Subject: Re: O2Micro PCMCIA card support
To: klaus@totalnet.ro (Claudiu Constantinescu)
Date: Sun, 6 May 2001 14:25:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0105061304120.8055-100000@puzzlewell.totalnet.ro> from "Claudiu Constantinescu" at May 06, 2001 01:05:09 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14wOXS-00027T-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it seems that it probes only the ISA bus?), but the yenta module (mistakenly?)
> detects it as an yenta socket, but tries to load two memory_cs modules instead
> of the appropriate card drivers. The output of lspci shows:

Correctly I think. Its a full cardbus

> 00:03.0 CardBus bridge: O2 Micro, Inc. 6836 (rev 62)
> 00:03.1 CardBus bridge: O2 Micro, Inc. 6836 (rev 62)
> 
> 	Am I missing something or is the support for this card broken?

The yenta stuff should be solid by now. Loading memory drivers tends to 
indicate a timing problem is still there.

> 	One more thing: Is there any planned support for AX88190 cards? The
> vendor distributed modified version of 8390 driver is available only
> for pcmcia-cs, but sometimes freezes the whole system.

The AX88190 is a very broken 8390 clone. It requires ugly hacks you dont want
in a generic 8390 driver.
