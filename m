Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262207AbSL2XJi>; Sun, 29 Dec 2002 18:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbSL2XJi>; Sun, 29 Dec 2002 18:09:38 -0500
Received: from smtp02.uc3m.es ([163.117.136.122]:44292 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S262207AbSL2XJh>;
	Sun, 29 Dec 2002 18:09:37 -0500
Date: Mon, 30 Dec 2002 00:17:51 +0100
Message-Id: <200212292317.gBTNHpl04562@oboe.it.uc3m.es>
From: "Peter T. Breuer" <ptb@it.uc3m.es>
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [Patch] Kernel configuration in kernel, kernel 2.4.20
X-Newsgroups: linux.kernel
Cc: linux-kernel@vger.kernel.org
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.15 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021229221340.GA2259@werewolf.able.es> you wrote:

> On 2002.12.29 Paul Rolland wrote:
>> Hello,
>> 
>> Tired of keeping copy of the kernel .config file, I decided to create a kernel
>> patch to have a 
>> /proc/config/config.gz

> Why people does not read the archives before doing anything ?

> http://www.it.uc3m.es/~ptb/proconfig/

Uuumph. Thanks for reminding me. That made me update the page and the
Changelog in a hurry.

It does work for latest 2.4. I ported to 2.4.19 a couple of months ago.
Nowadays it uses string common prefix compression to reduce the
internal size. Probably 4-12K in total (there are a LOT of kernel
compilation params nowadays), but the output from /proc/config
is exactly as it should be.

   Module                  Size  Used by    Not tainted
   config                 10908   0 (unused)


   betty:/usr/oboe/ptb/lib/www/proconfig% cat /proc/config | wc
       855     855   18421

(855 kernel config options, with 18.4K of output chars)

   betty:/usr/oboe/ptb/lib/www/proconfig% head /proc/config
   CONFIG_X86=y
   CONFIG_ISA=y
   CONFIG_UID16=y
   CONFIG_EXPERIMENTAL=y
   CONFIG_MODULES=y
   ...


Now I suppose I need to port it to latest 2.5. Assuming I can compile a
2.5, that is! I haven't tried since 2.5.47, which was before that
modules change.

Peter
