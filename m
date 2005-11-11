Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbVKKTO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVKKTO1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbVKKTO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:14:27 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:63025 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751075AbVKKTO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:14:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=ml672PSiSC2c09rm0w5RU48QOhwJUiVMULAS2cj4wg+V6TtyKbr7xF9nVv69d4NK/jNiXaezQFfLc5UEgk4SZ4ZXGopBowKlNM5DUyM/n/K9OtiSkNx9P4HiTG56j44LbqJU0JWrfMOChPqx7phSIXiEmNVzYN51HWXBlwYFrN4=
Subject: Re: 2.6.14-mm2
From: Badari Pulavarty <pbadari@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051110203544.027e992c.akpm@osdl.org>
References: <20051110203544.027e992c.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 11:14:06 -0800
Message-Id: <1131736446.25354.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-10 at 20:35 -0800, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm2/
> 

Doesn't compile on my PPC box. Looking at the problem to fix it.

Thanks,
Badari

elm3b157:/usr/src/linux-2.6.14 # make -j8 zImage
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  CC      drivers/pci/syscall.o
  CC      drivers/pci/hotplug/rpaphp_pci.o
  CC      drivers/pci/hotplug/rpaphp_slot.o
drivers/pci/hotplug/rpaphp_pci.c: In function `rpaphp_pci_config_slot':
drivers/pci/hotplug/rpaphp_pci.c:256: error: `systemcfg' undeclared
(first use in this function)
drivers/pci/hotplug/rpaphp_pci.c:256: error: (Each undeclared identifier
is reported only once
drivers/pci/hotplug/rpaphp_pci.c:256: error: for each function it
appears in.)
make[3]: *** [drivers/pci/hotplug/rpaphp_pci.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [drivers/pci/hotplug] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [drivers/pci] Error 2
make: *** [drivers] Error 2


