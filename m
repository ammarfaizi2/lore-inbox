Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135759AbREDTVF>; Fri, 4 May 2001 15:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136138AbREDTU4>; Fri, 4 May 2001 15:20:56 -0400
Received: from tomts1.bellnexxia.net ([209.226.175.139]:21155 "EHLO
	tomts1-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S135759AbREDTUh>; Fri, 4 May 2001 15:20:37 -0400
From: "Patrick Allaire" <patrick.allaire@isaacnewtontech.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: DPT I2O RAID and Linux I2O
Date: Fri, 4 May 2001 15:19:45 -0400
Message-ID: <HEEIIHGBKLFOBPOOOJHCKEFECHAA.patrick.allaire@isaacnewtontech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <E14v4Et-0004Nr-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok thats nothing to do with I2O itself. Some hardware has the messaging
> layer built into it as the messenger is very simple and stuff
> like the 21554
> are using in I2O controllers.
>
> You might find i2o_pci.c and the i2o_core message passing code interesting
> but probably not that much. The I2O 1.5 specification covers the hardware
> interface briefly and that bit is worth reading. Ignore the rest.

Hi, its me again (c:

First of all, is it supposed to be working with 2.2.19 or should I take a
new 2.4.4-ac kernel for that support ?

Ok, i allready did look at those files (i2o_pci.c i2o_core), but I cant find
were to begin. I was doing i2o_install_controler, and after that i was
trying to do a i2o_pci_enable or i2o_pci_bind,because they are the only
fonction that seem to bind i2o with a pci_dev, but I get unresolved error
with those functions ... if I do a cat /proc/ksyms I dont see them listed
there. After that when I do i2o_delete_control, I receive a segmentation
fault !!! (Those test are done in 2.2.19)

I have built my kernel with i2o support and i2o_pci support !!!

As for the spec, I have the i2o spec 2.0 here. Is it supported ?

When I look at the source from the i2o driver, i find that my module will
have to primary create an handler to respond to the messages, but does the
configuration of the i2o should be done by my module or it is gonna be done
by the functions I cant use right now ? (i2o_pci_enable...)

Thank you very much !!!

