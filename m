Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVGFT6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVGFT6H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVGFT4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:56:48 -0400
Received: from mail.portrix.net ([212.202.157.208]:16258 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S262119AbVGFPxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 11:53:19 -0400
Message-ID: <42CBFE61.9030308@ppp0.net>
Date: Wed, 06 Jul 2005 17:53:05 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: Linux 2.6.13-rc2
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org> <42CB8088.1090508@ppp0.net> <Pine.LNX.4.58.0507060832380.3570@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507060832380.3570@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 6 Jul 2005, Jan Dittmer wrote:
> 
>>Linus Torvalds wrote:
>>
>>>Ok,
>>> -rc3 is pretty small, with the bulk of the diff being some defconfig
>>
>>...
>>
>>>Linus Torvalds:
>>>  Linux v2.6.13-rc3
>>
>>Confused?!
> 
> 
> Constantly.
> 
> Let's hope that commit naming bug was the worst part of the release..

Nah, compared to git7 you (or greg?) managed to break alpha, sparc and x86_64.

Jan

Comparing 2.6.13-rc1-git7 to 2.6.13-rc2 (defconfig)
===================================================

- alpha: broke
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:156: error: dereferencing pointer to incomplete type
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:156: error: dereferencing pointer to incomplete type
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:156: warning: type defaults to `int' in declaration of `type name'
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:156: error: request for member `node' in something not a structure or union
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:156: warning: type defaults to `int' in declaration of `type name'
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:157: error: dereferencing pointer to incomplete type
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:159: error: dereferencing pointer to incomplete type
  make[3]: *** [drivers/pci/pci-driver.o] Error 1
  make[2]: *** [drivers/pci] Error 2
  make[1]: *** [drivers] Error 2
  make: *** [_all] Error 2


  Details: http://l4x.org/k/?d=5184

- sparc: broke
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:156: error: dereferencing pointer to incomplete type
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:156: error: dereferencing pointer to incomplete type
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:156: warning: type defaults to `int' in declaration of `type name'
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:156: error: request for member `node' in something not a structure or union
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:156: warning: type defaults to `int' in declaration of `type name'
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:157: error: dereferencing pointer to incomplete type
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:159: error: dereferencing pointer to incomplete type
  make[3]: *** [drivers/pci/pci-driver.o] Error 1
  make[2]: *** [drivers/pci] Error 2
  make[1]: *** [drivers] Error 2
  make: *** [_all] Error 2


  Details: http://l4x.org/k/?d=5204

- x86_64: broke
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:156: error: dereferencing pointer to incomplete type
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:156: error: dereferencing pointer to incomplete type
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:156: warning: type defaults to `int' in declaration of `type name'
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:156: error: request for member `node' in something not a structure or union
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:156: warning: type defaults to `int' in declaration of `type name'
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:157: error: dereferencing pointer to incomplete type
  /usr/src/ctest/rc/kernel/drivers/pci/pci-driver.c:159: error: dereferencing pointer to incomplete type
  make[3]: *** [drivers/pci/pci-driver.o] Error 1
  make[2]: *** [drivers/pci] Error 2
  make[1]: *** [drivers] Error 2
  make: *** [_all] Error 2


  Details: http://l4x.org/k/?d=5208

- arm26: still broken
  Details: http://l4x.org/k/?d=5186

- cris: still broken
  Details: http://l4x.org/k/?d=5187

- frv: still broken
  Details: http://l4x.org/k/?d=5188

- m68k: still broken
  Details: http://l4x.org/k/?d=5193

- m68knommu: still broken
  Details: http://l4x.org/k/?d=5195

- parisc: still broken
  Details: http://l4x.org/k/?d=5197

- s390: still broken
  Details: http://l4x.org/k/?d=5201

- sh: still broken
  Details: http://l4x.org/k/?d=5202

- sh64: still broken
  Details: http://l4x.org/k/?d=5203

- sparc64: still broken
  Details: http://l4x.org/k/?d=5205

- v850: still broken
  Details: http://l4x.org/k/?d=5207

- xtensa: still broken
  Details: http://l4x.org/k/?d=5209

Summary: 9 ok, 14 failed

