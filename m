Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbTJZN5v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 08:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbTJZN5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 08:57:51 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:65040 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S263148AbTJZN5u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 08:57:50 -0500
To: Andries.Brouwer@cwi.nl
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test9
References: <UTC200310261108.h9QB88m25135.aeb@smtp.cwi.nl>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 26 Oct 2003 22:57:32 +0900
In-Reply-To: <UTC200310261108.h9QB88m25135.aeb@smtp.cwi.nl>
Message-ID: <87brs4drub.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl writes:

> > Pls forward.
> 
> The first FAT entry should have the media byte (0xf0,0xf8,...,0xff)
> extended with all 1 bits in the first FAT entry.
> Checking this is a good idea, it prevents us from mounting garbage
> as FAT - there is no good magic for FAT.
> Unfortunately, Windows does not enforce this, and 2.4 doesn't either.
> It turns out that there are filesystems around (two reports so far)
> that have a zero first FAT entry, and work under Windows and 2.4 but
> fail to mount under 2.6.
> 
> So, the below weakens the test.

Looks good to me. I have no objection.


However, the following may be a bit useful info.

I tested on win2k and win95 installed at now.

win95's scandisk reported and fixed this problem.
win2k's chkdsk detect problem and fixed. But GUI tool doesn't detect,
and can't fixed.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
