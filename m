Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751928AbWGAVJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbWGAVJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 17:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbWGAVJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 17:09:29 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:5679 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751928AbWGAVJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 17:09:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nW1V26yWZeY+mtOnAzpfMeFrKuIPDIvPyyeDbuqmd4n8mraCgYULdUQvXYqtl9coF6IyAnFSECaq952EBVpYD+/JcVYOH1Z2Q9NJlHWSfFMefND5vkFUgiEVXlWbHXhfkw+Mo6FcrIyaNvEC9yiIQxmVCCmqyE+A/NkZWrid18o=
Message-ID: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com>
Date: Sat, 1 Jul 2006 14:09:28 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting this:

  KLIBCLD usr/klibc/libc.so
usr/klibc/execl.o: In function `execl':
usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
usr/klibc/execle.o: In function `execle':
usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
usr/klibc/execvpe.o: In function `execvpe':
usr/klibc/execvpe.c:75: undefined reference to `__stack_chk_fail'
usr/klibc/execlp.o: In function `execlp':
usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
usr/klibc/execlpe.o: In function `execlpe':
usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
usr/klibc/vfprintf.o:usr/klibc/vfprintf.c:26: more undefined
references to `__stack_chk_fail' follow
make[2]: *** [usr/klibc/libc.so] Error 1

But I've searched all the .h and .c files in the tree and found no
reference to __stack_chk_fail.  I am running Ubuntu's Edgy Eft (the
latest development tree).

Thanks,
              Miles
