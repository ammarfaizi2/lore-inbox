Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbVJDBNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbVJDBNL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 21:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVJDBNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 21:13:11 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:39173 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751034AbVJDBNK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 21:13:10 -0400
From: Felix Oxley <lkml@oxley.org>
To: zippel@linux-m68k.org
Subject: make xconfig fails for older kernels
Date: Tue, 4 Oct 2005 02:13:03 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510040213.05361.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have downloaded 2.6.0 + patches up to 2.6.13 from kernel.org.

When I try to configure the kernel using 'make xconfig' I get the following 
error:

scripts/kconfig/mconf.c:91: error: static declaration of ‘current_menu’ 
follows non-static declaration
scripts/kconfig/lkc.h:63: error: previous declaration of ‘current_menu’ was 
here
make[1]: *** [scripts/kconfig/mconf.o] Error 1
make: *** [xconfig] Error 2

I attempted make menuconfig, make config, and make oldconfig but each failed 
with the same error,

This happens on 2.6.0, 2.6.1, 2.6.2 2.6.3, 2.6.4.
I have previously built newer kernels such as 2.6.13-rc2-rt7 without a 
problem.

I was able to overcome the error by commenting out the declaration of 
current_menu in mconf.c. But I am concerned as to the cause of this problem.

Does anyone have an explanation?

thanks,
Felix






