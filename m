Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSHRKsU>; Sun, 18 Aug 2002 06:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSHRKsU>; Sun, 18 Aug 2002 06:48:20 -0400
Received: from mailhost.cs.auc.dk ([130.225.194.6]:45697 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP
	id <S314138AbSHRKsT>; Sun, 18 Aug 2002 06:48:19 -0400
Message-ID: <3D5F7BFD.90909@cs.auc.dk>
Date: Sun, 18 Aug 2002 12:50:37 +0200
From: Emmanuel Fleury <fleury@cs.auc.dk>
Organization: Aalborg University -- Computer Science Dpt.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
X-Accept-Language: fr, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Compilation problem in 2.4.19: drivers/scsi/aic7xxx/aicasm/aicasm_gram.y
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As I really don't know who is in charge of this part of the kernel
(there was no names in the file or around this file), I post directly
on the Linux Kernel mailing-list.

Sorry, if I'm wrong.

I tried to compile the 2.4.19 for my computer, but I get an error
message while compiling the file:
/usr/src/linux-2.4.19smp/drivers/scsi/aic7xxx/aicasm/aicasm_gram.y



[fleury@yggdrasil aicasm]$ pwd
/usr/src/linux-2.4.19smp/drivers/scsi/aic7xxx/aicasm

[fleury@yggdrasil aicasm]$ make
*** Install db development libraries
yacc -d -b aicasm_gram aicasm_gram.y
aicasm_gram.y:921: warning: previous rule lacks an ending `;'
aicasm_gram.y:935: warning: previous rule lacks an ending `;'
mv aicasm_gram.tab.c aicasm_gram.c
mv aicasm_gram.tab.h aicasm_gram.h
yacc -d -b aicasm_macro_gram -p mm aicasm_macro_gram.y
mv aicasm_macro_gram.tab.c aicasm_macro_gram.c
mv aicasm_macro_gram.tab.h aicasm_macro_gram.h
lex  -oaicasm_scan.c aicasm_scan.l
lex  -Pmm -oaicasm_macro_scan.c aicasm_macro_scan.l
cc -I/usr/include -I. -ldb aicasm.c aicasm_symbol.c aicasm_gram.c
aicasm_macro_gram.c aicasm_scan.c aicasm_macro_scan.c -o aicasm
aicasm_symbol.c:47: aicdb.h: No such file or directory
aicasm_gram.y:1846: warning: type mismatch with previous implicit
declaration
/usr/share/bison/bison.simple:924: warning: previous implicit
declaration of `yyerror'
aicasm_gram.y:1846: warning: `yyerror' was previously implicitly
declared to return `int'
aicasm_macro_gram.y:162: warning: type mismatch with previous implicit
declaration
/usr/share/bison/bison.simple:924: warning: previous implicit
declaration of `mmerror'
aicasm_macro_gram.y:162: warning: `mmerror' was previously implicitly
declared to return `int'
make: *** [aicasm] Error 1


Could somebody help me to fix this ?

The two missing `;' are easy to fix, but the missing `aicdb.h' and
more over the other errors (previously defined and type mismatch) are
difficult for me.

Thanks
-- 
Emmanuel

The most important thing in the programming language is the name.
A language will not succeed without a good name. I have recently
invented a very good name and now I am looking for a suitable language.
     -- Donald Knuth



