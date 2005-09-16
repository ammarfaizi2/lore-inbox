Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030589AbVIPESp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030589AbVIPESp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 00:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030590AbVIPESp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 00:18:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56982 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030589AbVIPESp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 00:18:45 -0400
Date: Thu, 15 Sep 2005 21:18:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de, kay.sievers@vrfy.org,
       vojtech@suse.cz, hare@suse.de
Subject: Re: [patch 16/28] drivers/usb/input: convert to dynamic input_dev
 allocation
Message-Id: <20050915211805.11dc1726.akpm@osdl.org>
In-Reply-To: <200509152259.35027.dtor_core@ameritech.net>
References: <20050915070131.813650000.dtor_core@ameritech.net>
	<20050915070304.070090000.dtor_core@ameritech.net>
	<20050915205341.53c22b0e.akpm@osdl.org>
	<200509152259.35027.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> On Thursday 15 September 2005 22:53, Andrew Morton wrote:
> > Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > >
> > >  Input: convert drivers/iusb/input to dynamic input_dev allocation
> > 
> > The absfuzz initialisation in kbtab_probe() got lost.
> > 
> 
> Looks fine here:
> 
> +       input_set_abs_params(input_dev, ABS_X, 0, 0x2000, 4, 0);
> +       input_set_abs_params(input_dev, ABS_X, 0, 0x1750, 4, 0);
>                                                          ^^^

Oh.  You mean they replace these?

-	kbtab->dev.absfuzz[ABS_X] = 4;
-	kbtab->dev.absfuzz[ABS_Y] = 4;

Not a step forward in readability?

> 
> Is there something in your tree that not in Linus's yet? 
> 

Yeah, some stuff, that's why I noticed.
