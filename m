Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265631AbUATSVv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265642AbUATSVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:21:51 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:57829 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265631AbUATSVl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:21:41 -0500
Subject: [ERROR] 2.6.1 drivers/scsi/aic7xxx/aicasm fails with allmodconfig
From: Omkhar Arasaratnam <iamroot@ca.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1074622850.6823.89.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 20 Jan 2004 13:20:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems this module fails - anyone else seeing this? 

omkhar linux-clean # make mrproper; make allmodconfig; make
<...snip...>
  LD [M]  drivers/scsi/aacraid/aacraid.o
  LD      drivers/scsi/aic7xxx/built-in.o
make -C drivers/scsi/aic7xxx/aicasm
yacc -d -b aicasm_gram aicasm_gram.y
mv aicasm_gram.tab.c aicasm_gram.c
mv aicasm_gram.tab.h aicasm_gram.h
yacc -d -b aicasm_macro_gram -p mm aicasm_macro_gram.y
mv aicasm_macro_gram.tab.c aicasm_macro_gram.c
mv aicasm_macro_gram.tab.h aicasm_macro_gram.h
lex  -oaicasm_scan.c aicasm_scan.l
lex  -Pmm -oaicasm_macro_scan.c aicasm_macro_scan.l
gcc -I/usr/include -I. aicasm.c aicasm_symbol.c aicasm_gram.c aicasm_macro_gram.c aicasm_scan.c aicasm_macro_scan.c -o aicasm -ldb
/tmp/cc3HQvfD.o(.text+0x1d0): In function `symtable_open':
: undefined reference to `__db185_open'
collect2: ld returned 1 exit status
make[4]: *** [aicasm] Error 1
make[3]: *** [drivers/scsi/aic7xxx/aicasm/aicasm] Error 2
make[2]: *** [drivers/scsi/aic7xxx] Error 2
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

-- 
Omkhar

