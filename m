Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289384AbSBBUhq>; Sat, 2 Feb 2002 15:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292381AbSBBUhe>; Sat, 2 Feb 2002 15:37:34 -0500
Received: from [200.240.18.5] ([200.240.18.5]:37646 "EHLO ipanema.inx.com.br")
	by vger.kernel.org with ESMTP id <S289384AbSBBUhV>;
	Sat, 2 Feb 2002 15:37:21 -0500
Message-ID: <3C5C4E00.2080400@cetuc.puc-rio.br>
Date: Sat, 02 Feb 2002 18:37:20 -0200
From: Marcelo Roberto Jimenez <mroberto@cetuc.puc-rio.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.3: Unresolved Symbols in ppp_deflate.o and ufs.o
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having the same problem:

...
make -C  arch/i386/lib modules_install
make[1]: Entering directory 
`/home/mroberto/programs/kernel/2.5.3/plain/linux/arch/i386/lib'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory 
`/home/mroberto/programs/kernel/2.5.3/plain/linux/arch/i386/lib'
cd /lib/modules/2.5.3; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.3; fi
depmod: *** Unresolved symbols in 
/lib/modules/2.5.3/kernel/drivers/net/ppp_deflate.o
depmod:         zlib_inflateIncomp


Regards,

Marcelo.


