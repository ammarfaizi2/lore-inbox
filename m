Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263806AbRF0QQd>; Wed, 27 Jun 2001 12:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263766AbRF0QQX>; Wed, 27 Jun 2001 12:16:23 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5636 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263435AbRF0QQG>; Wed, 27 Jun 2001 12:16:06 -0400
Subject: EEPro100 bug in 2.4.6pre5
To: linux-kernel@vger.kernel.org
Date: Wed, 27 Jun 2001 17:15:57 +0100 (BST)
Cc: torvalds@transmeta.com
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FHyv-0005Q0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking over the merges Im doing from 2.4.6pre I found a couple of suprises
the most dubious of which is the rather bogus hackery on eepro100.c

Someone has done S/CONFIG_EEPRO100_PM/CONFIG_PM/ on the driver and in doing
so permanently enabled the eepro100 pm code which to say the least doesnt work
for a lot of people but gives them weird eepro100 hangs

Since the drivers/net/Config option wasnt removed I can only conclude this was
someones internal hack that leaked out in error

Linus - I think you need to revert that eepro100 change.

Alan

