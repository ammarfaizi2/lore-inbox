Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbUDPMqx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 08:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbUDPMqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 08:46:53 -0400
Received: from web60605.mail.yahoo.com ([216.109.118.243]:28003 "HELO
	web60605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263032AbUDPMqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 08:46:51 -0400
Message-ID: <20040416124650.91521.qmail@web60605.mail.yahoo.com>
Date: Fri, 16 Apr 2004 05:46:50 -0700 (PDT)
From: Ravi Kumar Munnangi <munnangi_ivar@yahoo.com>
Subject: error compiling kernel-2.2.17
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  
  As suggested by previous messages in this mailing
list,
  I used kgcc(egcs-1.1.2) for compiling linux-2.2.17.
  Still Iam facing the following error.
 
make -C  arch/i386/lib
make[1]: Entering directory
`/usr/src/linux-2.2.17/arch/i386/lib'
make all_targets
make[2]: Entering directory
`/usr/src/linux-2.2.17/arch/i386/lib'
cc -D__KERNEL__ -I/usr/src/linux-2.2.17/include
-D__ASSEMBLY__  -traditional -c
checksum.S -o checksum.o
checksum.S:231: badly punctuated parameter list in
#define
checksum.S:237: badly punctuated parameter list in
#define
make[2]: *** [checksum.o] Error 1
make[2]: Leaving directory
`/usr/src/linux-2.2.17/arch/i386/lib'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory
`/usr/src/linux-2.2.17/arch/i386/lib'
make: *** [_dir_arch/i386/lib] Error 2

The code related to this is shown below:

#define SRC(y...)                       \
        9999: y;                        \
        .section __ex_table, "a";       \
        .long 9999b, 6001f      ;       \
        .previous 

#define DST(y...)                       \
        9999: y;                        \
        .section __ex_table, "a";       \
        .long 9999b, 6002f      ;       \
        .previous 

 Please suggest me the correction I have to make.

 Thanks,
 ravikumar





	
		
__________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online by April 15th
http://taxes.yahoo.com/filing.html
