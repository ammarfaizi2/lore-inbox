Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290260AbSAXXge>; Thu, 24 Jan 2002 18:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290463AbSAXXgY>; Thu, 24 Jan 2002 18:36:24 -0500
Received: from mail.linpro.no ([213.203.57.2]:6160 "HELO linpro.no")
	by vger.kernel.org with SMTP id <S290260AbSAXXgL> convert rfc822-to-8bit;
	Thu, 24 Jan 2002 18:36:11 -0500
To: linux-kernel@vger.kernel.org
Subject: compile error -rmap12a and 2.4.18-pre7
From: knobo@linpro.no
Date: 25 Jan 2002 00:36:08 +0100
Message-ID: <ujpadv3tj87.fsf@false.linpro.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I applied first rmap12a ant then 2.4.18-pre7

then I removed line 502 (i think) "nr_pages--" from
linux/mm/vmscan.c. (thanx to mjc)

Then I did  make dep clean bzImage. 

then I got some warnings:
In file included from /usr/src/linux/include/linux/modversions.h:144,
                 from /usr/src/linux/include/linux/module.h:21,
                 from dec_and_lock.c:1:
/usr/src/linux/include/linux/modules/ksyms.ver:249: warning: `__ver_waitfor_one_page' redefined
/usr/src/linux/include/linux/modules/buffer.ver:13: warning: this is the location of the previous definition

And finally:

fs/fs.o(__ksymtab+0x38): multiple definition of `__ksymtab_waitfor_one_page'
kernel/kernel.o(__ksymtab+0x548): first defined here
fs/fs.o(.kstrtab+0xfb): multiple definition of `__kstrtab_waitfor_one_page'
kernel/kernel.o(.kstrtab+0x10fa): first defined here
make: *** [vmlinux] Error 1



Then I turned off loadable module support, and the kernel compiled ok.


-- 
Knut Olav Bøhmer
         _   _
       / /  (_)__  __ ____  __
      / /__/ / _ \/ // /\ \/ /  ... The choice of a
     /____/_/_//_/\.,_/ /_/\.\         GNU generation

export PAGER="od -x |less"
