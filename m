Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264180AbTEGTVE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264209AbTEGTVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:21:04 -0400
Received: from smtp3.libero.it ([193.70.192.127]:30962 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id S264180AbTEGTUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:20:05 -0400
Date: Wed, 7 May 2003 18:35:54 +0300
To: Miles Lane <miles.lane@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 -- drivers/macintosh/adbhid.c:137: too many arguments to function `adbhid_input_keycode'
Message-ID: <20030507153554.GB344@libero.it>
References: <3EB86F31.3090301@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB86F31.3090301@attbi.com>
User-Agent: Mutt/1.3.28i
From: Daniele Pala <dandario@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think i fixed this one...look for the patch in the list. Sorry, i sent it just before noticing your post T_T

Regards
		Daniele Pala






On Tue, May 06, 2003 at 07:28:01PM -0700, Miles Lane wrote:
> Gnu C                  3.2.2
> Gnu make               3.80
> util-linux             2.11x
> mount                  2.11x
> module-init-tools      0.9.11a
> e2fsprogs              1.32
> pcmcia-cs              3.2.3
> PPP                    2.4.1
> Linux C Library        2.3.1
> Dynamic linker (ldd)   2.3.1
> Procps                 3.1.6
> Net-tools              1.60
> Console-tools          0.2.3
> Sh-utils               4.5.7
> 
> #
> # Macintosh device drivers
> #
> CONFIG_ADB_CUDA=y
> CONFIG_ADB_PMU=y
> CONFIG_PMAC_PBOOK=y
> CONFIG_PMAC_APM_EMU=y
> CONFIG_PMAC_BACKLIGHT=y
> # CONFIG_MAC_FLOPPY is not set
> # CONFIG_MAC_SERIAL is not set
> CONFIG_ADB=y
> CONFIG_ADB_MACIO=y
> CONFIG_INPUT_ADBHID=y
> CONFIG_MAC_EMUMOUSEBTN=y
> # CONFIG_ANSLCD is not set
> 
>   gcc -Wp,-MD,drivers/macintosh/.adbhid.o.d -D__KERNEL__ -Iinclude 
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
> -fno-common -Iarch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized 
> -mmultiple -mstring -fomit-frame-pointer -nostdinc -iwithprefix include 
>    -DKBUILD_BASENAME=adbhid -DKBUILD_MODNAME=adbhid -c -o 
> drivers/macintosh/adbhid.o drivers/macintosh/adbhid.c
> drivers/macintosh/adbhid.c: In function `adbhid_keyboard_input':
> drivers/macintosh/adbhid.c:137: too many arguments to function 
> `adbhid_input_keycode'
> drivers/macintosh/adbhid.c:139: too many arguments to function 
> `adbhid_input_keycode'
> drivers/macintosh/adbhid.c: At top level:
> drivers/macintosh/adbhid.c:143: parse error before "pt_regs"
> drivers/macintosh/adbhid.c: In function `adbhid_input_keycode':
> drivers/macintosh/adbhid.c:144: number of arguments doesn't match prototype
> drivers/macintosh/adbhid.c:87: prototype declaration
> drivers/macintosh/adbhid.c:147: `keycode' undeclared (first use in this 
> function)
> drivers/macintosh/adbhid.c:147: (Each undeclared identifier is reported 
> only once
> drivers/macintosh/adbhid.c:147: for each function it appears in.)
> drivers/macintosh/adbhid.c:152: `id' undeclared (first use in this function)
> drivers/macintosh/adbhid.c:152: `regs' undeclared (first use in this 
> function)
> make[2]: *** [drivers/macintosh/adbhid.o] Error 1
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
