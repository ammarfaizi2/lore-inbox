Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314082AbSFELt2>; Wed, 5 Jun 2002 07:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315335AbSFELt1>; Wed, 5 Jun 2002 07:49:27 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:23468 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S314082AbSFELtZ>; Wed, 5 Jun 2002 07:49:25 -0400
Date: Wed, 5 Jun 2002 13:49:45 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: linux-kernel@vger.kernel.org
Subject: -ac series won't compile without fix
Message-Id: <20020605134945.7ad22093.kristian.peters@korseby.net>
X-Mailer: Sylpheed version 0.7.1claws7 (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: i686-redhat-linux 2.4.19-pre10
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'm unable to compile the -ac series correctly.  A "make mrproper" does not help here.

$ make bzImage
make -r -f tmp_include_depends all
make[1]: Entering directory `/usr/src/linux-2.4.19-pre10-ac1'
make[1]: *** No rule to make target `/usr/src/linux-2.4.19-pre10-ac1/fs/inflate_fs/infblock.h', needed by `/usr/src/linux-2.4.19-pre10-ac1/fs/inflate_fs/infcodes.h'.  Stop.
make[1]: Leaving directory `/usr/src/linux-2.4.19-pre10-ac1'
make: *** [tmp_include_depends] Error 2



It seems that 3 files are missing in the dir "fs/inflate_fs/". When I symlink them, it would compile correctly:

cd /usr/src/linux-2.4.19-pre10-ac1
cd /fs/inflate_fs
ln -s ../../lib/zlib_inflate/infblock.h .
ln -s ../../lib/zlib_inflate/infcodes.h .
ln -s ../../lib/zlib_inflate/inftrees.h .

What's wrong here ? I can provide my config but I don't want to spam the list. I already searched the list for this problem without luck.

BTW: This problem is also present in earlier -ac patches.

Thanks, *Kristian

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 :: http://gsmp.sf.net         _\_V
  :.........................:
