Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315734AbSG1Lqp>; Sun, 28 Jul 2002 07:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315748AbSG1Lqp>; Sun, 28 Jul 2002 07:46:45 -0400
Received: from mail2.alphalink.com.au ([202.161.124.58]:47426 "EHLO
	mail2.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S315734AbSG1Lqo>; Sun, 28 Jul 2002 07:46:44 -0400
Message-ID: <3D43DA11.5D56BBDC@alphalink.com.au>
Date: Sun, 28 Jul 2002 21:48:33 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       Ivan Gyurdiev <ivangurdiev@attbi.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH 2.5: kconfig LDM broke xconfig in 2.5.29
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day,

Ivan Gyurdiev wrote:
> [root@cobra linux-2.5]# make xconfig
> [...]
> fs/partitions/Config.in: 28: can't handle dep_bool/dep_mbool/dep_tristate 
> condition

trivial fix is:

--- fs/partitions/Config.in.orig	Sun Jul 28 21:39:14 2002
+++ fs/partitions/Config.in	Sun Jul 28 21:39:16 2002
@@ -25,7 +25,7 @@
       bool '    Solaris (x86) partition table support' CONFIG_SOLARIS_X86_PARTITION
       bool '    Unixware slices support' CONFIG_UNIXWARE_DISKLABEL
    fi
-   dep_bool '  Windows Logical Disk Manager (Dynamic Disk) support' CONFIG_LDM_PARTITION
+   bool '  Windows Logical Disk Manager (Dynamic Disk) support' CONFIG_LDM_PARTITION
    if [ "$CONFIG_LDM_PARTITION" = "y" ]; then
       bool '    Windows LDM extra logging' CONFIG_LDM_DEBUG
    fi


Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
