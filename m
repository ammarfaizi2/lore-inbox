Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318210AbSIBTeX>; Mon, 2 Sep 2002 15:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318365AbSIBTeX>; Mon, 2 Sep 2002 15:34:23 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:16591
	"EHLO Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S318210AbSIBTeW>; Mon, 2 Sep 2002 15:34:22 -0400
Date: Mon, 2 Sep 2002 12:38:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Remco Post <r.post@sara.nl>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.33, compile error on powermac
Message-ID: <20020902193841.GG761@opus.bloom.county>
References: <Pine.LNX.4.33.0208311514430.6221-100000@penguin.transmeta.com> <B0754740-BE6F-11D6-9030-000393911DE2@sara.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B0754740-BE6F-11D6-9030-000393911DE2@sara.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 02:29:56PM +0200, Remco Post wrote:

> make[2]: Entering directory `/usr/src/linux-2.5.33/fs/reiserfs'
>   gcc -Wp,-MD,./.resize.o.d -D__KERNEL__ -I/usr/src/linux-2.5.33/include 
> - -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> - -fno-strict-aliasing -fno-common -I/usr/src/linux-2.5.33/arch/ppc 
> - -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized 
> - -mmultiple -mstring -nostdinc -iwithprefix include  -O1  
> - -DKBUILD_BASENAME=resize   -c -o resize.o resize.c
> In file included from resize.c:12:
> /usr/src/linux-2.5.33/include/linux/vmalloc.h:26: parse error before 
> `pgprot_t'
> /usr/src/linux-2.5.33/include/linux/vmalloc.h:26: warning: function 
> declaration isn't a prototype
> /usr/src/linux-2.5.33/include/linux/vmalloc.h:37: parse error before 
> `pgprot_t'
> /usr/src/linux-2.5.33/include/linux/vmalloc.h:38: warning: function 
> declaration isn't a prototype
> make[2]: *** [resize.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.5.33/fs/reiserfs'
> make[1]: *** [reiserfs] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.33/fs'
> make: *** [fs] Error 2

fs/reiserfs/resize.c needs to include <linux/mm.h>, iirc.  Make a patch
and send it to the trivial patch monkey and/or Linus.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
