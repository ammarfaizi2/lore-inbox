Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269955AbRHENTH>; Sun, 5 Aug 2001 09:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269956AbRHENS5>; Sun, 5 Aug 2001 09:18:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31755 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269955AbRHENSq>; Sun, 5 Aug 2001 09:18:46 -0400
Subject: Re: 3c509: broken(verified)
To: nicos@pcsystems.de (Nico Schottelius)
Date: Sun, 5 Aug 2001 14:20:19 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <no.id> from "Nico Schottelius" at Aug 05, 2001 01:10:45 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15TNpL-0007rV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The driver for the 3c509 of 2.4.7 is broken:
> It is impossible to set the transmitter type.
> modprobe 3c509 xcvr=X, where X is
> 0,1,2,3,4 doesn't make a difference.

Looking at the code it should set the type fine. The only bug I can see is
that it will report the default type set in the eeprom not the type you
asked.

If thats the case (please check) then its trivial to fix
