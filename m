Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263686AbTDXN7n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 09:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263696AbTDXN7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 09:59:43 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:9208 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S263686AbTDXN7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 09:59:42 -0400
Date: Thu, 24 Apr 2003 16:11:31 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Richard Zidlicky <rz@linux-m68k.org>
cc: John Bradford <john@grabjohn.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k IDE updates
In-Reply-To: <20030424131446.GB3073@linux-m68k.org>
Message-ID: <Pine.GSO.4.21.0304241610440.12020-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Apr 2003, Richard Zidlicky wrote:
> On Thu, Apr 24, 2003 at 01:26:12PM +0200, Geert Uytterhoeven wrote:
> > Since both Atari and Q40/Q60 use PIO only, this affects ata_{in,out}put_data()
> > only. It's quite easy to add a swap flag to ide_drive_t (configurable through
> > hdX=swapdata), that is checked in ata_{in,out}put_data().  To improve
> > performance, we wouldn't swap twice, but just call the new routines
> > hwif->{IN,OUT}S[WL]_NOSWAP.
> 
> contradicts previous paragraph? Still wrong smartdata etc unless
> you mean to set the flag per request depending on the type of command
> - which would be quite easy afaics. 

Oops, you're right.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

