Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271301AbTGQBOl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 21:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271302AbTGQBOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 21:14:41 -0400
Received: from dp.samba.org ([66.70.73.150]:19852 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S271301AbTGQBOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 21:14:39 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] fix section type conflict in sound/isa/sscape.c 
In-reply-to: Your message of "Sun, 13 Jul 2003 22:17:51 +0200."
             <20030713201751.GA12104@fs.tum.de> 
Date: Thu, 17 Jul 2003 10:42:11 +1000
Message-Id: <20030717012932.A08912C2C1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030713201751.GA12104@fs.tum.de> you write:
> --- linux-2.5.75-mm1/sound/isa/sscape.c.old	2003-07-13 22:10:52.000000000 +0200
> +++ linux-2.5.75-mm1/sound/isa/sscape.c	2003-07-13 22:11:21.000000000 +0200
> @@ -809,7 +809,7 @@
>   */
>  static unsigned __devinit get_irq_config(int irq)
>  {
> -	static const int valid_irq[] __devinitdata = { 9, 5, 7, 10 };
> +	static const int valid_irq[] = { 9, 5, 7, 10 };
>  	unsigned cfg;

Just remove the static.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
