Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318440AbSGaSkJ>; Wed, 31 Jul 2002 14:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318441AbSGaSkJ>; Wed, 31 Jul 2002 14:40:09 -0400
Received: from mail.wolnet.de ([213.178.16.8]:20163 "HELO wolnet.de")
	by vger.kernel.org with SMTP id <S318440AbSGaSkJ>;
	Wed, 31 Jul 2002 14:40:09 -0400
From: Peter <pk@q-leap.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15688.12243.848371.562052@gargle.gargle.HOWL>
Date: Wed, 31 Jul 2002 20:43:31 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, Peter <pk@q-leap.com>,
       linux-kernel@vger.kernel.org, johannes@erdfelt.com
Subject: Re: oops with usb-serial converter
In-Reply-To: <1027969112.4101.16.camel@irongate.swansea.linux.org.uk>
References: <S.0001006613@wolnet.de>
	<20020729173724.GA10153@kroah.com>
	<1027969112.4101.16.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: pk@q-leap.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

unfortunately the kernel doesn't compile:

lvm.c:1: #error Broken until maintainers will sanitize kdev_t handling
lvm.c: In function `lvm_user_bmap':
lvm.c:1012: structure has no member named `bi_dev'
lvm.c:1013: structure has no member named `bi_dev'
lvm.c:1021: structure has no member named `bi_dev'
lvm.c:1021: structure has no member named `bi_dev'
lvm.c:1021: structure has no member named `bi_dev'
lvm.c:1021: structure has no member named `bi_dev'
lvm.c: In function `lvm_map':
lvm.c:1091: structure has no member named `bi_dev'
lvm.c:1215: structure has no member named `bi_dev'
lvm.c: In function `lvm_do_pe_lock_unlock':
lvm.c:1321: warning: implicit declaration of function `fsync_dev'
lvm.c: In function `__update_hardsectsize':
lvm.c:1789: warning: implicit declaration of function
`get_hardsect_size'
lvm.c: In function `lvm_do_lv_remove':
lvm.c:2127: warning: implicit declaration of function
`invalidate_buffers'
lvm.c: In function `lvm_geninit':
lvm.c:2660: `blksize_size' undeclared (first use in this function)
lvm.c:2660: (Each undeclared identifier is reported only once
lvm.c:2660: for each function it appears in.)
make[2]: *** [lvm.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.29/drivers/md'
make[1]: *** [md] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.29/drivers'
make: *** [drivers] Error 2

this is with:  gcc --version 2.95.4

well, I use lvm, now I could try to compile without lvm support and
boot into single user mode, and see if that works... or could you send
me the function in question (maybe as a patch to 2.4.19-rc3?) - and if
it works then, maybe the 2.4.19 final will include the patch?

thanks for your support,

	Peter

-- 
Peter Kruse <pk@q-leap.com>
Q-Leap Networks GmbH
+497071-703171

