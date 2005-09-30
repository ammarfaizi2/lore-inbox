Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbVI3CHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbVI3CHU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVI3CHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:07:20 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:19817 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932402AbVI3CHT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:07:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rzSj6JMWtAxqtx+1nxaXNcV6uBlY2rLsQ0+I4ViRWE+DhkHMneIFQ5cHtU1tRqxCXb66ywytij8mnaBDJGXfohkX7qNAB7LQvDANbNWKC7o90wB+kXJnsxjIobH7A7KO4nvIaRsi2K8wnMlKTSijyF5cH4ECxQB2ZIm8kLHYRdY=
Message-ID: <5bdc1c8b0509291907x77604133oc1d8a64e9e70dd59@mail.gmail.com>
Date: Thu, 29 Sep 2005 19:07:18 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: l2.6.14-rc2-rt7 - build problems - mce?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   Any ideas how I could configure the kernel to get past this
problem? Currently the config file says this about MCE:

CONFIG_GART_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_INTEL is not set

Can I safely set CONFIG_X86_MCE to no or not set? Or is this something
else completely?

Thanks,
Mark

lightning linux-2.6.14-rc2-rt7 # make
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  CC      arch/x86_64/kernel/mce.o
In file included from arch/x86_64/kernel/mce.c:17:
include/linux/fs.h: In function `lock_super':
include/linux/fs.h:847: warning: implicit declaration of function `down'
include/linux/fs.h: In function `unlock_super':
include/linux/fs.h:853: warning: implicit declaration of function `up'
arch/x86_64/kernel/mce.c: In function `mce_read':
arch/x86_64/kernel/mce.c:392: warning: type defaults to `int' in
declaration of `DECLARE_MUTEX'
arch/x86_64/kernel/mce.c:392: warning: parameter names (without types)
in function declaration
arch/x86_64/kernel/mce.c:401: error: `mce_read_sem' undeclared (first
use in this function)
arch/x86_64/kernel/mce.c:401: error: (Each undeclared identifier is
reported only once
arch/x86_64/kernel/mce.c:401: error: for each function it appears in.)
make[1]: *** [arch/x86_64/kernel/mce.o] Error 1
make: *** [arch/x86_64/kernel] Error 2
lightning linux-2.6.14-rc2-rt7 #
