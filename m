Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTIHNQE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 09:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbTIHNQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 09:16:04 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:29658 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261539AbTIHNQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 09:16:00 -0400
Date: Mon, 8 Sep 2003 15:15:56 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Ottavio Campana <ottavio@campana.vi.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.22 compile error
Message-ID: <20030908131556.GB25325@DUK2.13thfloor.at>
Mail-Followup-To: Ottavio Campana <ottavio@campana.vi.it>,
	linux-kernel@vger.kernel.org
References: <20030908084036.GA30850@campana.vi.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908084036.GA30850@campana.vi.it>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 10:40:36AM +0200, Ottavio Campana wrote:
> I just downloaded  linux 2.4.22 and applied the  following patches: xfs,
> i2c 2.8.0 and lm_sensors 2.8.0 .
> 
> The kernel is failing to compile, here's the error:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.22/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
> -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 
> -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.22/include/linux/modversions.h
> -nostdinc -iwithprefix include -DKBUILD_BASENAME=bttv_if  -DEXPORT_SYMTAB 
> -c bttv-if.c
> bttv-if.c:244: unknown field `inc_use' specified in initializer
> bttv-if.c:244: warning: initialization from incompatible pointer type
> bttv-if.c:245: unknown field `dec_use' specified in initializer
> bttv-if.c:245: warning: missing braces around initializer
> bttv-if.c:245: warning: (near initialization for `bttv_i2c_adap_template.name')
> bttv-if.c:245: warning: initialization makes integer from pointer without a cast
> bttv-if.c:245: initializer element is not computable at load time
> bttv-if.c:245: (near initialization for `bttv_i2c_adap_template.name[0]')
> bttv-if.c:246: unknown field `name' specified in initializer
> bttv-if.c:246: warning: initialization makes integer from pointer without a cast
> bttv-if.c:246: initializer element is not computable at load time
> bttv-if.c:246: (near initialization for `bttv_i2c_adap_template.name[1]')
> bttv-if.c:247: unknown field `id' specified in initializer
> bttv-if.c:248: unknown field `client_register' specified in initializer
> bttv-if.c:248: warning: initialization makes integer from pointer without a cast
> bttv-if.c:248: initializer element is not computable at load time
> bttv-if.c:248: (near initialization for `bttv_i2c_adap_template.name[3]')
> make[4]: *** [bttv-if.o] Error 1
> make[4]: Leaving directory `/usr/src/linux-2.4.22/drivers/media/video'
> make[3]: *** [_modsubdir_video] Error 2
> make[3]: Leaving directory `/usr/src/linux-2.4.22/drivers/media'
> make[2]: *** [_modsubdir_media] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.4.22/drivers'
> make[1]: *** [_mod_drivers] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.22'
> make: *** [stamp-build] Error 2
> 
> I've given  a look  a bttv-if, but  I can't understand  the error,  so I
> can't help more than this. I'm using gcc 2.95.4 .
> 
> If you need more  infos can you please cc me, for  I'm not subscribed to
> the list?

at least the lines of bttv-if.c around 240 would be helpful,
better put the whole tree on the web somewhere ...

best,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
