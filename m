Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316339AbSGVW51>; Mon, 22 Jul 2002 18:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317648AbSGVW51>; Mon, 22 Jul 2002 18:57:27 -0400
Received: from draco.netpower.no ([212.33.133.34]:52234 "EHLO
	draco.netpower.no") by vger.kernel.org with ESMTP
	id <S316339AbSGVW50>; Mon, 22 Jul 2002 18:57:26 -0400
Date: Tue, 23 Jul 2002 01:00:30 +0200
From: Erlend Aasland <erlend-a@innova.no>
To: Diego Calleja <diegocg@teleline.es>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Compile error 2.5.27: [ad1848_lib.o] Error 1
Message-ID: <20020723010030.A14440@innova.no>
References: <20020722233021.4713583a.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020722233021.4713583a.diegocg@teleline.es>; from diegocg@teleline.es on Mon, Jul 22, 2002 at 11:30:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Does this patch make it compile?

--- clean/sound/isa/ad1848/ad1848_lib.c	2002-07-06 01:42:22.000000000 +0200
+++ dirty/sound/isa/ad1848/ad1848_lib.c	2002-07-10 04:50:20.000000000 +0200
@@ -24,6 +24,7 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <linux/delay.h>
+#include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <sound/core.h>


Regards,
	Erlend Aasland

On Mon, Jul 22, 2002 at 11:30:21PM +0200, Diego Calleja wrote:
> make[2]: Entering directory `/usr/src/unstable/sound/isa'
> make[3]: Entering directory `/usr/src/unstable/sound/isa/ad1816a'
> make[3]: Leaving directory `/usr/src/unstable/sound/isa/ad1816a'
> make[3]: Entering directory `/usr/src/unstable/sound/isa/ad1848'
>   gcc -Wp,-MD,./.ad1848_lib.o.d -D__KERNEL__ -I/usr/src/unstable/include
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i586 -nostdinc -iwithprefix include -DMODULE  
> -DKBUILD_BASENAME=ad1848_lib -DEXPORT_SYMTAB  -c -o ad1848_lib.o
> ad1848_lib.c ad1848_lib.c:1171: parse error before `alsa_ad1848_init'
> ad1848_lib.c:1172: warning: return-type defaults to `int'
> ad1848_lib.c:1176: parse error before `alsa_ad1848_exit'
> ad1848_lib.c:1177: warning: return-type defaults to `int'
> ad1848_lib.c: In function `alsa_ad1848_exit':
> ad1848_lib.c:1178: warning: control reaches end of non-void function
> ad1848_lib.c: At top level:
> ad1848_lib.c:1181: parse error before `module_exit'
> ad1848_lib.c:1182: parse error at end of input
> make[3]: *** [ad1848_lib.o] Error 1
> make[3]: Leaving directory `/usr/src/unstable/sound/isa/ad1848'
> make[2]: *** [ad1848] Error 2
> make[2]: Leaving directory `/usr/src/unstable/sound/isa'
> make[1]: *** [isa] Error 2
> make[1]: Leaving directory `/usr/src/unstable/sound'
> make: *** [sound] Error 2
> root@diego:/usr/src/unstable#
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
