Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUBQOIa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 09:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266206AbUBQOIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 09:08:30 -0500
Received: from ultra12.almamedia.fi ([193.209.83.38]:41386 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S266181AbUBQOI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 09:08:29 -0500
Message-ID: <40322094.83061A32@users.sourceforge.net>
Date: Tue, 17 Feb 2004 16:09:24 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oopsing cryptoapi (or loop device?) on 2.6.*
References: <402A4B52.1080800@centrum.cz> <402A7765.FD5A7F9E@users.sourceforge.net>
		 <m265e9oyrs.fsf@tnuctip.rychter.com>
		 <402F877C.C9B693C1@users.sourceforge.net> <m2k72n9pth.fsf@tnuctip.rychter.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Rychter wrote:
> >>>>> "Jari" == Jari Ruusu <jariruusu@users.sourceforge.net>:
>  Jari> File backed loops have hard to fix re-entry problem: GFP_NOFS
>  Jari> memory allocations that cause dirty pages to written out to file
>  Jari> backed loop, will have to re-enter the file system anyway to
>  Jari> complete the write. This causes deadlocks. Same deadlocks are
>  Jari> there in mainline loop+cryptoloop combo.
> 
> I have used cryptoapi (as modules) for the last 2 years (or so) now,
> without encountering any problems whatsoever. I therefore beg to differ:
> if the same deadlocks are there, then for some reason they are not
> triggered on my machine. Two years versus an hour, that's a rather
> significant difference in terms of reliability.

Do you mind doing a a quick grep:

    cd /path/to/your/kernel/source
    grep "Jari Ruusu" drivers/block/loop.c

If you see my name there, your kerneli.org cryptoapi enabled kernel is
running same loop code I wrote years ago. Those loop-jari-something patches
that you find on the net, are just copies of old loop-AES code.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
