Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261484AbTCGChR>; Thu, 6 Mar 2003 21:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261487AbTCGChR>; Thu, 6 Mar 2003 21:37:17 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:38383 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S261484AbTCGChQ>;
	Thu, 6 Mar 2003 21:37:16 -0500
Date: Fri, 7 Mar 2003 03:47:48 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre5
Message-ID: <20030307024748.GA19320@werewolf.able.es>
References: <Pine.LNX.4.53L.0302270314050.1433@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.53L.0302270314050.1433@freak.distro.conectiva>; from marcelo@conectiva.com.br on Thu, Feb 27, 2003 at 07:14:44 +0100
X-Mailer: Balsa 2.0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.27 07:14, Marcelo Tosatti wrote:
> 
> So here goes -pre5.
> 

define_mbool ?

werewolf:/usr/src/linux# make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.4.21-pre5-jam1/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
drivers/net/Config.in: 188: unknown command
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.21-pre5-jam1/scripts'
make: *** [xconfig] Error 2

Line is:

      if [ "$CONFIG_VISWS" = "y" ]; then
         define_mbool CONFIG_EEPRO100_PIO y
      else

Changed to define_bool, and it works.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre4-jam1 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-1mdk))
