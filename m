Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbTH2REa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbTH2REa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:04:30 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:26318 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261258AbTH2RE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:04:26 -0400
Date: Fri, 29 Aug 2003 19:03:57 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 2.6.0-test4: Descriptions.
Message-ID: <20030829170357.GA1242@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
I have 8 patches for you. 7 are s390 related, one is a bug fix for sysfs.
I'll put Pat on CC for this one but I am very confident that it is correct.

Short descriptions:
1) The usual arch bug fix collection for s390.
2) Kconfig update. Arnd added a condition to BLK_DEV_FD in
   drivers/block/Kconfig so that we can use it in the s390 config.
   In addition the s390 block device configs now reside in
   drivers/s390/block/Kconfig where they belong and VLAN_8021Q=m
   && QETH=y not works.

3) The sysfs memory leak fix. On s390 we have a stress test that
   sets a disk online and offline all the time. Without this patch
   we are out of memory after a few minutes because dead dcache
   entries are not freed. With the patch the test runs fine.

4) Make use of module_param in s390 drivers.
5) Some fixes for the common i/o layer.
6) Minimal bug fix for the dasd driver.
7) s390 network driver update.
8) s390 docu update.

blue skies,
  Martin.

