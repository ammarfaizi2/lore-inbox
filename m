Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275873AbSIUDuT>; Fri, 20 Sep 2002 23:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275874AbSIUDuS>; Fri, 20 Sep 2002 23:50:18 -0400
Received: from ma-northadams1b-39.bur.adelphia.net ([24.52.166.39]:40084 "EHLO
	ma-northadams1b-39.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S275873AbSIUDuS>; Fri, 20 Sep 2002 23:50:18 -0400
Date: Fri, 20 Sep 2002 23:55:21 -0400
From: Eric Buddington <eric@ma-northadams1b-39.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.37: hd.c: `hd_gendisk' undeclared in `hd_request'
Message-ID: <20020920235521.A32621@ma-northadams1b-39.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the kernel configured with 'make allmodconfig' and essentials
set to Y (IDE disks, SCSI CDROM, keyboard), and processor set to PII,
I get the following error from 'make bzImage':

--------------------------------
hd.c: In function `hd_request':
hd.c:593: `hd_gendisk' undeclared (first use in this function)
hd.c:593: (Each undeclared identifier is reported only once
hd.c:593: for each function it appears in.)
hd.c:594: `unit' undeclared (first use in this function)
hd.c: At top level:
hd.c:694: `hd_gendisk' used prior to declaration
make[3]: *** [hd.o] Error 1
make[3]: Leaving directory `/packages/linux/2.5.37/any/src/linux-2.5.37/drivers/ide/legacy'
--------------------------------

This is probably a config option I don't actually need, but I thought
it worth noting.

-Eric

