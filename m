Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291778AbSBNQo1>; Thu, 14 Feb 2002 11:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291784AbSBNQoS>; Thu, 14 Feb 2002 11:44:18 -0500
Received: from [216.80.8.1] ([216.80.8.1]:8712 "HELO mercury.prairiegroup.com")
	by vger.kernel.org with SMTP id <S291781AbSBNQnG>;
	Thu, 14 Feb 2002 11:43:06 -0500
Message-ID: <3C6BE8F4.9010608@mcwhorter.org>
Date: Thu, 14 Feb 2002 10:42:28 -0600
From: Martin McWhorter <martin@mcwhorter.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [boog] make xconfig broke in 2.5.5pre1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was reported in the 2.5.5pre1 thread but I think it got lost in the 
shuffle. So here we go again...

Martin

[root@m_mcwhorter linux-2.5.5-p1]# make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.5.5-p1/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
sound/Config.in: 22: incorrect argument
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.5-p1/scripts'
make: *** [xconfig] Error 2
[root@m_mcwhorter linux-2.5.5-p1]#

