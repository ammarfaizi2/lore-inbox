Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132084AbRCVQkh>; Thu, 22 Mar 2001 11:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132085AbRCVQk1>; Thu, 22 Mar 2001 11:40:27 -0500
Received: from pop.gmx.net ([194.221.183.20]:35237 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S132084AbRCVQkO>;
	Thu, 22 Mar 2001 11:40:14 -0500
Date: Thu, 22 Mar 2001 14:15:07 +0100
From: "Manfred H. Winter" <mahowi@gmx.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [2.4.3-pre6] error in "aic7xxx/aicasm"
Message-ID: <20010322141507.A29689@marvin.mahowi.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-Operating-System: Linux 2.4.3-pre2 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When I try to build the new aic7xxx modules in kernel 2.4.3-pre6 it
stops at "/usr/src/linux-2.4.3-pre6/drivers/scsi/aic7xxx/aicasm":

+++ 

make -C aic7xxx modules
make[3]: Entering directory `/usr/src/linux-2.4.3-pre6/drivers/scsi/aic7xxx'
yacc  aicasm/aicasm_gram.y
mv -f y.tab.c aicasm/aicasm_gram.c
lex  -t aicasm/aicasm_scan.l > aicasm/aicasm_scan.c
make -C aicasm
make[4]: Entering directory `/usr/src/linux-2.4.3-pre6/drivers/scsi/aic7xxx/aicasm'
gcc -I/usr/include -ldb1 aicasm_gram.c aicasm_scan.c aicasm.c aicasm_symbol.c -o aicasm
aicasm/aicasm_gram.y:45: ../queue.h: No such file or directory
aicasm/aicasm_gram.y:50: aicasm.h: No such file or directory
aicasm/aicasm_gram.y:51: aicasm_symbol.h: No such file or directory
aicasm/aicasm_gram.y:52: aicasm_insformat.h: No such file or directory
aicasm/aicasm_scan.l:44: ../queue.h: No such file or directory
aicasm/aicasm_scan.l:49: aicasm.h: No such file or directory
aicasm/aicasm_scan.l:50: aicasm_symbol.h: No such file or directory
aicasm/aicasm_scan.l:51: y.tab.h: No such file or directory
make[4]: *** [aicasm] Error 1
make[4]: Leaving directory `/usr/src/linux-2.4.3-pre6/drivers/scsi/aic7xxx/aicasm'
make[3]: *** [aicasm/aicasm] Error 2
make[3]: Leaving directory `/usr/src/linux-2.4.3-pre6/drivers/scsi/aic7xxx'
make[2]: *** [_modsubdir_aic7xxx] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.3-pre6/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.3-pre6/drivers'
make: *** [_mod_drivers] Error 2

+++ 

The header files it complains about are there.

Bye,

Manfred
-- 
 /"\                        | PGP-Key available at Public Key Servers
 \ /  ASCII ribbon campaign | or at "http://www.mahowi.de/"
  X   against HTML mail     | RSA: 0xC05BC0F5 * DSS: 0x4613B5CA
 / \  and postings          | GPG: 0x88BC3576 * ICQ: 61597169
