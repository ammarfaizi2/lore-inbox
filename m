Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130300AbQJ0CMH>; Thu, 26 Oct 2000 22:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130521AbQJ0CL6>; Thu, 26 Oct 2000 22:11:58 -0400
Received: from hibernia.clubi.ie ([212.17.32.129]:46987 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S130300AbQJ0CLt>; Thu, 26 Oct 2000 22:11:49 -0400
Date: Fri, 27 Oct 2000 03:16:46 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: test10-pre5: netfilter compile error
Message-ID: <Pine.LNX.4.21.0010270315320.15678-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i get the following when trying to compile netfilter:

ld -m elf_i386  -r -o fs.o filesystems.o open.o read_write.o
devices.o file_table.o buffer.o super.o block_dev.o stat.o exec.o
pipe.o namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o
dcache.o inode.o attr.o bad_inode.o file.o iobuf.o dnotify.o dquot.o
binfmt_script.o binfmt_elf.o proc/proc.o partitions/partitions.o
ext2/ext2.o devfs/devfs.o nls/nls.o devpts/devpts.o
make[2]: Leaving directory `/misc/src/linux/fs'
make[1]: Leaving directory `/misc/src/linux/fs'
make CFLAGS="-D__KERNEL__ -I/usr/src/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -pipe
-fno-strict-aliasing " -C  net
make[1]: Entering directory `/misc/src/linux/net'
/usr/src/linux/Rules.make:145: target `_subdir_sched' given more than
once in the same rule.
make -C core
make[2]: Entering directory `/misc/src/linux/net/core'
make all_targets
make[3]: Entering directory `/misc/src/linux/net/core'
kgcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -pipe    -fno-strict-aliasing
-DEXPORT_SYMTAB -c netfilter.c
netfilter.c:43: `NF_MAX_HOOKS' undeclared here (not in a function)
netfilter.c:52: parse error before `nf_queue_outfn_t'
netfilter.c:52: warning: no semicolon at end of struct or union
netfilter.c:54: parse error before `}'
netfilter.c:54: warning: type defaults to `int' in declaration of
`queue_handler'
netfilter.c:54: warning: data definition has no type or storage class
netfilter.c:56: warning: `struct nf_hook_ops' declared inside
parameter list
netfilter.c:56: warning: its scope is only this definition or
declaration,
netfilter.c:56: warning: which is probably not what you want.
netfilter.c: In function `nf_register_hook':
netfilter.c:61: dereferencing pointer to incomplete type
netfilter.c:61: dereferencing pointer to incomplete type
netfilter.c:62: dereferencing pointer to incomplete type
netfilter.c:62: dereferencing pointer to incomplete type
netfilter.c:64: dereferencing pointer to incomplete type
netfilter.c:64: dereferencing pointer to incomplete type
netfilter.c:67: dereferencing pointer to incomplete type
netfilter.c:58: warning: `i' might be used uninitialized in this
function
netfilter.c: At top level:
netfilter.c:72: warning: `struct nf_hook_ops' declared inside
parameter list
netfilter.c: In function `nf_unregister_hook':
netfilter.c:75: dereferencing pointer to incomplete type
netfilter.c: At top level:
netfilter.c:87: warning: `struct nf_sockopt_ops' declared inside
parameter list
netfilter.c: In function `nf_register_sockopt':
netfilter.c:97: dereferencing pointer to incomplete type
netfilter.c:97: dereferencing pointer to incomplete type
netfilter.c:98: dereferencing pointer to incomplete type
netfilter.c:98: dereferencing pointer to incomplete type
netfilter.c:99: dereferencing pointer to incomplete type
netfilter.c:99: dereferencing pointer to incomplete type
netfilter.c:100: dereferencing pointer to incomplete type
netfilter.c:100: dereferencing pointer to incomplete type
netfilter.c:101: dereferencing pointer to incomplete type
netfilter.c:101: dereferencing pointer to incomplete type
netfilter.c:112: dereferencing pointer to incomplete type
netfilter.c: At top level:
netfilter.c:118: warning: `struct nf_sockopt_ops' declared inside
parameter listnetfilter.c: In function `nf_unregister_sockopt':
netfilter.c:123: dereferencing pointer to incomplete type
netfilter.c:125: dereferencing pointer to incomplete type
netfilter.c:131: dereferencing pointer to incomplete type
netfilter.c: In function `nf_sockopt':
netfilter.c:292: dereferencing pointer to incomplete type
netfilter.c:294: dereferencing pointer to incomplete type
netfilter.c:295: dereferencing pointer to incomplete type
netfilter.c:296: dereferencing pointer to incomplete type
netfilter.c:298: dereferencing pointer to incomplete type
netfilter.c:302: dereferencing pointer to incomplete type
netfilter.c:303: dereferencing pointer to incomplete type
netfilter.c:304: dereferencing pointer to incomplete type
netfilter.c:306: dereferencing pointer to incomplete type
netfilter.c:317: dereferencing pointer to incomplete type
netfilter.c:318: dereferencing pointer to incomplete type
netfilter.c:319: dereferencing pointer to incomplete type
netfilter.c:285: warning: `ret' might be used uninitialized in this
function
netfilter.c: In function `nf_iterate':
netfilter.c:345: dereferencing pointer to incomplete type
netfilter.c:347: warning: unreachable code at beginning of switch
statement
netfilter.c: At top level:
netfilter.c:372: parse error before `nf_queue_outfn_t'
netfilter.c:373: warning: function declaration isn't a prototype
netfilter.c: In function `nf_register_queue_handler':
netfilter.c:377: `pf' undeclared (first use in this function)
netfilter.c:377: (Each undeclared identifier is reported only once
netfilter.c:377: for each function it appears in.)
netfilter.c:380: `outfn' undeclared (first use in this function)
netfilter.c: In function `nf_unregister_queue_handler':
netfilter.c:393: request for member `outfn' in something not a
structure or union
netfilter.c:394: request for member `data' in something not a
structure or unionnetfilter.c: In function `nf_queue':
netfilter.c:413: request for member `outfn' in something not a
structure or union
netfilter.c:418: dereferencing pointer to incomplete type
netfilter.c:427: dereferencing pointer to incomplete type
netfilter.c:428: warning: excess elements in struct initializer after
`(anonymous)'
netfilter.c:428: warning: excess elements in struct initializer after
`(anonymous)'
netfilter.c:428: warning: excess elements in struct initializer after
`(anonymous)'
netfilter.c:428: warning: excess elements in struct initializer after
`(anonymous)'
netfilter.c:428: warning: excess elements in struct initializer after
`(anonymous)'
netfilter.c:428: warning: excess elements in struct initializer after
`(anonymous)'
netfilter.c:434: request for member `outfn' in something not a
structure or union
netfilter.c:434: request for member `data' in something not a
structure or unionnetfilter.c: At top level:
netfilter.c:486: warning: `struct nf_info' declared inside parameter
list
netfilter.c: In function `nf_reinject':
netfilter.c:488: dereferencing pointer to incomplete type
netfilter.c:493: dereferencing pointer to incomplete type
netfilter.c:493: dereferencing pointer to incomplete type
netfilter.c:494: dereferencing pointer to incomplete type
netfilter.c:494: dereferencing pointer to incomplete type
netfilter.c:510: dereferencing pointer to incomplete type
netfilter.c:510: dereferencing pointer to incomplete type
netfilter.c:511: dereferencing pointer to incomplete type
netfilter.c:512: dereferencing pointer to incomplete type
netfilter.c:512: dereferencing pointer to incomplete type
netfilter.c:513: dereferencing pointer to incomplete type
netfilter.c:518: dereferencing pointer to incomplete type
netfilter.c:522: dereferencing pointer to incomplete type
netfilter.c:522: dereferencing pointer to incomplete type
netfilter.c:523: dereferencing pointer to incomplete type
netfilter.c:523: dereferencing pointer to incomplete type
netfilter.c:523: dereferencing pointer to incomplete type
netfilter.c:533: dereferencing pointer to incomplete type
netfilter.c:533: dereferencing pointer to incomplete type
netfilter.c:534: dereferencing pointer to incomplete type
netfilter.c:534: dereferencing pointer to incomplete type
netfilter.c:489: warning: `i' might be used uninitialized in this
function
netfilter.c: In function `netfilter_init':
netfilter.c:545: `NF_MAX_HOOKS' undeclared (first use in this
function)
make[3]: *** [netfilter.o] Error 1
make[3]: Leaving directory `/misc/src/linux/net/core'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/misc/src/linux/net/core'
make[1]: *** [_subdir_core] Error 2
make[1]: Leaving directory `/misc/src/linux/net'
make: *** [_dir_net] Error 2

regards,
-- 
Paul Jakma	paul@clubi.ie
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
Life is a concentration camp.  You're stuck here and there's no way
out and you can only rage impotently against your persecutors.
		-- Woody Allen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
