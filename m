Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291925AbSBATgv>; Fri, 1 Feb 2002 14:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291927AbSBATgl>; Fri, 1 Feb 2002 14:36:41 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:50795 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S291926AbSBATgY>; Fri, 1 Feb 2002 14:36:24 -0500
Date: Thu, 31 Jan 2002 21:44:41 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.3 compile failure
Message-ID: <20020131204441.GA7311@elfie.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <02013119142604.00643@middle-earth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02013119142604.00643@middle-earth.net>
User-Agent: Mutt/1.5.0-hc8-current-20020125i (Linux 2.5.3-pre5-J9 i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jan 31 2002, rudmer wrote:

> make[3]: Entering directory `/usr/src/linux-2.5.3/drivers/base'
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.3/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
> -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4     
> -DEXPORT_SYMTAB -c core.c
> core.c:10: linux/malloc.h: No such file or directory
> make[3]: *** [core.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.5.3/drivers/base'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.5.3/drivers/base'
> make[1]: *** [_subdir_base] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.3/drivers'
> make: *** [_dir_drivers] Error 2

Open "/linux/drivers/base/core.c" and "fs.c" and change

     #include <linux/malloc.h>
     
into
    
     #include <linux/slab.h>
    
and recompile.

-- 
# Heinz Diehl, 68259 Mannheim, Germany
