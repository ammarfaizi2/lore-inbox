Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267494AbSLNBld>; Fri, 13 Dec 2002 20:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267497AbSLNBlc>; Fri, 13 Dec 2002 20:41:32 -0500
Received: from dp.samba.org ([66.70.73.150]:36314 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267494AbSLNBlb>;
	Fri, 13 Dec 2002 20:41:31 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
Cc: adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: Not able to compile modutils-2.4.21-7.src.rpm 
In-reply-to: Your message of "Sat, 14 Dec 2002 08:09:43 +0800."
             <20021214000944.30118.qmail@linuxmail.org> 
Date: Sat, 14 Dec 2002 12:27:34 +1100
Message-Id: <20021214014915.734112C510@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021214000944.30118.qmail@linuxmail.org> you write:
> Hi Rusty and Adam,
> I send you again this bug report.
> 
> [root@frodo module-init-tools-0.9.3]# rpm --rebuild /mnt/nt/linux/kernel/modu
les/modutils-2.4.21-7.src.rpm
> 
> gcc -O3 -fomit-frame-pointer -pipe -mcpu=pentiumpro -march=i586 -ffast-math -
fno-strength-reduce -o modinfo modinfo.o ../obj/libobj.a ../util/libutil.a
> gcc -static -O3 -fomit-frame-pointer -pipe -mcpu=pentiumpro -march=i586 -ffas
t-math -fno-strength-reduce -o insmod.static insmod.o rmmod.o modprobe.o lsmod.
o ksyms.o kallsyms.o ../obj/libobj.a ../util/libutil.a
> /usr/bin/ld: cannot find -lc
> collect2: ld returned 1 exit status
> make[1]: *** [insmod.static] Error 1
> make[1]: Leaving directory `/usr/src/RPM/BUILD/modutils-2.4.21/insmod'
> make: *** [all] Error 2
> error: Bad exit status from /var/tmp/rpm-tmp.76637 (%build)

It looks like you don't have the ability to make static binaries.
Does this fail for you, too?

	echo 'int main(){return 0;}' > /tmp/foo.c && gcc -static -o foo foo.c

Perhaps there is some RH devel package you need to install to allow
this to work?

YA Debian User,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
