Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262558AbTCMV3p>; Thu, 13 Mar 2003 16:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262564AbTCMV3o>; Thu, 13 Mar 2003 16:29:44 -0500
Received: from 67.231.118.64.mia-ftl.netrox.net ([64.118.231.67]:405 "EHLO
	smtp.netrox.net") by vger.kernel.org with ESMTP id <S262558AbTCMV3f>;
	Thu, 13 Mar 2003 16:29:35 -0500
Subject: Re: [PATCH] add prink KERN_* suffixes
From: Robert Love <rml@tech9.net>
To: Daniele Venzano <webvenza@libero.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030313164157.GB6435@renditai.milesteg.arr>
References: <20030313164157.GB6435@renditai.milesteg.arr>
Content-Type: text/plain
Organization: 
Message-Id: <1047591779.1226.16.camel@icbm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 13 Mar 2003 16:43:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 11:41, Daniele Venzano wrote:
>         /* Read in the station address. */
>         for (i = 0; i < 6; i++)
> -               printk(" %2.2x", dev->dev_addr[i]);
> -       printk(", IRQ %d.\n", dev->irq);
> +               printk(KERN_INFO " %2.2x", dev->dev_addr[i]);
> +       printk(KERN_INFO ", IRQ %d.\n", dev->irq);


The loglevels only work after a newline.

What you can do is printk() the loglevel before the for loop.  Or just
leave this one alone.

	Robert Love

