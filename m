Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSHaXlp>; Sat, 31 Aug 2002 19:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316204AbSHaXlp>; Sat, 31 Aug 2002 19:41:45 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:33756 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S315709AbSHaXlo>; Sat, 31 Aug 2002 19:41:44 -0400
Message-ID: <3D7154C6.7090405@oracle.com>
Date: Sun, 01 Sep 2002 01:44:06 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Consulting Premium Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020606
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.33: LOG macro in cpia.c broken
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   gcc -Wp,-MD,./.cpia.o.d -D__KERNEL__ 
-I/usr/local/src/linux-2.5.33/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix 
include -DMODULE   -DKBUILD_BASENAME=cpia -DEXPORT_SYMTAB  -c -o cpia.o 
cpia.c
cpia.c: In function `proc_cpia_create':
cpia.c:1255: called object is not a function
cpia.c:1255: parse error before string constant
cpia.c:1255: warning: left-hand operand of comma expression has no effect
cpia.c:1255: parse error before ')' token
cpia.c: In function `set_vw_size':
cpia.c:1460: called object is not a function
cpia.c:1460: parse error before string constant

[etc.]

All lines with "called object is not a function" have the LOG
  macro which is supposed to ultimately call printk().

--alessandro

  "everything dies, baby that's a fact
    but maybe everything that dies someday comes back"
        (Bruce Springsteen, "Atlantic City")

