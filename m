Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278185AbRJLWex>; Fri, 12 Oct 2001 18:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278186AbRJLWen>; Fri, 12 Oct 2001 18:34:43 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:45877 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S278185AbRJLWeZ>; Fri, 12 Oct 2001 18:34:25 -0400
Date: Fri, 12 Oct 2001 17:34:54 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Matt_Domsch@Dell.com
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: RE: crc32 cleanups
In-Reply-To: <71714C04806CD51193520090272892178BD70B@ausxmrr502.us.dell.com>
Message-ID: <Pine.LNX.3.96.1011012172511.13514D-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Still need init_crc32:
  8139too, au1000_eth, fealnx, smc91c92_cs, xircom_tulip_cb, smc9194,
  via-rhine, winbond-840, 

* lib/uuid.o needs to be in lib/Makefile's export-objs

* in init/cleanup_crc32, don't hold spinlock during kmalloc/kfree.
  Check out other refcounting schemes in the various fs/*.c files.

* Add a Config.in entry, so that people can manually select to compile
  crc32.o as a module.  This takes care of the 3rd party module case,
  the module that might for example have been built some time
  after the kernel itself was built.


