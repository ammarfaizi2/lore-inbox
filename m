Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVJ0Oje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVJ0Oje (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 10:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVJ0Oje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 10:39:34 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:65530 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750819AbVJ0Ojd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 10:39:33 -0400
Subject: Re: [PATCH] Disable the most annoying printk in the kernel
From: Steven Rostedt <rostedt@goodmis.org>
To: Keenan Pepper <keenanpepper@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, vojtech@suse.cz,
       Andi Kleen <ak@suse.de>
In-Reply-To: <4360DE89.6070802@gmail.com>
References: <200510271026.10913.ak@suse.de>  <4360DE89.6070802@gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 27 Oct 2005 10:39:09 -0400
Message-Id: <1130423949.21118.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-27 at 10:04 -0400, Keenan Pepper wrote:
> Andi Kleen wrote:
> > Remove most useless printk in the world
> 
> No way! I love that prink! =P
> 

And you know, once it is gone, you will start getting reports from
people that their kernel doesn't act like it use to.  Or they'll start
to think that their keyboards suddenly work better ;-)

-- Steve

> > Signed-off-by: Andi Kleen <ak@suse.de>
> > 
> > Index: linux/drivers/input/keyboard/atkbd.c
> > ===================================================================
> > --- linux/drivers/input/keyboard/atkbd.c
> > +++ linux/drivers/input/keyboard/atkbd.c
> > @@ -328,7 +328,6 @@ static irqreturn_t atkbd_interrupt(struc
> >  			atkbd_report_key(&atkbd->dev, regs, KEY_HANJA, 3);
> >  			goto out;
> >  		case ATKBD_RET_ERR:
> > -			printk(KERN_DEBUG "atkbd.c: Keyboard on %s reports too many keys pressed.
> > \n", serio->phys);
> >  			goto out;
> >  	}
> >  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

