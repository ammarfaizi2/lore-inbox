Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129594AbRBXUvP>; Sat, 24 Feb 2001 15:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129596AbRBXUvE>; Sat, 24 Feb 2001 15:51:04 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30468 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129594AbRBXUu5>; Sat, 24 Feb 2001 15:50:57 -0500
Subject: Re: reiserfs: still problems with tail conversion
To: ken@kenmoffat.uklinux.net (Ken Moffat)
Date: Sat, 24 Feb 2001 20:53:15 +0000 (GMT)
Cc: J.A.K.Mouw@ITS.TUDelft.NL (Erik Mouw), mason@suse.com (Chris Mason),
        linux-kernel@vger.kernel.org (Linux kernel mailing list)
In-Reply-To: <Pine.LNX.4.21.0102241917020.1720-100000@localhost.localdomain> from "Ken Moffat" at Feb 24, 2001 07:27:02 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Wlgs-0000Sp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 32Mb. The test results vary depending on what else is on the partition,
> but in each case the last file affected is 01017 and there are sequences
> of previous_number+4, for up to 8 files (but next file after this might be
> previous+7 or previous +15, or sporadic). From other problems I've seen on
> the list, maybe I need more memory to run reiserfs ?

No. Reiserfs cannot go around corrupting files regardless of the amount of
memory you have. What is however quite possible is that there is a race
condition on reiserfs (or in the VFS) that is triggered when you are paging
and programs are thus sleeping on buffer and memory allocations

