Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263987AbTFDTup (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTFDTup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:50:45 -0400
Received: from [212.159.46.210] ([212.159.46.210]:61011 "EHLO lion")
	by vger.kernel.org with ESMTP id S263987AbTFDTuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:50:44 -0400
From: "John Appleby" <john@dnsworld.co.uk>
To: "'Perez-Gonzalez, Inaky'" <inaky.perez-gonzalez@intel.com>,
       "John Appleby" <johna@unickz.com>,
       "'lkml'" <linux-kernel@vger.kernel.org>
Subject: RE: Serio keyboard issues 2.5.70
Date: Wed, 4 Jun 2003 21:08:52 +0100
Message-ID: <434747C01D5AC443809D5FC5405011314BEE@bobcat.unickz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <434747C01D5AC443809D5FC54050113109709D@bobcat.unickz.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > void serio_register_device(struct serio_dev *dev)
> > {
> >         struct serio *serio;
> >         list_add_tail(&dev->node, &serio_dev_list);
> > 	  printk("serio: add_tail %08x\n",&dev->node);
> >         list_for_each_entry(serio, &serio_list, node) {
> >                 printk("serio: register_device %08x\n",serio->dev);
> >                 if (!serio->dev && dev->connect) {
> >                         printk("serio: connecting...\n");
> >                         dev->connect(serio, dev);
> >                 }
> >         }
> > }
> 
> Well - I don't know the real reason, but the code is
> adding the device to the 'serio_dev_list', and the
> list iteration is going over the 'serio_list'...

Yeah, I think that's correct though. At least I've traced it for PS2
keyboards and it finds its way into it.

Regards,

John


