Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274064AbRIXRQQ>; Mon, 24 Sep 2001 13:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274054AbRIXRQM>; Mon, 24 Sep 2001 13:16:12 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:10884
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S274055AbRIXRP6>; Mon, 24 Sep 2001 13:15:58 -0400
Date: Mon, 24 Sep 2001 10:16:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.10
Message-ID: <20010924101602.A25956@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <3BAECC4F.EF25393@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BAECC4F.EF25393@zip.com.au>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2001 at 11:01:51PM -0700, Andrew Morton wrote:

> An ext3 patch against linux 2.4.10 is at
> 
> 	http://www.uow.edu.au/~andrewm/linux/ext3/
> 
> This patch is *lightly tested* - ie, it boots and does stuff.
> The changes to ext3 are small, but the kernel which it patches
> has recently changed a lot.  If you're cautious, please wait
> a couple of days.

This doesn't  compile for me:
gcc -D__KERNEL__ -I/home/trini/work/kernel/testing/linuxppc_2_4_devel/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring    -DEXPORT_SYMTAB -c jbd-kernel.c
jbd-kernel.c: In function `b_list_to_string':
jbd-kernel.c:209: `BUF_PROTECTED' undeclared (first use in this function)
jbd-kernel.c:209: (Each undeclared identifier is reported only once
jbd-kernel.c:209: for each function it appears in.)
make[3]: *** [jbd-kernel.o] Error 1
make[3]: Leaving directory `/home/trini/work/kernel/testing/linuxppc_2_4_devel/fs'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/home/trini/work/kernel/testing/linuxppc_2_4_devel/fs'
make[1]: *** [_dir_fs] Error 2
make[1]: Leaving directory `/home/trini/work/kernel/testing/linuxppc_2_4_devel'
$ grep BUF_PROTECTED ext3-2.4-0.9.10-2410 
+       case BUF_PROTECTED:     return "BUF_PROTECTED";
$ less .config
...
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_BUFFER_DEBUG=y

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
