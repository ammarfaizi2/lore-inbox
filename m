Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUHTMWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUHTMWF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 08:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbUHTMWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 08:22:05 -0400
Received: from the-village.bc.nu ([81.2.110.252]:31111 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268111AbUHTMVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 08:21:15 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Lord <lkml@rtr.ca>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       kernel@wildsau.enemy.org, diablod3@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4124FD46.8040109@rtr.ca>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
	 <4124BA10.6060602@bio.ifi.lmu.de>
	 <1092925942.28353.5.camel@localhost.localdomain>
	 <200408191800.56581.bzolnier@elka.pw.edu.pl>
	 <1092938773.28350.27.camel@localhost.localdomain> <4124FD46.8040109@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093000695.30968.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 20 Aug 2004 12:18:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-19 at 20:19, Mark Lord wrote:
>  >And what do you do the day someone posts "lock IDE drive with random
>  >password as any user" to bugtraq ?
> 
> I should hope that these lines in the driver would prevent such:
> 
>        if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
>              return -EACCES;

These lines aren't in the prior to 2.6.8.1 SG_IO path...

