Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288525AbSADNcB>; Fri, 4 Jan 2002 08:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288624AbSADNbv>; Fri, 4 Jan 2002 08:31:51 -0500
Received: from mail.spylog.com ([194.67.35.220]:12460 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S288525AbSADNbh>;
	Fri, 4 Jan 2002 08:31:37 -0500
Date: Fri, 4 Jan 2002 16:31:28 +0300
From: Andrey Nekrasov <andy@spylog.ru>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: [bug report] [patch] ultra-scalable O(1) SMP and UP scheduler
Message-ID: <20020104133128.GA1473@spylog.ru>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

2.4.17 + O(1) patch + gcc 2.95.2


...
gcc -D__KERNEL__ -I/usr/src/linux-2.4.17-A0/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i686    -c -o md.o md.c
md.c: In function `md_thread':
md.c:2934: structure has no member named `nice'
md.c: In function `md_do_sync':
md.c:3387: structure has no member named `nice'
md.c:3466: structure has no member named `nice'
md.c:3475: structure has no member named `nice'
make[3]: *** [md.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.17-A0/drivers/md'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.17-A0/drivers/md'
make[1]: *** [_subdir_md] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.17-A0/drivers'
make: *** [_dir_drivers] Error 2
suse:/usr/src/linux # 



-- 
bye.
Andrey Nekrasov, SpyLOG.
