Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274024AbRISJJC>; Wed, 19 Sep 2001 05:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274025AbRISJIv>; Wed, 19 Sep 2001 05:08:51 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:21767 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S274024AbRISJIj>; Wed, 19 Sep 2001 05:08:39 -0400
Message-ID: <3BA86087.A0A371E0@idb.hist.no>
Date: Wed, 19 Sep 2001 11:08:23 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.10-pre10 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.10-pre12 compile error, IO_APIC_init_uniprocessor undefined
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

init/main.c refers to an IO_APIC_init_uniprocessor() that doesn't exist 
anywhere.  The function exists in 2.4.9 but is removed by the patch to 
pre12.

Turning off "APIC and IO-APIC support on uniprocessors" lets the
kernel compile.


gcc [snip several lines of the usual options] init/main.c
init/main.c: In function `smp_init':
init/main.c:486: warning: implicit declaration of function 
`IO_APIC_init_uniprocessor'
1234567890121234567890123456789012345678901234567890123456789034567890
and later

ld [snip several lines of options] -o vmlinux
init/main.o: In function `smp_init':
init/main.o(.text.init+0x74d): undefined reference to
`IO_APIC_init_uniprocessor'
make: *** [vmlinux] Error 1

Helge Hafting
