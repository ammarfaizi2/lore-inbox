Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265978AbSLNVwL>; Sat, 14 Dec 2002 16:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265987AbSLNVwL>; Sat, 14 Dec 2002 16:52:11 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:27611 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S265978AbSLNVwK>; Sat, 14 Dec 2002 16:52:10 -0500
Date: Sun, 15 Dec 2002 10:34:42 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Rusty Russell <rusty@rustcorp.com.au>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
cc: adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: Not able to compile modutils-2.4.21-7.src.rpm 
Message-ID: <13290000.1039901682@localhost.localdomain>
In-Reply-To: <20021214014915.734112C510@lists.samba.org>
References: <20021214014915.734112C510@lists.samba.org>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, glibc-devel.

Andrew

--On Saturday, December 14, 2002 12:27:34 +1100 Rusty Russell 
<rusty@rustcorp.com.au> wrote:

> In message <20021214000944.30118.qmail@linuxmail.org> you write:
>> Hi Rusty and Adam,
>> I send you again this bug report.
>>
>> [root@frodo module-init-tools-0.9.3]# rpm --rebuild
>> /mnt/nt/linux/kernel/modu
> les/modutils-2.4.21-7.src.rpm
>>
>> gcc -O3 -fomit-frame-pointer -pipe -mcpu=pentiumpro -march=i586
>> -ffast-math -
> fno-strength-reduce -o modinfo modinfo.o ../obj/libobj.a ../util/libutil.a
>> gcc -static -O3 -fomit-frame-pointer -pipe -mcpu=pentiumpro -march=i586
>> -ffas
> t-math -fno-strength-reduce -o insmod.static insmod.o rmmod.o modprobe.o
> lsmod. o ksyms.o kallsyms.o ../obj/libobj.a ../util/libutil.a
>> /usr/bin/ld: cannot find -lc
>> collect2: ld returned 1 exit status
>> make[1]: *** [insmod.static] Error 1
>> make[1]: Leaving directory `/usr/src/RPM/BUILD/modutils-2.4.21/insmod'
>> make: *** [all] Error 2
>> error: Bad exit status from /var/tmp/rpm-tmp.76637 (%build)
>
> It looks like you don't have the ability to make static binaries.
> Does this fail for you, too?
>
> 	echo 'int main(){return 0;}' > /tmp/foo.c && gcc -static -o foo foo.c
>
> Perhaps there is some RH devel package you need to install to allow
> this to work?
>
> YA Debian User,
> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


