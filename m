Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273511AbRIYUey>; Tue, 25 Sep 2001 16:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273515AbRIYUep>; Tue, 25 Sep 2001 16:34:45 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:56724 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S273511AbRIYUed>; Tue, 25 Sep 2001 16:34:33 -0400
Message-ID: <3BB0EA46.1070001@korseby.net>
Date: Tue, 25 Sep 2001 22:34:14 +0200
From: Kristian Peters <kristian.peters@korseby.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.10 - Warning: indirect lcall without `*'
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shouldn't that fixed earlier ?

I use gcc 2.95.3.

make[1]: Entering directory `/usr/src/linux-2.4.10/arch/i386/boot'
gcc -E -D__KERNEL__ -I/usr/src/linux-2.4.10/include -D__BIG_KERNEL__ 
-traditional -DSVGA_MODE=NORMAL_VGA  bootsect.S -o bbootsect.s
as -o bbootsect.o bbootsect.s
bbootsect.s: Assembler messages:
bbootsect.s:257: Warning: indirect lcall without `*'
ld -m elf_i386 -Ttext 0x0 -s --oformat binary bbootsect.o -o bbootsect
gcc -E -D__KERNEL__ -I/usr/src/linux-2.4.10/include -D__BIG_KERNEL__ 
-D__ASSEMBLY__ -traditional -DSVGA_MODE=NORMAL_VGA  setup.S -o bsetup.s
as -o bsetup.o bsetup.s
bsetup.s: Assembler messages:
bsetup.s:1912: Warning: indirect lcall without `*'

