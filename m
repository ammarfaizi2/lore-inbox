Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274062AbRIXRTg>; Mon, 24 Sep 2001 13:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274054AbRIXRT0>; Mon, 24 Sep 2001 13:19:26 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:11534 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S274052AbRIXRTS>; Mon, 24 Sep 2001 13:19:18 -0400
Message-ID: <3BAF6B32.9E41CD19@zip.com.au>
Date: Mon, 24 Sep 2001 10:19:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.10
In-Reply-To: <3BAECC4F.EF25393@zip.com.au>,
		<3BAECC4F.EF25393@zip.com.au> <20010924101602.A25956@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> 
> On Sun, Sep 23, 2001 at 11:01:51PM -0700, Andrew Morton wrote:
> 
> > An ext3 patch against linux 2.4.10 is at
> >
> >       http://www.uow.edu.au/~andrewm/linux/ext3/
> >
> > This patch is *lightly tested* - ie, it boots and does stuff.
> > The changes to ext3 are small, but the kernel which it patches
> > has recently changed a lot.  If you're cautious, please wait
> > a couple of days.
> 
> This doesn't  compile for me:
> gcc -D__KERNEL__ -I/home/trini/work/kernel/testing/linuxppc_2_4_devel/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring    -DEXPORT_SYMTAB -c jbd-kernel.c
> jbd-kernel.c: In function `b_list_to_string':
> jbd-kernel.c:209: `BUF_PROTECTED' undeclared (first use in this function)

Yes, sorry.  Delete line 209 of jdb-kernel.c, or don't compile with
buffer-debug.
