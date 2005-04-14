Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVDNTpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVDNTpX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 15:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVDNTpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 15:45:22 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:38293 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261608AbVDNTpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 15:45:01 -0400
Message-ID: <425EC836.5060004@ca.ibm.com>
Date: Thu, 14 Apr 2005 15:44:54 -0400
From: Omkhar Arasaratnam <iamroot@ca.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>, baude@us.ibm.com
Subject: 2.4.30 Build Error Using pSeries_defconfig on ppc64
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, heres what I do

cd /usr/src/linux
make mrproper
cp arch/ppc64/configs/pSeries_defconfig .config
make menuconfig
<exit>
make dep
make clean
make vmlinux

Eventually it bombs out with several messages such as:

ioctl32.c:X: error: (near initialization for `ioctl_translations[Y]')

Culminating in :

ioctl32.c:4597: error: (near initialization for `ioctl_translations[691]')
make[1]: *** [ioctl32.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.30/arch/ppc64/kernel'
make: *** [_dir_arch/ppc64/kernel] Error 2


Obviously something ain't right - ideas?

O

