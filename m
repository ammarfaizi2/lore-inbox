Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVGCQHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVGCQHj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 12:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVGCQFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 12:05:34 -0400
Received: from mail.portrix.net ([212.202.157.208]:34753 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261470AbVGCP7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 11:59:05 -0400
Message-ID: <42C80B34.80007@ppp0.net>
Date: Sun, 03 Jul 2005 17:58:44 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050331 Thunderbird/1.0.2 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Zankel <chris@zankel.net>
CC: czankel@tensilica.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: arch xtensa does not compile
References: <42BD6557.9070102@ppp0.net> <42BD8622.8060506@zankel.net>
In-Reply-To: <42BD8622.8060506@zankel.net>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Zankel wrote:
> Jan Dittmer wrote:
> 
>>Hello Chris,
>>
>>the recently merged xtensa arch does not (cross) compile successfully.
>>I'm using 2.6.12-git7 which seems to have all patches (1-8) merged.
> 
> 
> I did have to make some more changes because of the other changes in 
> Andrew's tree, but wasn't sure what other patches would make it in.
> I'll submit the Xtensa patches shortly.

Current git tip (2.6.12-rc1-git5) still does not compile for me:

  LD      usr/built-in.o
  AS      arch/xtensa/kernel/align.o
  AS      arch/xtensa/kernel/entry.o
/usr/src/ctest/git/kernel/arch/xtensa/kernel/entry.S: Assembler messages:
/usr/src/ctest/git/kernel/arch/xtensa/kernel/entry.S:1612: Error: invalid register number (83) for 'rsr' instruction
make[2]: *** [arch/xtensa/kernel/entry.o] Error 1
make[1]: *** [arch/xtensa/kernel] Error 2
make: *** [_all] Error 2

I guess I'm using the wrong binutils version (2.15.94.0.2.2). Which is the
recommended gcc/binutils pair which is supposed to compile the kernel?

Reading specs from /usr/cc/xtensa/lib/gcc/xtensa-linux/3.4.4/specs
Configured with: ../configure --prefix=/usr/cc --exec-prefix=/usr/cc/xtensa
  --target=xtensa-linux --disable-shared --disable-werror --disable-nls
  --disable-threads --disable-werror --disable-libmudflap --with-newlib
  --with-gnu-as --with-gnu-ld --enable-languages=c
Thread model: single
gcc version 3.4.4 20050513 (prerelease)

GNU ld version 2.15.94.0.2.2 20041220

Thanks,

-- 
Jan
