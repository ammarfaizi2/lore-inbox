Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVDMAhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVDMAhI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 20:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVDMAem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 20:34:42 -0400
Received: from arhont4.eclipse.co.uk ([81.168.98.124]:7578 "EHLO
	mail.arhont.com") by vger.kernel.org with ESMTP id S263039AbVDMAbj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 20:31:39 -0400
Message-ID: <425C6865.5030306@arhont.com>
Date: Wed, 13 Apr 2005 01:31:33 +0100
From: "Konstantin V. Gavrilenko" <mlists@arhont.com>
Reply-To: kos@arhont.com
Organization: Arhont Ltd. - Information Security
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: uml wouldn't link/compile with UDF
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-2.6.11.6.6

The uml wouldn't compile when the
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y



The error output is:

  LD      lib/zlib_deflate/built-in.o
  LD      lib/zlib_inflate/built-in.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
/usr/lib/libc.a(mktime.o)(.rodata+0x0): multiple definition of `__mon_yday'
fs/built-in.o(.rodata+0x3380): first defined here
collect2: ld returned 1 exit status
  KSYM    .tmp_kallsyms1.S
nm: '.tmp_vmlinux1': No such file
/bin/bash: line 1: 11859 Exit 1                  nm -n .tmp_vmlinux1
     11860 Segmentation fault      | scripts/kallsyms >.tmp_kallsyms1.S
make: *** [.tmp_kallsyms1.S] Error 139



usetting the UDF options solves the issue.


-- 
Respectfully,
Konstantin V. Gavrilenko

Arhont Ltd - Information Security

web:    http://www.arhont.com
	http://www.wi-foo.com
e-mail: k.gavrilenko@arhont.com

tel: +44 (0) 870 44 31337
fax: +44 (0) 117 969 0141

PGP: Key ID - 0x4F3608F7
PGP: Server - keyserver.pgp.com
