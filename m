Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267310AbUHSTW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267310AbUHSTW2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267303AbUHSTVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:21:00 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:29629 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S267298AbUHSTUy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:20:54 -0400
Message-ID: <4124FD46.8040109@rtr.ca>
Date: Thu, 19 Aug 2004 15:19:34 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       kernel@wildsau.enemy.org, diablod3@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408041233.i74CX93f009939@wildsau.enemy.org>	 <4124BA10.6060602@bio.ifi.lmu.de>	 <1092925942.28353.5.camel@localhost.localdomain>	 <200408191800.56581.bzolnier@elka.pw.edu.pl> <1092938773.28350.27.camel@localhost.localdomain>
In-Reply-To: <1092938773.28350.27.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >And what do you do the day someone posts "lock IDE drive with random
 >password as any user" to bugtraq ?

I should hope that these lines in the driver would prevent such:

       if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
             return -EACCES;

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
