Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWI3P0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWI3P0p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 11:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWI3P0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 11:26:45 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:26835 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751095AbWI3P0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 11:26:44 -0400
Subject: Re: 2.6.18-mm2
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Wilcox <matthew@wil.cx>,
       "J.A. Magall??n" <jamagallon@ono.com>, Andrew Morton <akpm@osdl.org>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
In-Reply-To: <20060929235054.GB2020@slug>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	 <20060929155738.7076f0c8@werewolf> <20060929143949.GL5017@parisc-linux.org>
	 <1159550143.13029.36.camel@localhost.localdomain>
	 <20060929235054.GB2020@slug>
Content-Type: text/plain
Date: Sat, 30 Sep 2006 10:26:22 -0500
Message-Id: <1159629982.14918.4.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-29 at 23:50 +0000, Frederik Deweerdt wrote:
> +       if (!pdev->irq)
> +               return -ENODEV;
> +

Don't I remember that 0 is a valid IRQ on some platforms?

i.e. shouldn't this be

if (pdev->irq == NO_IRQ)
	return -ENODEV;

?

I think this won't quite work because only the platforms that actually
have a valid zero irq define it, but there must be something else that
works.

James


