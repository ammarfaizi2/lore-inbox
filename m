Return-Path: <linux-kernel-owner+willy=40w.ods.org-S280856AbUKBDMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S280856AbUKBDMI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 22:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S379981AbUKAXAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:00:03 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:33221 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S281822AbUKAVqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:46:55 -0500
Date: Mon, 1 Nov 2004 15:43:45 -0600
From: Maneesh Soni <maneesh@in.ibm.com>
To: schwidefsky@de.ibm.com
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: s390 drivers compilation
Message-ID: <20041101214345.GC2613@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

I get this on 2.6.10-rc1-bk11. 

  CC [M]  drivers/s390/net/netiucv.o
  CC [M]  drivers/s390/net/fsm.o
  CC [M]  drivers/s390/net/smsgiucv.o
  CC [M]  drivers/s390/net/ctcmain.o
drivers/s390/net/ctcmain.c: In function `ch_action_setmode':
drivers/s390/net/ctcmain.c:1221: warning: `saveflags' might be used uninitialized in this function
drivers/s390/net/ctcmain.c: In function `ch_action_restart':
drivers/s390/net/ctcmain.c:1497: warning: `saveflags' might be used uninitialized in this function
drivers/s390/net/ctcmain.c: In function `ch_action_txretry':
drivers/s390/net/ctcmain.c:1648: warning: `saveflags' might be used uninitialized in this function
drivers/s390/net/ctcmain.c: In function `ch_action_haltio':
drivers/s390/net/ctcmain.c:1331: warning: `saveflags' might be used uninitialized in this function
  CC [M]  drivers/s390/net/ctctty.o
  CC [M]  drivers/s390/net/ctcdbug.o
  CC [M]  drivers/s390/net/qeth_main.o
drivers/s390/net/qeth_main.c: In function `qeth_ipv6_generate_eui64':
drivers/s390/net/qeth_main.c:5015: error: structure has no member named `dev_id'
drivers/s390/net/qeth_main.c:5016: error: structure has no member named `dev_id'
drivers/s390/net/qeth_main.c: In function `qeth_netdev_init':
drivers/s390/net/qeth_main.c:5568: error: structure has no member named `dev_id'
drivers/s390/net/qeth_main.c:5570: error: structure has no member named `generate_eui64'
make[2]: *** [drivers/s390/net/qeth_main.o] Error 1
make[1]: *** [drivers/s390/net] Error 2
make: *** [drivers/s390] Error 2

Looks like struct netdevice is missing dev_id and generate_eui64 fields in include/linux/netdevice.h.

Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 6781896
