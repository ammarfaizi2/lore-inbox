Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130457AbRCCNjs>; Sat, 3 Mar 2001 08:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130458AbRCCNjj>; Sat, 3 Mar 2001 08:39:39 -0500
Received: from pf107.gdansk.sdi.tpnet.pl ([213.77.129.107]:16137 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S130457AbRCCNja>; Sat, 3 Mar 2001 08:39:30 -0500
Subject: Re: [patch] 2.4.2 Advantech WDT driver
In-Reply-To: <3A9D376A.18F4E6F0@mandrakesoft.com> from Jeff Garzik at "Feb 28,
 2001 12:37:46 pm"
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Date: Sat, 3 Mar 2001 14:38:18 +0100 (CET)
CC: Marek Michalkiewicz <marekm@amelek.gda.pl>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E14ZCEl-0001xd-00@mm.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why is lock_kernel necessary?

Well, it is there in 2.4.2 acquirewdt.c (which this driver is based on -
really only minimal changes, the hardware is only slightly different).
I can remove it if you tell me it's really not necessary.

> > +       spin_lock_init(&advwdt_lock);
> > +       misc_register(&advwdt_miscdev);
> 
> check return code for error

Again, acquirewdt.c doesn't do it with the misc_register, request_region
and register_reboot_notifier calls.  (Should it?  Cc: Alan Cox)

Thanks,
Marek
