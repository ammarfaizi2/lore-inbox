Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263074AbUB0RYR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 12:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUB0RYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 12:24:17 -0500
Received: from cathy.bmts.com ([216.183.128.202]:63887 "EHLO cathy.bmts.com")
	by vger.kernel.org with ESMTP id S263074AbUB0RTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 12:19:42 -0500
Date: Fri, 27 Feb 2004 12:19:38 -0500
From: Mike Houston <mikeserv@bmts.com>
To: linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org
Subject: Re: Radeon Framebuffer Driver in 2.6.3?
Message-Id: <20040227121938.213a83e2.mikeserv@bmts.com>
In-Reply-To: <1077865490.22215.217.camel@gaston>
References: <1077863238.2522.6.camel@damai.telkomsel.co.id>
	<1077865490.22215.217.camel@gaston>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004 18:04:51 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> If it happens only after switching back from XFree, then it's a known
> problem. I have implemented a fix locally but got sidetracked before I
> could test it properly. 
> 
> Can you test the patch below ? :
> 
> ===== drivers/char/vt.c 1.61 vs edited =====
> --- 1.61/drivers/char/vt.c	Thu Feb 19 14:43:03 2004
> +++ edited/drivers/char/vt.c	Fri Feb 27 17:27:09 2004
> @@ -2743,12 +2743,12 @@

That patch fixes the problem for me also, Benjamin. Thank you! 

Now I have my proper framebuffer console fully usable again (I had switched to VESA fb console in the interrim and that was OK, but it was causing a conflict with the linear framebuffer handle, unable to allocate an mtrr and unable to use write combining on starting X/DRI)

ATI Technologies Inc Radeon RV200 QW [Radeon 7500] on i845 chipset.

Grogan
