Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbTDYM5E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 08:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTDYM5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 08:57:04 -0400
Received: from copper.ftech.net ([212.32.16.118]:42379 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id S261747AbTDYM5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 08:57:03 -0400
Message-ID: <7C078C66B7752B438B88E11E5E20E72E25C89B@GENERAL.farsite.co.uk>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Building the Kernel on Sparc64
Date: Fri, 25 Apr 2003 14:09:13 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I have installed Aurora 1.0 on a Sparc Ultra 60 workstation and have
a command line system running (X doesn't work yet but that's another
question for later).  

I have downloaded the 2.4.20 Kernel from www.kernel.org and started with the
default config file (defconfig) from the /usr/src/linux/arch/sparc64
directory.  The first time I built the Kernel all was OK.  However it didn't
load because the required scsi driver wasn't included.  So I ran make
xconfig to add it.  But then after a 
make dep
make vmlinux

I go an error from fonts.c in driver/video indicating that no fonts were
defined.

#ifdef NO_FONTS
#error No fonts configured.
#endif

This error wouldn't go away until I did a

make mrproper
make oldconfig
make dep
make vmlinux

I then made another change to the Kernel config and the same thing happened.

Can anyone throw some light on this?


Thanks

Kevin
