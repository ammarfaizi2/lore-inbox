Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315223AbSD2WZj>; Mon, 29 Apr 2002 18:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315224AbSD2WZi>; Mon, 29 Apr 2002 18:25:38 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:59379 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S315223AbSD2WZi>; Mon, 29 Apr 2002 18:25:38 -0400
Message-ID: <3CCDC749.9070505@oracle.com>
Date: Tue, 30 Apr 2002 00:20:57 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020326
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.11 breaks snd_printk if SND_VERBOSE_PRINTK = n
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

with CONFIG_SND_VERBOSE_PRINTK = n :

make[4]: Entering directory `/usr/local/src/linux-2.5.11/sound/core/seq/oss'
gcc -D__KERNEL__ -I/usr/local/src/linux-2.5.11/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -DKBUILD_BASENAME=seq_oss  -c -o seq_oss.o seq_oss.c
seq_oss.c:225:17: warning: pasting "(" and "KERN_ERR" does not give a valid preprocessing token
seq_oss.c: In function `register_device':
seq_oss.c:225: `KERN_ERR' undeclared (first use in this function)
seq_oss.c:225: (Each undeclared identifier is reported only once
seq_oss.c:225: for each function it appears in.)
seq_oss.c:225: parse error before string constant
seq_oss.c:233:17: warning: pasting "(" and "KERN_ERR" does not give a valid preprocessing token
seq_oss.c:233: parse error before string constant
seq_oss.c:238:9: warning: pasting "(" and ""device registered\n"" does not give a valid preprocessing token
seq_oss.c:247:9: warning: pasting "(" and ""device unregistered\n"" does not give a valid preprocessing token
seq_oss.c:249:17: warning: pasting "(" and "KERN_ERR" does not give a valid preprocessing token

etc. etc.

Configuring SND_VERBOSE_PRINTK in makes the problem go away.

--alessandro

  "the hands that build / can also pull down
    even the hands of love"
                             (U2, "Exit")

