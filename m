Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262868AbRE0XbI>; Sun, 27 May 2001 19:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262869AbRE0Xa6>; Sun, 27 May 2001 19:30:58 -0400
Received: from cg669454-a.adubn1.nj.home.com ([24.7.210.175]:9988 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262868AbRE0Xar>; Sun, 27 May 2001 19:30:47 -0400
Message-ID: <3B118F2D.E3491F83@hotmail.com>
Date: Sun, 27 May 2001 19:35:09 -0400
From: Duane Ellis <dwayneisking@hotmail.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cross compile alpha make bootpfile fails
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cross compiling kernel (any recent version) on any non-64bit host (ie:
x86) to 
ALPHA the "make bootpfile" step fails. The problem is localized 
to arch/alpha/boot/tools/objstrip.c

Various 'elf' structure members are 64 bit, not 32bit and the wrong
version of
the structure is being choosen. (To bad you can't use the binutils
library here!)

I have hand coded around this, and can easily produce bootp files.
I would like to submit patches but my change/hack is not real pretty.

There are other issues associated with cross compiling this file, who is
an 
appropriate person reguarding alpha specific items such as these?

if you wish to disucuss this off-list, email duane_ellis _AT_
franklin.com

-Duane
