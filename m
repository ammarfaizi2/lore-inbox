Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129404AbQKFWNJ>; Mon, 6 Nov 2000 17:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130456AbQKFWM7>; Mon, 6 Nov 2000 17:12:59 -0500
Received: from gateway-490.mvista.com ([63.192.220.206]:34808 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S129404AbQKFWMs>; Mon, 6 Nov 2000 17:12:48 -0500
Message-ID: <3A072CDD.C2EFB1C9@mvista.com>
Date: Mon, 06 Nov 2000 14:12:45 -0800
From: Michael Pruznick <michael_pruznick@mvista.com>
Reply-To: michael_pruznick@mvista.com
Organization: MontaVista
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: CONFIG_BLK_DEV_RAM_SIZE not used
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What's up with CONFIG_BLK_DEV_RAM_SIZE?  It is
set in .config by "make config", but it not
used by the kernel.   

I checked the cvs tree and see that it was used
for in a single rev of the file.  Looks to me
like this change may have been lost by accident.
Can anyone confirm or deny?  Is someone who can
fix this on this maillist? 


cvs diff -r1.59 -r1.60 rd.c
< int rd_size = 8192;           /* Size of the RAM disks */
< int rd_size = 4096;           /* Size of the RAM disks */
> int rd_size = CONFIG_BLK_DEV_RAM_SIZE;        /* Size of the RAM disks */


cvs diff -r1.60 -r1.61 rd.c
< int rd_size = CONFIG_BLK_DEV_RAM_SIZE;        /* Size of the RAM disks */
> int rd_size = 4096;           /* Size of the RAM disks */


-- 
Michael Pruznick, michael_pruznick@mvista.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
