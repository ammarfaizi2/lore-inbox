Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318389AbSIKGqQ>; Wed, 11 Sep 2002 02:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318392AbSIKGqQ>; Wed, 11 Sep 2002 02:46:16 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:10259 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S318389AbSIKGqP>;
	Wed, 11 Sep 2002 02:46:15 -0400
Date: Wed, 11 Sep 2002 08:50:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] undo 2.5.34 ftape damage
Message-ID: <20020911085017.B1352@mars.ravnborg.org>
Mail-Followup-To: Thunder from the hill <thunder@lightweight.ods.org>,
	Mikael Pettersson <mikpe@csd.uu.se>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <15742.2206.709234.102259@kim.it.uu.se> <Pine.LNX.4.44.0209101430090.10048-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209101430090.10048-100000@hawkeye.luckynet.adm>; from thunder@lightweight.ods.org on Tue, Sep 10, 2002 at 02:31:17PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 02:31:17PM -0600, Thunder from the hill wrote:
> This is the expsyms output. Draw your own conclusions on what should be 
> done.
> 
[Russell king already commented the ARM stuff long time ago]
> Remove arch/ppc/amiga/amiga_ksyms.o.
False negative.
amiga_ksyms.c includes m68k/amiga/amiga_ksyms.c.

> Remove drivers/char/ftape/zftape/zftape_syms.o. <-- Bugger?
False negative. Fooled by the FT_KSYM macro.
- I will do a patch to get rid of FT_KSYM shortly.

> Remove drivers/char/pty.o.
Correct.
- Patch will follow.

> Add drivers/usb/class/usb-midi.o.
Correct.

	Sam
