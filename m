Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTJBWN1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 18:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbTJBWN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 18:13:26 -0400
Received: from [212.97.163.22] ([212.97.163.22]:11505 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263522AbTJBWNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 18:13:24 -0400
Date: Fri, 3 Oct 2003 00:13:12 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre6
Message-ID: <20031002221312.GA4778@werewolf.able.es>
References: <Pine.LNX.4.44.0310011434400.6488-100000@dmt.cyclades>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0310011434400.6488-100000@dmt.cyclades> (from marcelo.tosatti@cyclades.com on Wed, Oct 01, 2003 at 19:44:18 +0200)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10.01, Marcelo Tosatti wrote:
> 
> Hi,
> 
> Here goes -pre6. 
> 

make xconfig is broken:

werewolf:/usr/src/linux-2.4.22-pre6# make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.4.22-pre6/scripts'
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkparse.o tkparse.c
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkcond.o tkcond.c
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkgen.o tkgen.c
gcc -o tkparse tkparse.o tkcond.o tkgen.o
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
make[1]: *** [kconfig.tk] Error 139
make[1]: Leaving directory `/usr/src/linux-2.4.22-pre6/scripts'
make: *** [xconfig] Error 2

Any way to get more info ? Some verbose mode for tkparse ?

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre5-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk))
