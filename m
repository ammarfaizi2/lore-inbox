Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWEAUh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWEAUh5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 16:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWEAUh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 16:37:57 -0400
Received: from orfeus.profiwh.com ([82.100.20.117]:26118 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S932238AbWEAUh4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 16:37:56 -0400
Message-ID: <445671B4.2000902@gmail.com>
Date: Mon, 01 May 2006 22:37:49 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc2-mm1 compiling problems
References: <44515A27.1060703@gmail.com> <44515CCF.7040100@gmail.com> <Pine.LNX.4.64.0605012131240.32445@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0605012131240.32445@scrub.home>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Roman Zippel napsal(a):
> Hi,
> 
> On Fri, 28 Apr 2006, Jiri Slaby wrote:
> 
>> Jiri Slaby napsal(a):
>>> Hello,
>>>
>>> I have problems with compiling 2.6.17-rc2-mm1 and 2.6.17-rc1-mm3:
>>> $ make O=../my V=1
>>> make -C /l/latest/my \
>>> KBUILD_SRC=/l/latest/xxx \
>>> KBUILD_EXTMOD="" -f /l/latest/xxx/Makefile _all
>>> make -f /l/latest/xxx/Makefile silentoldconfig
>>> make -f /l/latest/xxx/scripts/Makefile.build obj=scripts/basic
>>> if test ! /l/latest/xxx -ef /l/latest/my; then \
>>> /bin/sh /l/latest/xxx/scripts/mkmakefile              \
>>>     /l/latest/xxx /l/latest/my 2 6         \
>>>     > /l/latest/my/Makefile;                                 \
>>>     echo '  GEN    /l/latest/my/Makefile';                   \
>>> fi
>>>   GEN    /l/latest/my/Makefile
>>> mkdir -p include/linux include/config
>>> make -f /l/latest/xxx/scripts/Makefile.build obj=scripts/kconfig silentoldconfig
>>> scripts/kconfig/conf -s arch/i386/Kconfig
>>> init/Kconfig:3: unknown option "option"
>>> make[3]: *** [silentoldconfig] Error 1
>>> make[2]: *** [silentoldconfig] Error 2
>>> make[1]: *** [include/config/auto.conf] Error 2
>>> make: *** [_all] Error 2
>>>
>>> Then, when I delete the line, there is another problem:
> 
> It's unlikely the problem, did anything special happen before (e.g. disk 
> full or other errors)?
> I cannot reproduce this, can you reproduce this with a clean 
> source/object dir?
Nope, my bad. I diffed two -mm trees on remote machine with:
diff -NrupX b/Documentation/dontdiff a b|'bzip it and send me a copy'
but dontdiff contains files, that _should_ be diffed, gensyms and mmu stuff
included, so I was not able to compile it and even if I downloaded and untarred
fresh, clean archive and diffed with '-X dontdiff' flag to my working tree,
there was no difference, so I didn't get it. I understood after omitting -X
flag, when I see kilobytes of differencies.
So, sorry for the noise.

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEVnG0MsxVwznUen4RAhSvAKCCBD4wnyAt5CQnmxBUdWiJdqYJ6wCfcZCX
ScI2vtZvMn78bUjmHMHSvBM=
=uL7E
-----END PGP SIGNATURE-----
