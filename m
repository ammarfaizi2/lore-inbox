Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbTJYQny (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 12:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTJYQny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 12:43:54 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:38159 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262712AbTJYQnx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 12:43:53 -0400
To: Vid Strpic <vms@bofhlet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: *FAT problem in 2.6.0-test8
References: <20031024103225.GC1046@home.bofhlet.net>
	<20031024185953.GA9265@win.tue.nl>
	<87ismdoc2s.fsf@devron.myhome.or.jp>
	<20031025105559.GD1143@home.bofhlet.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 26 Oct 2003 01:43:43 +0900
In-Reply-To: <20031025105559.GD1143@home.bofhlet.net>
Message-ID: <87wuatmfnk.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vid Strpic <vms@bofhlet.net> writes:

> > It looks like it doesn't conform to Microsoft's or SmartMedia's
> > specifications.
> > Yes. It will be important to know how it was formated. 
> 
> Well, I really don't know if it was formatted when I bought it, 2 years
> ago.  What puzzles me, is that 2.4 mounts it normally...

Yes, 2.4 doesn't check it field.

> This is the hex dump of begginning (problematic no-name 64Mb card):
> 
> 0000000: e900 002a 6453 777c 4948 4300 0220 0100  ...*dSw|IHC.. ..
> 0000010: 0200 0100 00f8 0c00 2000 0800 3700 0000  ........ ...7...
> 0000020: c9f3 0100 0000 0000 0000 0000 0000 0000  ................
> 0000030: 0000 0000 0000 4641 5431 3220 2020 0000  ......FAT12   ..
> 0000040: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> 
> And this is the SanDisk 32Mb card which mounts normally under 2.6:
> 
> 0000000: e900 0020 2020 2020 2020 2000 0220 0100  ...        .. ..
> 0000010: 0200 01dd f9f8 0600 1000 0800 2300 0000  ............#...
> 0000020: 0000 0000 0000 2900 0000 004e 4f20 4e41  ......)....NO NA
> 0000030: 4d45 2020 2020 4641 5431 3220 2020 0000  ME    FAT12   ..
> 0000040: 0000 0000 0000 0000 0000 0000 0000 0000  ................

On these FAT formats, the target field should be offset 512. 

> Maybe I should try to reformat the card in the reader?  My camera has
> 'delete all images' but no 'format card' I'm sorry...

Um.. Could you please test to reformat? Of course, do it after backup
the your disk image.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
