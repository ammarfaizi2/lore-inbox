Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129842AbQKISNL>; Thu, 9 Nov 2000 13:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129886AbQKISNB>; Thu, 9 Nov 2000 13:13:01 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:20237 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129842AbQKISMr>;
	Thu, 9 Nov 2000 13:12:47 -0500
Message-ID: <3A0AE91D.AC074BAE@mandrakesoft.com>
Date: Thu, 09 Nov 2000 13:12:45 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven_Snyder@3com.com, linux-kernel@vger.kernel.org
Subject: Re: Porting Linux v2.2.x Ethernet driver to v2.4.x?
In-Reply-To: <88256992.00632296.00@hqoutbound.ops.3com.com> <3A0AE88D.FCA19A5A@mandrakesoft.com>
Content-Type: multipart/mixed;
 boundary="------------C268B649A7842FB7450882D7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C268B649A7842FB7450882D7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

...and the attached document, referred to in the previous mail.  :)   I
think I posted this recently, but it's small so a repost is no big deal.
-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
--------------C268B649A7842FB7450882D7
Content-Type: text/plain; charset=us-ascii;
 name="netdevices.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netdevices.txt"


Network Devices, the Kernel, and You!


Introduction
============
The following is a random collection of documentation regarding
network devices.




struct net_device synchronization rules
=======================================
dev->open:
	Locking: Inside rtnl_lock() semaphore.
	Sleeping: OK

dev->stop:
	Locking: Inside rtnl_lock() semaphore.
	Sleeping: OK

dev->do_ioctl:
	Locking: Inside rtnl_lock() semaphore.
	Sleeping: OK

dev->get_stats:
	Locking: Inside dev_base_lock spinlock.
	Sleeping: NO

dev->hard_start_xmit:
	Locking: Inside dev->xmit_lock spinlock.
	Sleeping: NO

dev->tx_timeout:
	Locking: Inside dev->xmit_lock spinlock.
	Sleeping: NO

dev->set_multicast_list:
	Locking: Inside dev->xmit_lock spinlock.
	Sleeping: NO



--------------C268B649A7842FB7450882D7--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
