Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131643AbRDMUNO>; Fri, 13 Apr 2001 16:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRDMUNF>; Fri, 13 Apr 2001 16:13:05 -0400
Received: from elin.scali.no ([195.139.250.10]:24586 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S131643AbRDMUMz>;
	Fri, 13 Apr 2001 16:12:55 -0400
Message-ID: <3AD76BA0.EF7EDE6D@scali.no>
Date: Fri, 13 Apr 2001 23:12:00 +0200
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.16-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.3 and Alpha
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any particular reasons why a stock 2.4.3 kernel doesn't have mm.h and
pgalloc.h in sync on Alpha. This is what I get :

# make boot
gcc -D__KERNEL__ -I/usr/src/redhat/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mno-fp-regs -ffixed-8 -mcpu=ev5 -Wa,-mev6   -c -o init/main.o
init/main.c
In file included from /usr/src/redhat/linux/include/linux/highmem.h:5,
                 from /usr/src/redhat/linux/include/linux/pagemap.h:16,
                 from /usr/src/redhat/linux/include/linux/locks.h:8,
                 from /usr/src/redhat/linux/include/linux/raid/md.h:36,
                 from init/main.c:24:
/usr/src/redhat/linux/include/asm/pgalloc.h:334: conflicting types for
`pte_alloc'
/usr/src/redhat/linux/include/linux/mm.h:399: previous declaration of
`pte_alloc'
/usr/src/redhat/linux/include/asm/pgalloc.h:352: conflicting types for
`pmd_alloc'
/usr/src/redhat/linux/include/linux/mm.h:412: previous declaration of
`pmd_alloc'
make: *** [init/main.o] Error 1


2.4.1 compiled fine, and as far as I can see, some changes has been made
to mm.h since then. I think these changes was followed up by i386, ppc,
s390 and sparc64 kernels but not on others. Any plans on when this is
done ?

Best regards,
-- 
  Steffen Persvold               Systems Engineer
  Email : mailto:sp@scali.no     Scali AS (http://www.scali.com)
  Tlf   : (+47) 22 62 89 50      Olaf Helsets vei 6
  Fax   : (+47) 22 62 89 51      N-0621 Oslo, Norway
