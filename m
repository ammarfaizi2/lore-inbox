Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270272AbTHQPDZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 11:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270283AbTHQPDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 11:03:25 -0400
Received: from mta11.adelphia.net ([64.8.50.205]:3308 "EHLO mta11.adelphia.net")
	by vger.kernel.org with ESMTP id S270272AbTHQPDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 11:03:24 -0400
Message-ID: <006f01c364d0$b40641f0$6401a8c0@wa1hco>
From: "jeff millar" <wa1hco@adelphia.net>
To: "Francois Romieu" <romieu@fr.zoreil.com>,
       "Olaf Zaplinski" <olaf@zaplinski.de>
Cc: <linux-kernel@vger.kernel.org>
References: <3F3F6E38.9070002@zaplinski.de> <20030817141651.A20799@electric-eye.fr.zoreil.com>
Subject: Re: PROBLEM: 2.6.0-test3 does not mount root fs
Date: Sun, 17 Aug 2003 11:03:22 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may not be the problem.  I just got 2.6.0-test3 booting 
after similar error messages by changing my .config file. 
using root=0303 didn't make it boot.
 
Not sure which changes made it boot.  
Most likely, it's compiling ext3 into kernel (not a module).
2.4.20 kernels fell back to ext2 when mounting an ext3 partition.

BUT, I made that change once and it didn't work....
or maybe I forgot to install it.  I'm still working thought the
combinations.

jeff

----- Original Message ----- 
From: "Francois Romieu" <romieu@fr.zoreil.com>
Subject: Re: PROBLEM: 2.6.0-test3 does not mount root fs


> Olaf Zaplinski <olaf@zaplinski.de> :
> [lilo.conf]
> > image=/boot/vmlinuz-2.6.0-test3
> >          root=/dev/hda3
> >          label=2.6.0-test3
> >          append="reboot=warm"
> 
> Try append="reboot=warm root=303"
> 
> >          read-only
> > 
> > image=/boot/vmlinuz-2.4.20
> >          root=/dev/hda3

