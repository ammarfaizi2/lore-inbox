Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293347AbSDCI5N>; Wed, 3 Apr 2002 03:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293386AbSDCI4y>; Wed, 3 Apr 2002 03:56:54 -0500
Received: from [24.84.50.235] ([24.84.50.235]:2309 "HELO
	mail.orbis-terrarum.net") by vger.kernel.org with SMTP
	id <S293347AbSDCI4r>; Wed, 3 Apr 2002 03:56:47 -0500
Date: Wed, 3 Apr 2002 00:57:06 -0800 (PST)
From: Robin Johnson <robbat2@fermi.orbis-terrarum.net>
To: linux-kernel@vger.kernel.org
Subject: Bug in compiling
Message-ID: <Pine.LNX.4.43.0204030045510.13140-100000@fermi.orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

While mass compiling a new kernel for my slew of systems, I had an unusual
problem

gcc barfs and gives this huge error:
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-pre4-ac3/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686   -DKBUILD_BASENAME=exec_domain  -DEXPORT_SYMTAB -c
exec_domain.c
exec_domain.c:234: parse error before `register_exec_domain'
exec_domain.c:234: warning: type defaults to `int' in declaration of
`register_exec_domain'
exec_domain.c:234: `register_exec_domain' redeclared as different kind of
symbol
exec_domain.c:113: previous declaration of `register_exec_domain'
exec_domain.c:234: invalid initializer
exec_domain.c:234: warning: data definition has no type or storage class
exec_domain.c:234: parse error before `register_exec_domain'
exec_domain.c:234: warning: type defaults to `int' in declaration of
`register_exec_domain'
exec_domain.c:234: conflicting types for `register_exec_domain'
exec_domain.c:234: previous declaration of `register_exec_domain'
exec_domain.c:234: warning: excess elements in scalar initializer
exec_domain.c:234: warning: (near initialization for
`register_exec_domain')
exec_domain.c:234: parse error before `register_exec_domain'
exec_domain.c:234: warning: data definition has no type or storage class
exec_domain.c:235: parse error before `unregister_exec_domain'
exec_domain.c:235: warning: type defaults to `int' in declaration of
`unregister_exec_domain'
exec_domain.c:235: `unregister_exec_domain' redeclared as different kind
of symbol
exec_domain.c:140: previous declaration of `unregister_exec_domain'
exec_domain.c:235: invalid initializer
exec_domain.c:235: warning: data definition has no type or storage class
exec_domain.c:235: parse error before `unregister_exec_domain'
exec_domain.c:235: warning: type defaults to `int' in declaration of
`unregister_exec_domain'
exec_domain.c:235: conflicting types for `unregister_exec_domain'
exec_domain.c:235: previous declaration of `unregister_exec_domain'
exec_domain.c:235: warning: excess elements in scalar initializer
exec_domain.c:235: warning: (near initialization for
`unregister_exec_domain')
exec_domain.c:235: parse error before `unregister_exec_domain'
exec_domain.c:235: warning: data definition has no type or storage class
exec_domain.c:236: parse error before `__set_personality'
exec_domain.c:236: warning: type defaults to `int' in declaration of
`__set_personality'
exec_domain.c:236: `__set_personality' redeclared as different kind of
symbol
exec_domain.c:161: previous declaration of `__set_personality'
exec_domain.c:236: invalid initializer
exec_domain.c:236: warning: data definition has no type or storage class
exec_domain.c:236: parse error before `__set_personality'
exec_domain.c:236: warning: type defaults to `int' in declaration of
`__set_personality'
exec_domain.c:236: conflicting types for `__set_personality'
exec_domain.c:236: previous declaration of `__set_personality'
exec_domain.c:236: warning: excess elements in scalar initializer
exec_domain.c:236: warning: (near initialization for `__set_personality')
exec_domain.c:236: parse error before `__set_personality'
exec_domain.c:236: warning: data definition has no type or storage class
exec_domain.c:287: parse error before `abi_defhandler_coff'
exec_domain.c:287: warning: type defaults to `int' in declaration of
`abi_defhandler_coff'
exec_domain.c:287: conflicting types for `abi_defhandler_coff'
exec_domain.c:249: previous declaration of `abi_defhandler_coff'
exec_domain.c:287: invalid initializer
exec_domain.c:287: warning: data definition has no type or storage class
exec_domain.c:287: parse error before `abi_defhandler_coff'
exec_domain.c:287: warning: type defaults to `int' in declaration of
`abi_defhandler_coff'
exec_domain.c:287: conflicting types for `abi_defhandler_coff'
exec_domain.c:287: previous declaration of `abi_defhandler_coff'
exec_domain.c:287: warning: excess elements in scalar initializer
exec_domain.c:287: warning: (near initialization for
`abi_defhandler_coff')
exec_domain.c:287: parse error before `abi_defhandler_coff'
exec_domain.c:287: warning: data definition has no type or storage class
exec_domain.c:288: parse error before `abi_defhandler_elf'
exec_domain.c:288: warning: type defaults to `int' in declaration of
`abi_defhandler_elf'
exec_domain.c:288: conflicting types for `abi_defhandler_elf'
exec_domain.c:250: previous declaration of `abi_defhandler_elf'
exec_domain.c:288: invalid initializer
exec_domain.c:288: warning: data definition has no type or storage class
exec_domain.c:288: parse error before `abi_defhandler_elf'
exec_domain.c:288: warning: type defaults to `int' in declaration of
`abi_defhandler_elf'
exec_domain.c:288: conflicting types for `abi_defhandler_elf'
exec_domain.c:288: previous declaration of `abi_defhandler_elf'
exec_domain.c:288: warning: excess elements in scalar initializer
exec_domain.c:288: warning: (near initialization for `abi_defhandler_elf')
exec_domain.c:288: parse error before `abi_defhandler_elf'
exec_domain.c:288: warning: data definition has no type or storage class
exec_domain.c:289: parse error before `abi_defhandler_lcall7'
exec_domain.c:289: warning: type defaults to `int' in declaration of
`abi_defhandler_lcall7'
exec_domain.c:289: conflicting types for `abi_defhandler_lcall7'
exec_domain.c:251: previous declaration of `abi_defhandler_lcall7'
exec_domain.c:289: invalid initializer
exec_domain.c:289: warning: data definition has no type or storage class
exec_domain.c:289: parse error before `abi_defhandler_lcall7'
exec_domain.c:289: warning: type defaults to `int' in declaration of
`abi_defhandler_lcall7'
exec_domain.c:289: conflicting types for `abi_defhandler_lcall7'
exec_domain.c:289: previous declaration of `abi_defhandler_lcall7'
exec_domain.c:289: warning: excess elements in scalar initializer
exec_domain.c:289: warning: (near initialization for
`abi_defhandler_lcall7')
exec_domain.c:289: parse error before `abi_defhandler_lcall7'
exec_domain.c:289: warning: data definition has no type or storage class
exec_domain.c:290: parse error before `abi_defhandler_libcso'
exec_domain.c:290: warning: type defaults to `int' in declaration of
`abi_defhandler_libcso'
exec_domain.c:290: conflicting types for `abi_defhandler_libcso'
exec_domain.c:252: previous declaration of `abi_defhandler_libcso'
exec_domain.c:290: invalid initializer
exec_domain.c:290: warning: data definition has no type or storage class
exec_domain.c:290: parse error before `abi_defhandler_libcso'
exec_domain.c:290: warning: type defaults to `int' in declaration of
`abi_defhandler_libcso'
exec_domain.c:290: conflicting types for `abi_defhandler_libcso'
exec_domain.c:290: previous declaration of `abi_defhandler_libcso'
exec_domain.c:290: warning: excess elements in scalar initializer
exec_domain.c:290: warning: (near initialization for
`abi_defhandler_libcso')
exec_domain.c:290: parse error before `abi_defhandler_libcso'
exec_domain.c:290: warning: data definition has no type or storage class
exec_domain.c:291: parse error before `abi_traceflg'
exec_domain.c:291: warning: type defaults to `int' in declaration of
`abi_traceflg'
exec_domain.c:291: conflicting types for `abi_traceflg'
exec_domain.c:253: previous declaration of `abi_traceflg'
exec_domain.c:291: invalid initializer
exec_domain.c:291: warning: data definition has no type or storage class
exec_domain.c:291: parse error before `abi_traceflg'
exec_domain.c:291: warning: type defaults to `int' in declaration of
`abi_traceflg'
exec_domain.c:291: conflicting types for `abi_traceflg'
exec_domain.c:291: previous declaration of `abi_traceflg'
exec_domain.c:291: warning: excess elements in scalar initializer
exec_domain.c:291: warning: (near initialization for `abi_traceflg')
exec_domain.c:291: parse error before `abi_traceflg'
exec_domain.c:291: warning: data definition has no type or storage class
exec_domain.c:292: parse error before `abi_fake_utsname'
exec_domain.c:292: warning: type defaults to `int' in declaration of
`abi_fake_utsname'
exec_domain.c:292: conflicting types for `abi_fake_utsname'
exec_domain.c:254: previous declaration of `abi_fake_utsname'
exec_domain.c:292: invalid initializer
exec_domain.c:292: warning: data definition has no type or storage class
exec_domain.c:292: parse error before `abi_fake_utsname'
exec_domain.c:292: warning: type defaults to `int' in declaration of
`abi_fake_utsname'
exec_domain.c:292: conflicting types for `abi_fake_utsname'
exec_domain.c:292: previous declaration of `abi_fake_utsname'
exec_domain.c:292: warning: excess elements in scalar initializer
exec_domain.c:292: warning: (near initialization for `abi_fake_utsname')
exec_domain.c:292: parse error before `abi_fake_utsname'
exec_domain.c:292: warning: data definition has no type or storage class
{standard input}: Assembler messages:
{standard input}:691: Error: symbol `register_exec_domain' is already
defined
{standard input}:697: Error: symbol `unregister_exec_domain' is already
defined
{standard input}:703: Error: symbol `__set_personality' is already defined

Now I know the exact source compiled and booted perfectly already. All I
did was tar up my source tree, and copy it to another system. It was on
/root/kern3/linux-2.4.19-pre4-ac3 on the first system, and
/usr/src/linux-2.4.19-pre4-ac3 on the second system. I ran 'make
distclean', copied in the config file, which is almost identical, ran
'make oldconfig dep bzImage'. Then in compiling kernel/exec_domain.c I get
that massive set of error messages that don't make sense at all, as they
have compiled perfectly only 20 minutes before.

Any ideas?

Please CC your replies, as I am not subscrided to the list.

-- 
Robin Hugh Johnson
E-Mail     : robbat2@orbis-terrarum.net
Home Page  : http://www.orbis-terrarum.net/?l=people.robbat2
ICQ#       : 30269588

