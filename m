Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbUJWRK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbUJWRK3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 13:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUJWRK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 13:10:28 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:64157 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261255AbUJWRKM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 13:10:12 -0400
Date: Sat, 23 Oct 2004 17:10:04 +0000
From: Willem Riede <wrlk@riede.org>
Reply-To: wrlk@riede.org
Subject: Should osst call cdev_alloc()
To: linux-kernel@vger.kernel.org
X-Mailer: Balsa 2.2.4
Message-Id: <1098551404l.3844l.1l@serve.riede.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, sg.c and st.c contain calls to cdev_alloc() and friends:


[wriede@serve kernel]$ find linux-2.6.9 -name '*.c' | xargs grep cdev_alloc
linux-2.6.9/drivers/s390/char/tape_class.c:     tcd->char_device =
cdev_alloc();
linux-2.6.9/drivers/scsi/sg.c:  cdev = cdev_alloc();
linux-2.6.9/drivers/scsi/sg.c:          printk(KERN_WARNING "cdev_alloc
failed\n");
linux-2.6.9/drivers/scsi/st.c:                  cdev = cdev_alloc();
linux-2.6.9/fs/char_dev.c:      cdev = cdev_alloc();
linux-2.6.9/fs/char_dev.c:struct cdev *cdev_alloc(void)
linux-2.6.9/fs/char_dev.c:EXPORT_SYMBOL(cdev_alloc);


My question is: should osst do the same? It seems to work just fine without.

Please cc me on answers, as I'm currently not subscribed to linux-kernel.

Thanks, Willem Riede,
osst maintainer

