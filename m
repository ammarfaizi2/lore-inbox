Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311239AbSDDHFp>; Thu, 4 Apr 2002 02:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311244AbSDDHFf>; Thu, 4 Apr 2002 02:05:35 -0500
Received: from rj.SGI.COM ([204.94.215.100]:25233 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S311239AbSDDHFZ>;
	Thu, 4 Apr 2002 02:05:25 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Robin Johnson <robbat2@fermi.orbis-terrarum.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in compiling 
In-Reply-To: Your message of "Wed, 03 Apr 2002 21:34:59 PST."
             <Pine.LNX.4.43.0204032116410.25829-100000@fermi.orbis-terrarum.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Apr 2002 17:04:45 +1000
Message-ID: <22591.1017903885@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2002 21:34:59 -0800 (PST), 
Robin Johnson <robbat2@fermi.orbis-terrarum.net> wrote:
>On Wed, 3 Apr 2002, Keith Owens wrote:
>> On Wed, 3 Apr 2002 00:57:06 -0800 (PST),
>> Robin Johnson <robbat2@fermi.orbis-terrarum.net> wrote:
>> >gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-pre4-ac3/include -Wall
>> >-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
>> >-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
>> >-march=i686   -DKBUILD_BASENAME=exec_domain  -DEXPORT_SYMTAB -c
>> >exec_domain.c
>> >exec_domain.c:234: parse error before `register_exec_domain'
>> >exec_domain.c:235: parse error before `unregister_exec_domain'
>> >exec_domain.c:236: parse error before `__set_personality'
>> >exec_domain.c:287: parse error before `abi_defhandler_coff'
>> >...
>>
>> All EXPORT_SYMBOL.  You would get that behaviour if gcc did not
>> recognise EXPORT_SYMBOL as a macro.  Probably random data corruption.
>Of the pair of machines, I upgraded one of them to GCC 3.0.4, while
>leaving the other at 2.95.3.

On the failing system,

cd /usr/src/linux-2.4.19-pre4-ac3/kernel
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-pre4-ac3/include -Wall \
        -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer \
        -fno-strict-aliasing -fno-common -pipe \
        -mpreferred-stack-boundary=2 -march=i686 \
        -DKBUILD_BASENAME=exec_domain -DEXPORT_SYMTAB \
	-E -c exec_domain.c -o exec_domain.i

and send exec_domain.i to kaos@ocs.com.au (not the list).

