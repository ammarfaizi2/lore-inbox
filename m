Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274082AbRJDOfi>; Thu, 4 Oct 2001 10:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274064AbRJDOf3>; Thu, 4 Oct 2001 10:35:29 -0400
Received: from [212.172.122.16] ([212.172.122.16]:60682 "EHLO qmail.root.at")
	by vger.kernel.org with ESMTP id <S273996AbRJDOfS>;
	Thu, 4 Oct 2001 10:35:18 -0400
Date: Thu, 4 Oct 2001 16:35:46 +0200 (CEST)
From: Karl Pitrich <pit@root.at>
To: <linux-kernel@vger.kernel.org>
Subject: 100% sync block device on 2.2 ?
Message-ID: <Pine.LNX.4.33.0110041629170.1056-100000@warp.root.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi.

i wrote a block driver for a custom battery-backup'ed sram-isa card
which is io mapped. (kernel is 2.2.16, switch to 2.4.x impossible)

i have a minix fs on it.

everything works fine, except that i need my sram-disk _absolutely_
in sync. i mounted -o sync, but the kernel does'nt seem to sync
immediately.
so after any reboot my data is corrupt, which is a problem.

this is my /proc/sys/vm/bdflush, which i tuned:
1 5000 5 25 1 100 100 1 1

so, it should flush dirty buffers all 100hz, if i am right.

is there any way to bypass/disable buffer cache for my block device?
why does this work in floppy.c?
how does sct's rawdevice stuff do this?
(i checked both .c but cant get the clue)

thanks a lot for help, karl.

