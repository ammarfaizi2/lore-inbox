Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129281AbQKLMO0>; Sun, 12 Nov 2000 07:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129723AbQKLMOP>; Sun, 12 Nov 2000 07:14:15 -0500
Received: from s340-modem2068.dial.xs4all.nl ([194.109.168.20]:1668 "HELO
	sjoerd.sjoerdnet") by vger.kernel.org with SMTP id <S129281AbQKLMOH>;
	Sun, 12 Nov 2000 07:14:07 -0500
Date: Sun, 12 Nov 2000 13:12:05 +0100 (CET)
From: Arjan Filius <arjan@sjoerd.sjoerdnet>
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11-pre3 doesn't compile (ax25 and md)
In-Reply-To: <200011121149.MAA22970@db0bm.ampr.org>
Message-ID: <Pine.LNX.4.21.0011121308440.5594-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I noticed also md.c doesn't compile (gcc version 2.95.2 )
Here is the (stripped) output from a make -i modules:

make -C md modules
make[2]: Entering directory `/usr/src/linux-2.4.0-test11-pre3/drivers/md'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=k6 -DMODULE -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h   -DEXPORT_SYMTAB -c md.c
In file included from md.c:33:
/usr/src/linux/include/linux/sysctl.h:35: parse error before `size_t'
/usr/src/linux/include/linux/sysctl.h:35: warning: no semicolon at end of struct or union
/usr/src/linux/include/linux/sysctl.h:37: parse error before `newlen'
/usr/src/linux/include/linux/sysctl.h:37: warning: type defaults to `int' in declaration of `newlen'
/usr/src/linux/include/linux/sysctl.h:37: warning: data definition has no type or storage class
/usr/src/linux/include/linux/sysctl.h:39: parse error before `}'
/usr/src/linux/include/linux/sysctl.h:598: syntax error before `long'
/usr/src/linux/include/linux/sysctl.h:604: parse error before `size_t'
/usr/src/linux/include/linux/sysctl.h:606: warning: function declaration isn't a prototype
/usr/src/linux/include/linux/sysctl.h:609: parse error before `size_t'
/usr/src/linux/include/linux/sysctl.h:609: warning: `struct file' declared inside parameter list
/usr/src/linux/include/linux/sysctl.h:609: warning: its scope is only this definition or declaration, which is probably not what you want.
/usr/src/linux/include/linux/sysctl.h:609: warning: function declaration isn't a prototype
/usr/src/linux/include/linux/sysctl.h:612: parse error before `size_t'
/usr/src/linux/include/linux/sysctl.h:612: warning: `struct file' declared inside parameter list
/usr/src/linux/include/linux/sysctl.h:612: warning: function declaration isn't a prototype
/usr/src/linux/include/linux/sysctl.h:614: parse error before `size_t'
/usr/src/linux/include/linux/sysctl.h:614: warning: `struct file' declared inside parameter list
/usr/src/linux/include/linux/sysctl.h:614: warning: function declaration isn't a prototype
/usr/src/linux/include/linux/sysctl.h:616: parse error before `size_t'
/usr/src/linux/include/linux/sysctl.h:616: warning: `struct file' declared inside parameter list
/usr/src/linux/include/linux/sysctl.h:616: warning: function declaration isn't a prototype
/usr/src/linux/include/linux/sysctl.h:618: parse error before `size_t'
/usr/src/linux/include/linux/sysctl.h:618: warning: `struct file' declared inside parameter list
/usr/src/linux/include/linux/sysctl.h:618: warning: function declaration isn't a prototype
/usr/src/linux/include/linux/sysctl.h:620: parse error before `size_t'
/usr/src/linux/include/linux/sysctl.h:620: warning: `struct file' declared inside parameter list
/usr/src/linux/include/linux/sysctl.h:620: warning: function declaration isn't a prototype
/usr/src/linux/include/linux/sysctl.h:622: parse error before `size_t'
/usr/src/linux/include/linux/sysctl.h:622: warning: `struct file' declared inside parameter list
/usr/src/linux/include/linux/sysctl.h:622: warning: function declaration isn't a prototype
/usr/src/linux/include/linux/sysctl.h:624: parse error before `size_t'
/usr/src/linux/include/linux/sysctl.h:624: warning: `struct file' declared inside parameter list
/usr/src/linux/include/linux/sysctl.h:624: warning: function declaration isn't a prototype
/usr/src/linux/include/linux/sysctl.h:627: parse error before `size_t'
/usr/src/linux/include/linux/sysctl.h:628: warning: function declaration isn't a prototype
/usr/src/linux/include/linux/sysctl.h:632: parse error before `size_t'
/usr/src/linux/include/linux/sysctl.h:633: warning: function declaration isn't a prototype
/usr/src/linux/include/linux/sysctl.h:684: parse error before `mode_t'
/usr/src/linux/include/linux/sysctl.h:684: warning: no semicolon at end of struct or union
/usr/src/linux/include/linux/sysctl.h:686: `proc_handler' redeclared as different kind of symbol
/usr/src/linux/include/linux/sysctl.h:609: previous declaration of `proc_handler'
/usr/src/linux/include/linux/sysctl.h:691: parse error before `}'
md.c:83: elements of array `raid_table' have incomplete type
md.c:84: warning: excess elements in struct initializer
md.c:84: warning: (near initialization for `raid_table[0]')
md.c:84: warning: excess elements in struct initializer
md.c:84: warning: (near initialization for `raid_table[0]')
md.c:85: warning: excess elements in struct initializer
md.c:85: warning: (near initialization for `raid_table[0]')
md.c:85: warning: excess elements in struct initializer
md.c:85: warning: (near initialization for `raid_table[0]')
md.c:85: warning: excess elements in struct initializer
md.c:85: warning: (near initialization for `raid_table[0]')
md.c:85: warning: excess elements in struct initializer
md.c:85: warning: (near initialization for `raid_table[0]')
md.c:85: warning: excess elements in struct initializer
md.c:85: warning: (near initialization for `raid_table[0]')
md.c:86: warning: excess elements in struct initializer
md.c:86: warning: (near initialization for `raid_table[1]')
md.c:86: warning: excess elements in struct initializer
md.c:86: warning: (near initialization for `raid_table[1]')
md.c:87: warning: excess elements in struct initializer
md.c:87: warning: (near initialization for `raid_table[1]')
md.c:87: warning: excess elements in struct initializer
md.c:87: warning: (near initialization for `raid_table[1]')
md.c:87: warning: excess elements in struct initializer
md.c:87: warning: (near initialization for `raid_table[1]')
md.c:87: warning: excess elements in struct initializer
md.c:87: warning: (near initialization for `raid_table[1]')
md.c:87: warning: excess elements in struct initializer
md.c:87: warning: (near initialization for `raid_table[1]')
md.c:88: warning: excess elements in struct initializer
md.c:88: warning: (near initialization for `raid_table[2]')
md.c:89: invalid use of undefined type `struct ctl_table'
md.c:91: elements of array `raid_dir_table' have incomplete type
md.c:92: warning: excess elements in struct initializer
md.c:92: warning: (near initialization for `raid_dir_table[0]')
md.c:92: warning: excess elements in struct initializer
md.c:92: warning: (near initialization for `raid_dir_table[0]')
md.c:92: warning: excess elements in struct initializer
md.c:92: warning: (near initialization for `raid_dir_table[0]')
md.c:92: warning: excess elements in struct initializer
md.c:92: warning: (near initialization for `raid_dir_table[0]')
md.c:92: warning: excess elements in struct initializer
md.c:92: warning: (near initialization for `raid_dir_table[0]')
md.c:92: warning: excess elements in struct initializer
md.c:92: warning: (near initialization for `raid_dir_table[0]')
md.c:93: warning: excess elements in struct initializer
md.c:93: warning: (near initialization for `raid_dir_table[1]')
md.c:94: invalid use of undefined type `struct ctl_table'
md.c:96: elements of array `raid_root_table' have incomplete type
md.c:97: warning: excess elements in struct initializer
md.c:97: warning: (near initialization for `raid_root_table[0]')
md.c:97: warning: excess elements in struct initializer
md.c:97: warning: (near initialization for `raid_root_table[0]')
md.c:97: warning: excess elements in struct initializer
md.c:97: warning: (near initialization for `raid_root_table[0]')
md.c:97: warning: excess elements in struct initializer
md.c:97: warning: (near initialization for `raid_root_table[0]')
md.c:97: warning: excess elements in struct initializer
md.c:97: warning: (near initialization for `raid_root_table[0]')
md.c:97: warning: excess elements in struct initializer
md.c:97: warning: (near initialization for `raid_root_table[0]')
md.c:98: warning: excess elements in struct initializer
md.c:98: warning: (near initialization for `raid_root_table[1]')
md.c:99: invalid use of undefined type `struct ctl_table'
make[2]: [md.o] Error 1 (ignored)
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=k6 -DMODULE -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h   -DEXPORT_SYMTAB -c xor.c
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11-pre3/drivers/md'


make -C ax25 modules
make[2]: Entering directory `/usr/src/linux-2.4.0-test11-pre3/net/ax25'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=k6 -DMODULE -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h   -c -o sysctl_net_ax25.o sysctl_net_ax25.c
sysctl_net_ax25.c: In function `ax25_register_sysctl':
sysctl_net_ax25.c:117: warning: left-hand operand of comma expression has no effect
sysctl_net_ax25.c:117: parse error before `;'
make[2]: [sysctl_net_ax25.o] Error 1 (ignored)
rm -f ax25.o
ld -m elf_i386  -r -o ax25.o af_ax25.o ax25_addr.o ax25_dev.o ax25_iface.o ax25_in.o ax25_ip.o ax25_out.o ax25_route.o ax25_std_in.o ax25_std_subr.o ax25_std_timer.o ax25_subr.o ax25_timer.o ax25_uid.o ax25_ds_in.o ax25_ds_subr.o ax25_ds_timer.o sysctl_net_ax25.o
ld: cannot open sysctl_net_ax25.o: No such file or directory
make[2]: [ax25.o] Error 1 (ignored)
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11-pre3/net/ax25'


Greatings,

Arjan Filius
mailto:iafilius@xs4all.nl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
