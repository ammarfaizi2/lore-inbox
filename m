Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264862AbTGBJMo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 05:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264864AbTGBJMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 05:12:44 -0400
Received: from web11805.mail.yahoo.com ([216.136.172.159]:41309 "HELO
	web11805.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264862AbTGBJMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 05:12:43 -0400
Message-ID: <20030702092707.24387.qmail@web11805.mail.yahoo.com>
Date: Wed, 2 Jul 2003 11:27:07 +0200 (CEST)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: Re: [PATCH RFC] 2.5.73 zlib #1 memmove
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

  I do not know if you are interrested, but I already did
 a lot work on zlib/gzlib in Gujin:
http://gujin.sourceforge.net/

 There is a near complete rewrite of zlib, even removing the
 32Kb window stuff. Unlike zlib, it is only licenced as GPL, and only
 tested on i386, in fact 32 bit processors. An unusual CRC32 function
 is also available, optimised to i386 instructions but without a table
 to reduce the data cache page misses and code size.

 Have a look at gzcopy.c:
gzcopy -t infile.gz    -> test the content of the file (-t0 for quite).

 The kind of testing done is in Makefile:
testgzlib: gzcopy
        find /mnt/cdrom/ -name "*.tgz" -o -name "*.gz" \
                -exec ./gzcopy -t {} \; 2>&1 | tee log

 I did it on multi CDROMs collection like ftp.cdrom.com , it checks
 all files CRC32 - the only failure were unreadable files on the device
 and file not compressed by GZIP (GZIP can decompress .Z and .ZIP files)
 even if someone changed their name to *.gz

 My aim there was code size reduction (4-5 Kbytes of code total).
 It does compile and work with GCC aliasing optimisation.

  Cheers,
  Etienne.

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
