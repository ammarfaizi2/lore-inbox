Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317469AbSGOM5m>; Mon, 15 Jul 2002 08:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317470AbSGOM5l>; Mon, 15 Jul 2002 08:57:41 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:31442 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S317469AbSGOM5l>; Mon, 15 Jul 2002 08:57:41 -0400
Date: Mon, 15 Jul 2002 14:58:48 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207151258.g6FCwmU7020648@burner.fokus.gmd.de>
To: root@chaos.analogic.com, schilling@fokus.gmd.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: "Richard B. Johnson" <root@chaos.analogic.com>
>> >From root@chaos.analogic.com Fri Jul 12 22:18:47 2002
>> 
>> >As much as I hate IDE, IDE isn't going away. All my systems use SCSI
>> >so on machines that have CD/ROMS, I use your libraries and your tools.
>> 
>> >Maybe somebody should make CD/ROM code that directly talks to IDE via
>> >/dev/hdwhatever, instead of expecting you to modify your code that
>> >has worked so well for so long.
>> 
>> This would be a really bad idea.
>> 
>> Such a change would force me to add a 6th (and unneeded) new interface.
>> Why? What problem would be solved if you did introduce such an interface?
>> 

>Well for one thing it eliminates the requirement to
>include SCSI interface code on machines that don't
>have SCSI. That's the practical aspect.

>Now, the esoteric. Do you truly think that it is
>proper to encapsulate devices in various layers?

>The IDE interface, if it wasn't for the bug-workarounds,
>is just a floppy disk interface that uses a different
>controller chip. It is register-based, not message-
>based. If you throw in a message-based control layer
>(SCSI), what problems are you solving? It's a
>rhetorical question. No answer is required.

If you like to use the floppy only via the ATA registers, then
you don't like to be able to format media?

BTW: the overhead to set up DMA is higher than the overhead to set up a SCSI 
CDB.

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
