Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269645AbRIVNQi>; Sat, 22 Sep 2001 09:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270201AbRIVNQa>; Sat, 22 Sep 2001 09:16:30 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:34834 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S269645AbRIVNQR>;
	Sat, 22 Sep 2001 09:16:17 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Tainting kernels for non-GPL or forced modules
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 22 Sep 2001 23:15:29 +1000
Message-ID: <27975.1001164529@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have started work on the patch for /proc/sys/kernel/tainted with the
corresponding modutils and ksymoops changes.  insmod of a non-GPL
module ORs /proc/sys/kernel/tainted with 1, insmod -f ORs with 2.

What to do about modules with no license?  Complain and taint or
silently ignore?  A lot of modules in -ac14 have no MODULE_LICENSE,
probably because they have no MODULE_AUTHOR.  IMHO the default should
be complain and taint, even though it will generate lots of newbie
questions to l-k.

