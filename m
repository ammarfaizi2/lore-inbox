Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261489AbREQSvJ>; Thu, 17 May 2001 14:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbREQSu7>; Thu, 17 May 2001 14:50:59 -0400
Received: from web13703.mail.yahoo.com ([216.136.175.136]:56849 "HELO
	web13703.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261489AbREQSur>; Thu, 17 May 2001 14:50:47 -0400
Message-ID: <20010517185046.353.qmail@web13703.mail.yahoo.com>
Date: Thu, 17 May 2001 20:50:46 +0200 (CEST)
From: =?iso-8859-1?q?Joel=20Cordonnier?= <jocordonnier@yahoo.fr>
Subject: newbie problem: compiling kernel 2.4.4, make modules_install , Help please !
To: linux-kernel@vger.kernel.org
In-Reply-To: <20010517183832Z261485-1105+1620@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

It's the first time that i try to compile my own
kernel. At the moment, I have an old RH 6.1 with a
2.2.12 kernel.

I have downloaded the latest stable kernel 2.4.4
tar.gz kernel.

I follow these steps:
- make xonfig (a give what i need)
- make dep (for dependencies)
- make bzImage.
All seems OK for these steps.

Then 
- make modules and 
- make modules_install ==> PROBLEM !

FIRST the message say that no argument -F exist for
the command /sbin/depmod. So I change in the Makefile
the call 
if [ -r System.map ]; then /sbin/depmod -ae -F
System.map  2.4.4; fi
TO
if [ -r System.map ]; then /sbin/depmod -ae System.map
 2.4.4; fi

AFTER THIS CHANGE, i have the following error:

........
.......
make[1]: Entering directory
`/usr/src/linux-2.4.4/arch/i386/mm'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory
`/usr/src/linux-2.4.4/arch/i386/mm'
make -C  arch/i386/lib modules_install
make[1]: Entering directory
`/usr/src/linux-2.4.4/arch/i386/lib'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory
`/usr/src/linux-2.4.4/arch/i386/lib'
cd /lib/modules/2.4.4; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i
-r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae System.map
 2.4.4; fi
can't open /lib/modules/System.map/modules.dep

I check, and there is no file or directory named
/lib/modules/System.map or directory!


Help please !
Thanks
Joel






___________________________________________________________
Do You Yahoo!? -- Pour faire vos courses sur le Net, 
Yahoo! Shopping : http://fr.shopping.yahoo.com
