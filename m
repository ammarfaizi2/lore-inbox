Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267320AbSLKWJl>; Wed, 11 Dec 2002 17:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267321AbSLKWJl>; Wed, 11 Dec 2002 17:09:41 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:13034 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267320AbSLKWJk>; Wed, 11 Dec 2002 17:09:40 -0500
Message-ID: <3DF7BABF.6080008@wanadoo.fr>
Date: Wed, 11 Dec 2002 23:22:55 +0100
From: abindus@wanadoo.fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: compilation failure
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry for the disturbance as I feel that it's a very simple 
configuration problem but I'm completely stuc with the compilation of 
the kernel. I used to do this without problem but after installing 
RedHat 8.0 nothing is possible. However I'm still able to compile other 
programs in c/c++/gtk+

It seems to complain of not founding some libraries
After the make dep, make bzImage gives (I'm sorry but it's in french) :

make -r -f tmp_include_depends all
make[1]: Entre dans le répertoire `/usr/src/linux-2.4.18-18.8.0'
make[1]: Rien à faire pour `all'.
make[1]: Quitte le répertoire `/usr/src/linux-2.4.18-18.8.0'
. scripts/mkversion > .tmpversion
gcc -D__KERNEL__ -I/usr/src/linux-2.4.18-18.8.0/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4   -DUTS_MACHINE='"i386"' -DKBUILD_BASENAME=version 
-c -o init/version.o init/version.c
cc1: AVERTISSEMENT: -malign-functions est obsolète, utiliser -falign-loops
make CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.18-18.8.0/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4  " -C  kernel
make[1]: Entre dans le répertoire `/usr/src/linux-2.4.18-18.8.0/kernel'
make all_targets
make[2]: Entre dans le répertoire `/usr/src/linux-2.4.18-18.8.0/kernel'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.18-18.8.0/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4    -nostdinc  -DKBUILD_BASENAME=sched  
-fno-omit-frame-pointer -O2 -c -o sched.o sched.c
cc1: AVERTISSEMENT: -malign-functions est obsolète, utiliser -falign-loops
Dans le fichier inclus à partir de 
/usr/src/linux-2.4.18-18.8.0/include/linux/wait.h:13,
          à partir de /usr/src/linux-2.4.18-18.8.0/include/linux/fs.h:12,
          à partir de 
/usr/src/linux-2.4.18-18.8.0/include/linux/capability.h:17,
          à partir de 
/usr/src/linux-2.4.18-18.8.0/include/linux/binfmts.h:5,
          à partir de /usr/src/linux-2.4.18-18.8.0/include/linux/sched.h:9,
          à partir de /usr/src/linux-2.4.18-18.8.0/include/linux/mm.h:4,
          à partir de sched.c:19:
/usr/src/linux-2.4.18-18.8.0/include/linux/kernel.h:10:20: stdarg.h: 
Aucun fichier ou répertoire de ce type
Dans le fichier inclus à partir de 
/usr/src/linux-2.4.18-18.8.0/include/linux/wait.h:13,
          à partir de /usr/src/linux-2.4.18-18.8.0/include/linux/fs.h:12,
          à partir de 
/usr/src/linux-2.4.18-18.8.0/include/linux/capability.h:17,
          à partir de 
/usr/src/linux-2.4.18-18.8.0/include/linux/binfmts.h:5,
          à partir de /usr/src/linux-2.4.18-18.8.0/include/linux/sched.h:9,
          à partir de /usr/src/linux-2.4.18-18.8.0/include/linux/mm.h:4,
          à partir de sched.c:19:
/usr/src/linux-2.4.18-18.8.0/include/linux/kernel.h:73: erreur d'analyse 
syntaxique avant « va_list »
/usr/src/linux-2.4.18-18.8.0/include/linux/kernel.h:73: AVERTISSEMENT: 
déclaration de fonction n'est pas un prototype
/usr/src/linux-2.4.18-18.8.0/include/linux/kernel.h:76: erreur d'analyse 
syntaxique avant « va_list »
/usr/src/linux-2.4.18-18.8.0/include/linux/kernel.h:76: AVERTISSEMENT: 
déclaration de fonction n'est pas un prototype
/usr/src/linux-2.4.18-18.8.0/include/linux/kernel.h:80: erreur d'analyse 
syntaxique avant « va_list »
/usr/src/linux-2.4.18-18.8.0/include/linux/kernel.h:80: AVERTISSEMENT: 
déclaration de fonction n'est pas un prototype
sched.c: Dans la fonction « sys_sched_yield »:
sched.c:1374: AVERTISSEMENT: variable inutilisée « rq »
make[2]: *** [sched.o] Erreur 1
make[2]: Quitte le répertoire `/usr/src/linux-2.4.18-18.8.0/kernel'
make[1]: *** [first_rule] Erreur 2
make[1]: Quitte le répertoire `/usr/src/linux-2.4.18-18.8.0/kernel'
make: *** [_dir_kernel] Erreur 2

Many thanks in advance.

Pascal Bonfils / abindus@wanadoo.fr

