Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSF3XD0>; Sun, 30 Jun 2002 19:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSF3XD0>; Sun, 30 Jun 2002 19:03:26 -0400
Received: from jalon.able.es ([212.97.163.2]:50423 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S314396AbSF3XDZ>;
	Sun, 30 Jun 2002 19:03:25 -0400
Date: Mon, 1 Jul 2002 01:05:44 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc1aa1
Message-ID: <20020630230544.GA1766@werewolf.able.es>
References: <20020629023459.GA1531@inspiron.ols.wavesec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020629023459.GA1531@inspiron.ols.wavesec.org>; from andrea@suse.de on Sat, Jun 29, 2002 at 04:35:00 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.06.29 Andrea Arcangeli wrote:
>Only booted it on the laptop so far.
>
>URL:
>
>	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc1aa1.gz
>	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc1aa1/
>

Booted ? 

werewolf:/usr/src/linux# make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.4.19-rc1-jam1/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
-: 235: incorrect argument
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.19-rc1-jam1/scripts'
make: *** [xconfig] Error 2

This is the problem:

                            !!
+if [ "$CONFIG_X86_TSC_CPU" == "y" -a "$CONFIG_MULTIQUAD" != "y" ]; then
                            !!
+   define_bool CONFIG_X86_TSC y 


-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc1-jam0, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.6mdk)
