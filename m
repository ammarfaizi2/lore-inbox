Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVAXMsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVAXMsr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 07:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVAXMsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 07:48:46 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38671 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261314AbVAXMsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 07:48:45 -0500
Date: Mon, 24 Jan 2005 13:48:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, patrick.boettcher@desy.de,
       linux-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc2-mm1: DVB compile error
Message-ID: <20050124124840.GH3515@stusta.de>
References: <20050124021516.5d1ee686.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124021516.5d1ee686.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following compile error comes from Linus' tree:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o(.bss+0xd50e4): multiple definition of `debug'
arch/i386/kernel/built-in.o(.text+0x2e4c): first defined here
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


The offender is in drivers/media/dvb/dibusb/dvb-dibusb-core.c:

"debug" is not a good name for a global variable...


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


