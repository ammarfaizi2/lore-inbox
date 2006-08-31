Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWHaIPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWHaIPj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 04:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWHaIPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 04:15:38 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:57377 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751276AbWHaIPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 04:15:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=H2CGwiVPQptBA9WSki92RFZ/nCLyCDEP00ly/P0XbEXqSx+xCy7vBMkqjyCddrCu3D5GbsBPoFNeo9oPm0vq8FtnUtWGWbSQi7Xu5YTRXY9JUyuTs/g5DTZMxRl2LmDKXqt0WidvnAMitjvNkU+sFMj1ruC5WruqeXiSehj5soE=
Message-ID: <9a8748490608310115o288fe080pdac53e8d2b8d3f84@mail.gmail.com>
Date: Thu, 31 Aug 2006 10:15:37 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: 2.6.18-rc5-git3 build error on i386 - include/asm/spinlock.h
Cc: "Benjamin LaHaise" <bcrl@kvack.org>, "Linus Torvalds" <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-rc5-git2 builds just fine, but with -git3 I get the following :

  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CC      arch/i386/kernel/asm-offsets.s
In file included from include/linux/spinlock.h:86,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:44,
                 from include/linux/module.h:9,
                 from include/linux/crypto.h:20,
                 from arch/i386/kernel/asm-offsets.c:7:
include/asm/spinlock.h: In function `__raw_read_lock':
include/asm/spinlock.h:164: error: syntax error before ')' token
include/asm/spinlock.h: In function `__raw_write_lock':
include/asm/spinlock.h:169: error: called object is not a function
include/asm/spinlock.h:169: warning: left-hand operand of comma
expression has no effect
include/asm/spinlock.h:169: warning: left-hand operand of comma
expression has no effect
include/asm/spinlock.h:169: error: syntax error before ')' token
make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2

Let me know if there's any additional info you need or patches you
want me to test.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
