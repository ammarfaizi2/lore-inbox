Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313824AbSDPS5g>; Tue, 16 Apr 2002 14:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313825AbSDPS5f>; Tue, 16 Apr 2002 14:57:35 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1800 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313824AbSDPS5e>; Tue, 16 Apr 2002 14:57:34 -0400
Subject: Re: [PATCH] fix ips driver compile problems
To: davidsen@tmr.com (Bill Davidsen)
Date: Tue, 16 Apr 2002 20:12:10 +0100 (BST)
Cc: haveblue@us.ibm.com (Dave Hansen), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.3.96.1020416143110.27884A-100000@gatekeeper.tmr.com> from "Bill Davidsen" at Apr 16, 2002 02:47:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xYN8-0000dv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Let's clarify. Is there a policy to get rid of drivers which don't
> conform, and if so are all the other drivers claimed to be compliant and
> this the only one which isn't? And if so, why hasn't someone just

They need fixing not removing. But right at the moment trying to fix drivers
is a fairly painful business since th block and scsi layers are still 
somewhat in flux. Also for some drivers bringing them up to the 2.5 
world is non trivial (eg I2O) and takes time anyway.

> Otherwise:
> - this makes the driver compile - good
> - this patch makes the driver WORK - also good

Bad.. - because now when you come to check you have them all fixed you'll
miss it out, and bad stuff might occur. You want it to choke unless the
user said "please dont choke on..." just so you can find them.

DaveJ's patch is much nicer

Alan

