Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266825AbUIMOWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbUIMOWW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266898AbUIMOWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:22:22 -0400
Received: from witte.sonytel.be ([80.88.33.193]:10940 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266825AbUIMOWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:22:16 -0400
Date: Mon, 13 Sep 2004 16:22:10 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Add sparse "__iomem" infrastructure to check PCI address usage
In-Reply-To: <Pine.LNX.4.58.0409121945500.13491@ppc970.osdl.org>
Message-ID: <Pine.GSO.4.58.0409131616390.23648@waterleaf.sonytel.be>
References: <200409110726.i8B7QTGn009468@hera.kernel.org> <4144E93E.5030404@pobox.com>
 <Pine.LNX.4.58.0409121922450.13491@ppc970.osdl.org> <414508F6.7020301@pobox.com>
 <Pine.LNX.4.58.0409121945500.13491@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While resuming adding __user annotations to the m68k-specific parts of the
code, I stumbled on

    struct task_struct {
	...
	unsigned long sas_ss_sp;
	...
    }

If I'm not mistaken, sas_ss_sp is always a pointer to user stack space.
Shouldn't it be changed to `void __user *sas_ss_sp', or is an
unsigned long/void * change in generic code a too controversial change for
making sparse happy?

And I guess I can find a few more of these...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
