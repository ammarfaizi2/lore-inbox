Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265375AbUAFVok (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 16:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbUAFVok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 16:44:40 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:50823 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265375AbUAFVoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 16:44:38 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH] VT locking
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, James Simmons <jsimmons@infradead.org>
In-Reply-To: <Pine.GSO.4.58.0401061725250.5752@waterleaf.sonytel.be>
References: <1073349182.9504.175.camel@gaston>
	 <Pine.GSO.4.58.0401061725250.5752@waterleaf.sonytel.be>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1073425440.773.10.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 07 Jan 2004 08:44:00 +1100
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Looks like a nice opportunity to introduce an arch-specific printk() stub:
> 
>     void *arch_printk(const char *args);
> 
>     if (arch_printk)
> 	arch_printk(printk_buf);

Right... I admit I didn't even notice the printk_btext stuff leaked with
this patch, this is debug stuff that wasn't really supposed to get out
of my tree, oh well... I shouldn't do patches when I'm sick with +40°
fever...

Andrew, the only bits of the kernel/printk.c that are supposed to get
to your tree are related to is_console_locked() at this point. The
force_printk_to_btext is a debug tool that allow to route all printk's
to some early-boot output mecanism, though it would eventually be
acceptable upstream with Geert's idea of arch_printk...

Cheers,
Ben.


