Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbTJZAWN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 20:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbTJZAWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 20:22:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:31707 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262917AbTJZAWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 20:22:12 -0400
Date: Sun, 26 Oct 2003 02:22:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Stephen Smalley <sds@epoch.ncsc.mil>, jmorris@redhat.com
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: 2.6.0-test9: selinux compile error with "make O=..."
Message-ID: <20031026002209.GD23291@fs.tum.de>
References: <Pine.LNX.4.44.0310251152410.5764-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310251152410.5764-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error in 2.6.0-test9 (using "make O=..."):

<--  snip  -->

...
  CC      security/selinux/ss/ebitmap.o
cpp0: security/selinux/ss/global.h: No such file or directory
make[4]: *** [security/selinux/ss/ebitmap.o] Error 1

<--  snip  -->

The problem comes from the following line in 
security/selinux/ss/Makefile:
  EXTRA_CFLAGS += -Isecurity/selinux/include -include security/selinux/ss/global.h


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

