Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318752AbSHGSSY>; Wed, 7 Aug 2002 14:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318775AbSHGSSY>; Wed, 7 Aug 2002 14:18:24 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:8431 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318752AbSHGSSX>;
	Wed, 7 Aug 2002 14:18:23 -0400
Date: Wed, 07 Aug 2002 11:20:07 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: "=?BIG5?B?qMy6v7/f?=" <imacat@mail.imacat.idv.tw>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: conflicting types for `xquad_portio' with CONFIG_MULTIQUAD
Message-ID: <69570000.1028744407@flay>
In-Reply-To: <20020808004206.EED0.IMACAT@mail.imacat.idv.tw>
References: <20020808004206.EED0.IMACAT@mail.imacat.idv.tw>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some interesting person changed this recently - I have no idea why.
I sent out a patch by Matt Dobson yesterday - hack the const out of misc.c
It shouldn't be there.

M.

PS. Do you really want CONFIG_MULTIQUAD on? Probably not ... 
but maybe you're just testing things.

--On Thursday, August 08, 2002 00:42:17 +0800 "=?BIG5?B?qMy6v7/f?=" <imacat@mail.imacat.idv.tw> wrote:

> [1.] conflicting types for `xquad_portio' with CONFIG_MULTIQUAD
> [2.] I tried to compile with CONFIG_MULTIQUAD, but it kept saying:
> 
> imacat@cotton /tmp/linux-2.4.19 % make install
> bsetup.s: Assembler messages:
> bsetup.s:1431: Warning: indirect lcall without `*'
> misc.c:128: conflicting types for `xquad_portio'
> /tmp/linux-2.4.19/include/asm/io.h:324: previous declaration of `xquad_portio'
> make[2]: *** [misc.o] Error 1
> make[1]: *** [compressed/bvmlinux] Error 2
> make: *** [install] Error 2
> imacat@cotton /tmp/linux-2.4.19 %
> 
>     I have examined the misc.c and io.h.  There are indeed 2 conflict
> settings on xquad_portio at the specified lines when compiled with
> CONFIG_MULTIQUAD, and misc.c includes io.h.  It should not be working at
> all.  I wonder how other people could compile with CONFIG_MULTIQUAD.
> 
>     I was compiling by the clean default options in "make menuconfig",
> with only the CONFIG_MULTIQUAD turned on.
> 
> [3.] CONFIG_MULTIQUAD, xquad_portio, misc.c, io.h
> [4.] 2.4.19
> [5.] 
> 
> imacat@cotton /tmp/linux-2.4.19 % make install
> bsetup.s: Assembler messages:
> bsetup.s:1431: Warning: indirect lcall without `*'
> misc.c:128: conflicting types for `xquad_portio'
> /tmp/linux-2.4.19/include/asm/io.h:324: previous declaration of `xquad_portio'
> make[2]: *** [misc.o] Error 1
> make[1]: *** [compressed/bvmlinux] Error 2
> make: *** [install] Error 2
> imacat@cotton /tmp/linux-2.4.19 %
> 
> [6.] N/A
> [7.] Environment
> [7.1.] Red Hat 7.3, gcc 3.1, glibc 2.2.5
> [7.2.] AMD 1800+
> [7.3.] none
> [X.] none
> 
> 
> --
> Best regards,
> imacat ^_*'
> imacat@mail.imacat.idv.tw
> PGP Key: http://www.imacat.idv.tw/me/pgpkey.txt
> 
> <<Woman's Voice>> News: http://www.wov.idv.tw/
> Tavern IMACAT's: http://www.imacat.idv.tw/
> TLUG List Manager: http://www.linux.org.tw/mailman/listinfo/tlug


