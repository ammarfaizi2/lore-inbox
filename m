Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267765AbTADBQZ>; Fri, 3 Jan 2003 20:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267767AbTADBQY>; Fri, 3 Jan 2003 20:16:24 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:32970 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S267765AbTADBQX>; Fri, 3 Jan 2003 20:16:23 -0500
Date: Sat, 04 Jan 2003 14:24:46 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: "James H. Cloos Jr." <cloos@jhcloos.com>, linux-kernel@vger.kernel.org,
       derek@indranet.co.nz
Subject: Re: build failure 2.5.54+
Message-ID: <76180000.1041643486@localhost.localdomain>
In-Reply-To: <m3bs2xu3db.fsf@lugabout.jhcloos.org>
References: <m3bs2xu3db.fsf@lugabout.jhcloos.org>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of our developers (Derek Smithies, derek@indranet.co.nz) has been 
overhauling ixj anyway, with access to all the info Quicknet could provide 
him on the hardware, and he's got a driver that uses about half as many 
cycles and 2/3 the memory to get far better sound quality.  But his driver 
won't compile any more either, for the same reason, so if someone can fix 
that, we'll get the new version submitted with the compilation fix included.

Derek's on holiday till about the 14th.

Andrew

--On Friday, January 03, 2003 20:10:08 -0500 "James H. Cloos Jr." 
<cloos@jhcloos.com> wrote:

> Sometime between the csets
>
>     rddunlap@osdl.org|ChangeSet|20021218224440|38837
>
> and
>
>     sfr@canb.auug.org.au|ChangeSet|20030103190613|05701
>
> compilation of ixj.ko broke.
>
> (That is OTOO 520 csets of difference; I didn't try a compile during
> the 2.5.53 timeframe.)
>
> It looks isapnp related:
>
> make -f scripts/Makefile.build obj=drivers/telephony
>    rm -f drivers/telephony/built-in.o; ar rcs drivers/telephony/built-in.o
>   gcc -Wp,-MD,drivers/telephony/.phonedev.o.d -D__KERNEL__ -Iinclude
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686
> -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE
> -DKBUILD_BASENAME=phonedev -DKBUILD_MODNAME=phonedev -DEXPORT_SYMTAB  -c
> -o drivers/telephony/phonedev.o drivers/telephony/phonedev.c   ld -m
> elf_i386  -r -o drivers/telephony/phonedev.ko drivers/telephony/phonedev.o
>   gcc -Wp,-MD,drivers/telephony/.ixj.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=i686
> -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE
> -DKBUILD_BASENAME=ixj -DKBUILD_MODNAME=ixj -DEXPORT_SYMTAB  -c -o
> drivers/telephony/ixj.o drivers/telephony/ixj.c drivers/telephony/ixj.c:
> In function `cleanup':
> drivers/telephony/ixj.c:7581: structure has no member named `deactivate'
> drivers/telephony/ixj.c:7582: structure has no member named `deactivate'
> drivers/telephony/ixj.c: In function `ixj_probe_isapnp':
> drivers/telephony/ixj.c:7715: warning: implicit declaration of function
> `isapnp_find_dev' drivers/telephony/ixj.c:7716: warning: assignment makes
> pointer from integer without a cast drivers/telephony/ixj.c:7719:
> structure has no member named `prepare' drivers/telephony/ixj.c:7731:
> structure has no member named `activate' drivers/telephony/ixj.c:7762:
> structure has no member named `serial' drivers/telephony/ixj.c:7712:
> warning: `result' might be used uninitialized in this function make[2]:
> *** [drivers/telephony/ixj.o] Error 1
> make[1]: *** [drivers/telephony] Error 2
> make: *** [drivers] Error 2
>
> (I'd try w/o ISAPNP, but the last time I did, I ended up w/o a working
> kb or mouse....)
>
> -JimC
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


