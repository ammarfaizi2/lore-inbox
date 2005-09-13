Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbVIMR4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbVIMR4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVIMR4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:56:12 -0400
Received: from witte.sonytel.be ([80.88.33.193]:11188 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S964950AbVIMR4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:56:11 -0400
Date: Tue, 13 Sep 2005 19:55:52 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@infradead.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Missing #include <config.h>
In-Reply-To: <20050913135622.GA30675@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.62.0509131955230.24748@numbat.sonytel.be>
References: <20050913135622.GA30675@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584334533-1562120362-1126634152=:24748"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584334533-1562120362-1126634152=:24748
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 13 Sep 2005, [iso-8859-1] Jörn Engel wrote:
> After spending some hours last night and this morning hunting a bug,
> I've found that a different include order made a difference.  Some
> files don't work correctly, unless config.h is included before.
> 
> Here is a very stupid bug checker for the problem class:
> $ rgrep CONFIG include/ | cut -d: -f1 | sort -u > g1
> $ rgrep CONFIG include/ | cut -d: -f1 | sort -u | xargs grep "config.h" | cut -d: -f1 | sort -u > g2
> $ diff -u g1 g2 | grep ^- > g3
> 
> Result is quite a long list for 2.6.13.  include/config/* are false
> positives, ok.  But what should we do about the rest?

> -include/asm-m68k/amigayle.h
> -include/asm-m68k/amipcmcia.h
> -include/asm-m68k/bvme6000hw.h
> -include/asm-m68k/ioctls.h
> -include/asm-m68k/mvme16xhw.h

These are false positives as well.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
---584334533-1562120362-1126634152=:24748--
