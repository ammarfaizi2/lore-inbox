Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280933AbRKLTNO>; Mon, 12 Nov 2001 14:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280947AbRKLTNE>; Mon, 12 Nov 2001 14:13:04 -0500
Received: from [195.63.194.11] ([195.63.194.11]:39689 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S280945AbRKLTMy>; Mon, 12 Nov 2001 14:12:54 -0500
Message-ID: <3BF02B94.5E10B132@evision-ventures.com>
Date: Mon, 12 Nov 2001 21:05:40 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Corsspatch patch-2.4.15-pre2 patch-2.4.15-pre3
In-Reply-To: <Pine.LNX.4.33.0111120838110.15242-100000@penguin.transmeta.com> <3BF01A14.26A5F78@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello out there!

Doing a X-patch between, ehmm, the pre-patches 2 and 3, I noticed
that a call to sa1100_irda_init() will be added in
patch-2.4.15-pre3 TWICE. This *may* work, but I think this isn't
quite in the intention of the inventor :-). So Linus/Alan please 
watch out...

It's in the file linux/net/irda/irda_device.c:
The following will be twice there after pre3
#ifdef CONFIG_SA1100_FIR
	sa1100_irda_init()
#endif
