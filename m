Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263808AbTFDThk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTFDThk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:37:40 -0400
Received: from fmr01.intel.com ([192.55.52.18]:15849 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263808AbTFDThj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:37:39 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780D6F0F28@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'John Appleby'" <john@dnsworld.co.uk>,
       "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>
Subject: RE: Serio keyboard issues 2.5.70
Date: Wed, 4 Jun 2003 12:51:04 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> void serio_register_device(struct serio_dev *dev)
> {
>         struct serio *serio;
>         list_add_tail(&dev->node, &serio_dev_list);
> 	  printk("serio: add_tail %08x\n",&dev->node);
>         list_for_each_entry(serio, &serio_list, node) {
>                 printk("serio: register_device %08x\n",serio->dev);
>                 if (!serio->dev && dev->connect) {
>                         printk("serio: connecting...\n");
>                         dev->connect(serio, dev);
>                 }
>         }
> }

Well - I don't know the real reason, but the code is
adding the device to the 'serio_dev_list', and the
list iteration is going over the 'serio_list'...


Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
