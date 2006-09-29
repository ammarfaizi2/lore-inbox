Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030420AbWI2Ila@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbWI2Ila (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 04:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWI2Il3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 04:41:29 -0400
Received: from witte.sonytel.be ([80.88.33.193]:16856 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1030412AbWI2Il2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 04:41:28 -0400
Date: Fri, 29 Sep 2006 10:41:26 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: git@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: git sometimes stripping one path component in commit mails
Message-ID: <Pine.LNX.4.62.0609291034020.28814@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

I noticed git sometimes strips one path component from the filenames in the
patches mailed to the git-commits mailing lists. This causes problems when
piping these mails through diffstat.

Here is a part of an actual mail received through
git-commits-head@vger.kernel.org to demonstrate this issue:

Is this a current git bug, or a bug in the version used for those mailing
lists?

| commit 94c12cc7d196bab34aaa98d38521549fa1e5ef76
| tree 8e0cec0ed44445d74a2cb5160303d6b4dfb1bc31
| parent 25d83cbfaa44e1b9170c0941c3ef52ca39f54ccc
| author Martin Schwidefsky <schwidefsky@de.ibm.com> 1159455403 +0200
| committer Martin Schwidefsky <schwidefsky@de.ibm.com> 1159455403 +0200

| diff --git a/include/asm-s390/irqflags.h b/include/asm-s390/irqflags.h
| dissimilarity index 65%
| index 3b566a5..3f26131 100644
| --- include/asm-s390/irqflags.h
| +++ include/asm-s390/irqflags.h
      ^^
      woops

| diff --git a/include/asm-s390/lowcore.h b/include/asm-s390/lowcore.h
| index 18695d1..06583ed 100644
| --- a/include/asm-s390/lowcore.h
| +++ b/include/asm-s390/lowcore.h
      ^^
      OK

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
