Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315430AbSHXJJ5>; Sat, 24 Aug 2002 05:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315437AbSHXJJ5>; Sat, 24 Aug 2002 05:09:57 -0400
Received: from elixir.e.kth.se ([130.237.48.5]:64519 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S315430AbSHXJJ4>;
	Sat, 24 Aug 2002 05:09:56 -0400
To: barrie_spence@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 - Promise TX2 Ultra133 (pdc20269) sticks at UDMA33
References: <C12D24916888D311BC790090275414BB0B724742@oberon.britain.agilent.com>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 24 Aug 2002 11:14:05 +0200
In-Reply-To: barrie_spence@agilent.com's message of "Fri, 23 Aug 2002 15:20:11 +0200"
Message-ID: <yw1xvg60liua.fsf@storstrut.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

barrie_spence@agilent.com writes:

> I'm running 2.4.19 with a Promise TX2 Ultra133, but even though the
> card BIOS reports UDMA mode 5/6 on the drives, they are reported as
> UDMA33 by the kernel.
> 
> Trying hdparm -X69 after boot gives the message "Speed warnings UDMA
> 3/4/5 is not functional."

I was waiting for this.  As I have pointed out several times before,
there needs to be added a line

    hwif->udma_four = 1;

at the appropriate place in pdc202xx.c.  I don't know where it should
be, so I can't write a patch.

-- 
Måns Rullgård
mru@users.sf.net
