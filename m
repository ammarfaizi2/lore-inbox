Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbVHOTkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbVHOTkp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 15:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbVHOTkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 15:40:45 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:13466 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S964911AbVHOTkp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 15:40:45 -0400
Date: Mon, 15 Aug 2005 21:40:26 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Jim Ramsay <jim.ramsay@gmail.com>
cc: James Simmons <jsimmons@infradead.org>, yhlu <yhlu.kernel@gmail.com>,
       <alex.kern@gmx.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Atyfb questions and issues
In-Reply-To: <4789af9e0508151221486d0003@mail.gmail.com>
Message-ID: <Pine.LNX.4.44.0508152129490.11750-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Op Mon, 15 Aug 2005, schreef Jim Ramsay:

> Of course.
>
> How about the replacement for 'xlinit.c' I have attached here?
>
> I noticed that the big difference between what the 2.4 kernel and 2.6
> kernel did is that the 'var_to_pll' (and its component functions) in
> 2.4 did a lot more probing than that in the 2.6 kernel.
>
> So I copied the relevant 2.4 bits for non-i386 archs, and replaced the
> call to 'var_to_pll' with the "new" stuff.
>
> This seems to work for me.  Enjoy!

I don't know what the purpose of this patch is but it copies the pre-LCD
version of the code in mach64_ct.c into the xlinit.c code of 2.6. This is
not the var_to_pll code. This code affects the display fifo and can
cause wrong image if incorrectly programmed, but has nothing to do with
initializing the chip.

The pre-LCD code caused several problems for both i386 and
non-i386 laptops, and should not be reused. Also, Geert Uytterhoeven
has said that he developed the pre-LCD by trial and and not by
design. The post-LCD code is derived from the XFree86 driver, it is
supposed to work fine if X works.

Daniël Mantione

