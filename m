Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267540AbTAQPtO>; Fri, 17 Jan 2003 10:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267543AbTAQPtO>; Fri, 17 Jan 2003 10:49:14 -0500
Received: from tomts9.bellnexxia.net ([209.226.175.53]:15043 "EHLO
	tomts9-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267540AbTAQPtM>; Fri, 17 Jan 2003 10:49:12 -0500
Date: Fri, 17 Jan 2003 10:57:32 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: unresolved symbols building 2.5.59
Message-ID: <Pine.LNX.4.44.0301171055180.8002-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


tail end of "make modules_install":

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.59; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.59/kernel/drivers/i2c/i2c-proc.ko
depmod: 	i2c_check_functionality
depmod: 	i2c_smbus_xfer
depmod: 	i2c_check_addr
depmod: 	i2c_adapter_id
depmod: *** Unresolved symbols in /lib/modules/2.5.59/kernel/fs/cramfs/cramfs.ko
depmod: 	zlib_inflate
depmod: 	zlib_inflate_workspacesize
depmod: 	zlib_inflateInit_
depmod: 	zlib_inflateReset
depmod: 	zlib_inflateEnd

  the first one seems to be i2c-proc looking for symbols in i2c-core,
which i selected and which was built.

  the second seems to be that cramfs needs zlib_inflate, which once
again i selected and which was built.

  beyond that, i'm not sure how to further debug these.

rday

