Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264677AbSIWBnj>; Sun, 22 Sep 2002 21:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264689AbSIWBnj>; Sun, 22 Sep 2002 21:43:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30994 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264677AbSIWBni>;
	Sun, 22 Sep 2002 21:43:38 -0400
Message-ID: <3D8E72DE.6020502@mandrakesoft.com>
Date: Sun, 22 Sep 2002 21:48:14 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] linux kernel conf 0.6
References: <Pine.LNX.4.44.0209221756130.11808-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> On Sun, 22 Sep 2002, Jeff Garzik wrote:
> AFAICS, "quiet" only means the same thing as the traditional "make 
> oldconfig", but suppressing questions where the answers are known. (Which 
> I think is fine)

yeah, that's fine with me too


> I was just referring to the following, which really is not in the subtle 
> change category:
> 
> -------------------------------------------------------------
> [kai@zephyr linux-2.5.make]$ rm .config
> [kai@zephyr linux-2.5.make]$ make
> ***
> *** You have not yet configured your kernel!
> ***
> *** Please run some configurator (e.g. "make oldconfig" or
> *** "make menuconfig" or "make xconfig").
> ***
> make: *** [.config] Error 1
> -------------------------------------------------------------
> 
> whereas lkc changes this to run (the quiet) make oldconfig automatically.

hmmmm, looks like something got broken somewhere, then.

The proper behavior for this example is
	cp arch/$arch/defconfig .config

Do a 'make oldconfig' or 'make config' with no .config, in a 2.4 kernel.

Please fix... :/



> Same thing for 
> 
> -------------------------------------------------------------
> [kai@zephyr linux-2.5.make]$ cp ../config-2.5 .config
> [kai@zephyr linux-2.5.make]$ make
> make[1]: Entering directory 
> `/home/kai/src/kernel/v2.5/linux-2.5.make/scripts'
> make[1]: Leaving directory 
> `/home/kai/src/kernel/v2.5/linux-2.5.make/scripts'
> ***
> *** You changed .config w/o running make *config?
> *** Please run "make oldconfig"
> ***
> -------------------------------------------------------------
> 
> Since people run automated builds, erroring out is IMHO preferable to 
> dropping into interactive mode, which likely happens when you run make 
> oldconfig.

agreed

	Jeff



