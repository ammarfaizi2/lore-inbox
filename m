Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278761AbRJVMtk>; Mon, 22 Oct 2001 08:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278760AbRJVMtY>; Mon, 22 Oct 2001 08:49:24 -0400
Received: from mx0.gmx.de ([213.165.64.100]:47246 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S278785AbRJVMtF>;
	Mon, 22 Oct 2001 08:49:05 -0400
Date: Mon, 22 Oct 2001 14:49:31 +0200 (MEST)
From: abusch@gmx.net
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Subject: [oops] 2.4.12+i kswapd invalid operand: 0000
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0000109679@gmx.net
X-Authenticated-IP: [194.15.145.12]
Message-ID: <18207.1003754971@www8.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a problem with KSWAPD, maybe with the latest vm changes ?
Haven't seen oops for a long time. Uptime was only 17 hours.

The kernel is 2.4.12 patched with the international crypto patch 2.4.3.1
and the 1521 NVidia module is loaded.

Here's the debugged ksymoops, followed by the memory map of my system.
I just wonder where those c0xxxxxx addresses come from, shouldn't it be free
?

[root@zuse1 /]# ksymoops -m /boot/System.map-2.4.12-crypto -d <
/var/log/crashlog 
DEBUG (convert_uname): /lib/modules/*r/ in
DEBUG (convert_uname): /lib/modules/2.4.12-crypto/ out
ksymoops 2.4.1 on i686 2.4.12-crypto.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.12-crypto/ (default)
     -m /boot/System.map-2.4.12-crypto (specified)

DEBUG (main): level 1
DEBUG (read_env): default KSYMOOPS_NM=/usr/bin/nm
DEBUG (read_env): default KSYMOOPS_FIND=/usr/bin/find
DEBUG (read_env): default KSYMOOPS_OBJDUMP=/usr/bin/objdump
DEBUG (re_compile): '^([0-9a-fA-F]{4,}) +([^ ]) +([^ ]+)( +\[([^ ]+)\])?$' 5
sub expression(s)
DEBUG (re_compile): '^ *\[*<([0-9a-fA-F]{4,})>\]* *' 1 sub expression(s)
DEBUG (re_compile): '^ *<\[([0-9a-fA-F]{4,})\]> *' 1 sub expression(s)
DEBUG (re_compile): '^ *([0-9a-fA-F]{4,}) *' 1 sub expression(s)
DEBUG (read_ksyms): /proc/ksyms
DEBUG (re_compile): '^([0-9a-fA-F]{4,}) +([^ ]+)( +\[([^ ]+)\])?$' 4 sub
expression(s)
DEBUG (re_compile): '^(.*)_R.*[0-9a-fA-F]{8,}$' 1 sub expression(s)
DEBUG (re_compile):
'^(__insmod_.*)(_O(.*)_M([0-9a-fA-F]+)_V(-?[0-9]+)|_S(.*)_L([0-9]+))' 7 sub expression(s)
DEBUG (ss_sort_na): ppp_async
DEBUG (ss_sort_na): ppp_generic
DEBUG (ss_sort_na): tvmixer
DEBUG (ss_sort_na): es1371
DEBUG (ss_sort_na): ntfs
DEBUG (ss_sort_na): ac97_codec
DEBUG (ss_sort_na): gameport
DEBUG (ss_sort_na): bttv
DEBUG (ss_sort_na): tvaudio
DEBUG (ss_sort_na): msp3400
DEBUG (ss_sort_na): soundcore
DEBUG (ss_sort_na): tuner
DEBUG (ss_sort_na): i2c-algo-bit
DEBUG (ss_sort_na): i2c-core
DEBUG (ss_sort_na): videodev
DEBUG (ss_sort_na): agpgart
DEBUG (ss_sort_na): binfmt_misc
DEBUG (ss_sort_na): slhc
DEBUG (ss_sort_na): NVdriver
DEBUG (ss_sort_na): parport_pc
DEBUG (ss_sort_na): lp
DEBUG (ss_sort_na): parport
DEBUG (ss_sort_na): ipchains
DEBUG (ss_sort_na): ide-scsi
DEBUG (ss_sort_na): scsi_mod
DEBUG (ss_sort_na): usb-uhci
DEBUG (ss_sort_na): usbcore
DEBUG (ss_sort_na): ksyms_base
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/net/ppp_async.o for ppp_async
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/net/ppp_generic.o for ppp_generic
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/media/video/tvmixer.o for tvmixer
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/sound/es1371.o for es1371
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/fs/ntfs/ntfs.o for ntfs
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/sound/ac97_codec.o for ac97_codec
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/char/joystick/gameport.o for gameport
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/media/video/bttv.o for bttv
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/media/video/tvaudio.o for tvaudio
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/media/video/msp3400.o for msp3400
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/sound/soundcore.o for soundcore
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/media/video/tuner.o for tuner
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/i2c/i2c-algo-bit.o for i2c-algo-bit
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/i2c/i2c-core.o for i2c-core
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/media/video/videodev.o for videodev
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/char/agp/agpgart.o for agpgart
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/fs/binfmt_misc.o for binfmt_misc
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/net/slhc.o for slhc
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/video/NVdriver for NVdriver
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/parport/parport_pc.o for parport_pc
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/char/lp.o for lp
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/parport/parport.o for parport
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/net/ipv4/netfilter/ipchains.o for ipchains
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/scsi/ide-scsi.o for ide-scsi
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/scsi/scsi_mod.o for scsi_mod
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/usb/usb-uhci.o for usb-uhci
DEBUG (expand_objects): using
/lib/modules/2.4.12-crypto/kernel/drivers/usb/usbcore.o for usbcore
DEBUG (expand_objects): all ksyms modules map to specific object files
DEBUG (ss_sort_na):
/lib/modules/2.4.12-crypto/kernel/drivers/net/ppp_async.o
DEBUG (ss_sort_na):
/lib/modules/2.4.12-crypto/kernel/drivers/net/ppp_generic.o
DEBUG (ss_sort_na):
/lib/modules/2.4.12-crypto/kernel/drivers/media/video/tvmixer.o
DEBUG (ss_sort_na): /lib/modules/2.4.12-crypto/kernel/drivers/sound/es1371.o
DEBUG (ss_sort_na): /lib/modules/2.4.12-crypto/kernel/fs/ntfs/ntfs.o
DEBUG (ss_sort_na):
/lib/modules/2.4.12-crypto/kernel/drivers/sound/ac97_codec.o
DEBUG (ss_sort_na):
/lib/modules/2.4.12-crypto/kernel/drivers/char/joystick/gameport.o
DEBUG (ss_sort_na):
/lib/modules/2.4.12-crypto/kernel/drivers/media/video/bttv.o
DEBUG (ss_sort_na):
/lib/modules/2.4.12-crypto/kernel/drivers/media/video/tvaudio.o
DEBUG (ss_sort_na):
/lib/modules/2.4.12-crypto/kernel/drivers/media/video/msp3400.o
DEBUG (ss_sort_na):
/lib/modules/2.4.12-crypto/kernel/drivers/sound/soundcore.o
DEBUG (ss_sort_na):
/lib/modules/2.4.12-crypto/kernel/drivers/media/video/tuner.o
DEBUG (ss_sort_na):
/lib/modules/2.4.12-crypto/kernel/drivers/i2c/i2c-algo-bit.o
DEBUG (ss_sort_na): /lib/modules/2.4.12-crypto/kernel/drivers/i2c/i2c-core.o
DEBUG (ss_sort_na):
/lib/modules/2.4.12-crypto/kernel/drivers/media/video/videodev.o
DEBUG (ss_sort_na):
/lib/modules/2.4.12-crypto/kernel/drivers/char/agp/agpgart.o
DEBUG (ss_sort_na): /lib/modules/2.4.12-crypto/kernel/fs/binfmt_misc.o
DEBUG (ss_sort_na): /lib/modules/2.4.12-crypto/kernel/drivers/net/slhc.o
DEBUG (ss_sort_na): /lib/modules/2.4.12-crypto/kernel/drivers/video/NVdriver
DEBUG (ss_sort_na):
/lib/modules/2.4.12-crypto/kernel/drivers/parport/parport_pc.o
DEBUG (ss_sort_na): /lib/modules/2.4.12-crypto/kernel/drivers/char/lp.o
DEBUG (ss_sort_na):
/lib/modules/2.4.12-crypto/kernel/drivers/parport/parport.o
DEBUG (ss_sort_na):
/lib/modules/2.4.12-crypto/kernel/net/ipv4/netfilter/ipchains.o
DEBUG (ss_sort_na):
/lib/modules/2.4.12-crypto/kernel/drivers/scsi/ide-scsi.o
DEBUG (ss_sort_na):
/lib/modules/2.4.12-crypto/kernel/drivers/scsi/scsi_mod.o
DEBUG (ss_sort_na): /lib/modules/2.4.12-crypto/kernel/drivers/usb/usb-uhci.o
DEBUG (ss_sort_na): /lib/modules/2.4.12-crypto/kernel/drivers/usb/usbcore.o
DEBUG (read_lsmod): /proc/modules
DEBUG (re_compile): '^ *([^ ]+) *([^ ]+) *([^ ]+) *(.*)$' 4 sub
expression(s)
DEBUG (ss_sort_na): lsmod
DEBUG (read_system_map): /boot/System.map-2.4.12-crypto
DEBUG (ss_sort_na): System.map
DEBUG (merge_maps): 
DEBUG (ss_sort_na): System.map
DEBUG (ss_sort_na): Version_
DEBUG (compare_Version): Version 2.4.12
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says
c01fa770, System.map says c014ac20.  Ignoring ksyms_base entry
DEBUG (map_ksyms_to_modules): ksyms ppp_async matches to
/lib/modules/2.4.12-crypto/kernel/drivers/net/ppp_async.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms ppp_generic matches to
/lib/modules/2.4.12-crypto/kernel/drivers/net/ppp_generic.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms tvmixer matches to
/lib/modules/2.4.12-crypto/kernel/drivers/media/video/tvmixer.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms es1371 matches to
/lib/modules/2.4.12-crypto/kernel/drivers/sound/es1371.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms ntfs matches to
/lib/modules/2.4.12-crypto/kernel/fs/ntfs/ntfs.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms ac97_codec matches to
/lib/modules/2.4.12-crypto/kernel/drivers/sound/ac97_codec.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms gameport matches to
/lib/modules/2.4.12-crypto/kernel/drivers/char/joystick/gameport.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms bttv matches to
/lib/modules/2.4.12-crypto/kernel/drivers/media/video/bttv.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms tvaudio matches to
/lib/modules/2.4.12-crypto/kernel/drivers/media/video/tvaudio.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms msp3400 matches to
/lib/modules/2.4.12-crypto/kernel/drivers/media/video/msp3400.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms soundcore matches to
/lib/modules/2.4.12-crypto/kernel/drivers/sound/soundcore.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms tuner matches to
/lib/modules/2.4.12-crypto/kernel/drivers/media/video/tuner.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms i2c-algo-bit matches to
/lib/modules/2.4.12-crypto/kernel/drivers/i2c/i2c-algo-bit.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms i2c-core matches to
/lib/modules/2.4.12-crypto/kernel/drivers/i2c/i2c-core.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms videodev matches to
/lib/modules/2.4.12-crypto/kernel/drivers/media/video/videodev.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms agpgart matches to
/lib/modules/2.4.12-crypto/kernel/drivers/char/agp/agpgart.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms binfmt_misc matches to
/lib/modules/2.4.12-crypto/kernel/fs/binfmt_misc.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms slhc matches to
/lib/modules/2.4.12-crypto/kernel/drivers/net/slhc.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms NVdriver matches to
/lib/modules/2.4.12-crypto/kernel/drivers/video/NVdriver based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms parport_pc matches to
/lib/modules/2.4.12-crypto/kernel/drivers/parport/parport_pc.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms lp matches to
/lib/modules/2.4.12-crypto/kernel/drivers/char/lp.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms parport matches to
/lib/modules/2.4.12-crypto/kernel/drivers/parport/parport.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms ipchains matches to
/lib/modules/2.4.12-crypto/kernel/net/ipv4/netfilter/ipchains.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms ide-scsi matches to
/lib/modules/2.4.12-crypto/kernel/drivers/scsi/ide-scsi.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms scsi_mod matches to
/lib/modules/2.4.12-crypto/kernel/drivers/scsi/scsi_mod.o based on modutils assist
Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says
d9bcf5d0, /lib/modules/2.4.12-crypto/kernel/drivers/scsi/scsi_mod.o says d9bcf034. 
Ignoring /lib/modules/2.4.12-crypto/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod says
d9bcf5fc, /lib/modules/2.4.12-crypto/kernel/drivers/scsi/scsi_mod.o says
d9bcf060.  Ignoring /lib/modules/2.4.12-crypto/kernel/drivers/scsi/scsi_mod.o
entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod says
d9bcf5f8, /lib/modules/2.4.12-crypto/kernel/drivers/scsi/scsi_mod.o says
d9bcf05c.  Ignoring /lib/modules/2.4.12-crypto/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says
d9bcf600, /lib/modules/2.4.12-crypto/kernel/drivers/scsi/scsi_mod.o says d9bcf064.
 Ignoring /lib/modules/2.4.12-crypto/kernel/drivers/scsi/scsi_mod.o entry
DEBUG (map_ksyms_to_modules): ksyms usb-uhci matches to
/lib/modules/2.4.12-crypto/kernel/drivers/usb/usb-uhci.o based on modutils assist
DEBUG (map_ksyms_to_modules): ksyms usbcore matches to
/lib/modules/2.4.12-crypto/kernel/drivers/usb/usbcore.o based on modutils assist
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says
d9902060, /lib/modules/2.4.12-crypto/kernel/drivers/usb/usbcore.o says
d9901b80.  Ignoring /lib/modules/2.4.12-crypto/kernel/drivers/usb/usbcore.o entry
DEBUG (ss_sort_atn): merged
DEBUG (ss_sort_atn): merged
DEBUG (ss_sort_atn): merged
DEBUG (re_compile): '^( +|[^ ]{3} [ 0-9][0-9] [0-9]{2}:[0-9]{2}:[0-9]{2} [^
]+ kernel: +|<[0-9]+>)' 1 sub expression(s)
DEBUG (re_compile): '^((Stack: )|(Stack from )|([0-9a-fA-F]{4,})|(Call
Trace: )|(\[*<([0-9a-fA-F]{4,})>\]* *)|(Version_[0-9]+)|(Trace:)|(Call
backtrace:)|(bh:)|<\[([0-9a-fA-F]{4,})\]> *|(\([^ ]+\) *\[*<([0-9a-fA-F]{4,})>\]*
*)|([0-9]+ +base=)|(Kernel BackChain)|EBP *EIP|0x([0-9a-fA-F]{4,})
*0x([0-9a-fA-F]{4,}) *|Process .*stackpage=|Code *: |Kernel panic|In swapper
task|kmem_free|swapper|Corrupted stack page|invalid operand: |Oops: |Cpu:*
+[0-9]|current->tss|\*pde +=|EIP: |EFLAGS: |eax: |esi: |ds: |CR0: |wait_on_|irq: |Stack
dumps:|pc[:=]|68060 access|Exception at |d[04]: |Frame format=|wb [0-9] stat|push
data: |baddr=|Arithmetic fault|Instruction fault|Bad unaligned
kernel|Forwarding unaligned exception|: unhandled unaligned exception|pc *=|[rvtsa][0-9]+
*=|gp *=|spinlock stuck|tsk->|PSR: |[goli]0: |Instruction DUMP:
|spin_lock|TSTATE: |[goli]4: |Caller\[|CPU\[|MSR: |TASK = |last math |GPR[0-9]+: |\$[0-9
]+:|epc |Status:|Cause :|Backtrace:|Function entered at|\*pgd =|Internal error|pc
:|sp :|r[0-9][0-9
]:|Flags:|Control:|WARNING:|this_stack:|i:|PSW|cr[0-9]+:|r[0-9]+:|machine check|Exception in |Program Check |System restart |IUCV
|unexpected external |Kernel stack |User process fault:|failing address|User
PSW|User GPRS|User ACRS|Kernel PSW|Kernel GPRS|Kernel ACRS|illegal
operation|task:|Entering kdb|eax *=|esi *=|ebp *=|ds *=|psr *:|unat *: |rnat *: |ldrs *:
|[bfr][0-9]+ *: |General Exception)' 18 sub expression(s)
DEBUG (re_compile): 'Unable to handle kernel|Aiee|die_if_kernel|NMI |BUG
|\([0-9]\): Oops |: memory violation|: Exception at|: Arithmetic fault|:
Instruction fault|: arithmetic trap|: unaligned trap|\([0-9]+\):
(Whee|Oops|Kernel|.*Penguin|BOGUS)|kernel pc |trap at PC: |bad area pc |NIP: | ra *==' 1 sub
expression(s)
DEBUG (re_compile): '^(i[04]: |Instruction DUMP: |Caller\[)' 1 sub
expression(s)
Oct 21 15:02:00 zuse1 kernel: invalid operand: 0000
DEBUG (re_compile): '^PSR: [0-9a-fA-F]+ PC: ([0-9a-fA-F]{4,}) *' 1 sub
expression(s)
DEBUG (re_compile): '^TSTATE: [0-9a-fA-F]{16} TPC: ([0-9a-fA-F]{4,}) *' 1
sub expression(s)
DEBUG (re_compile): '(kernel pc |trap at PC: |bad area pc |NIP:
)([0-9a-fA-F]{4,}) *' 2 sub expression(s)
DEBUG (re_compile): '^epc *:+ *([0-9a-fA-F]{4,}) *' 1 sub expression(s)
DEBUG (re_compile): ' ip *:+ *\[*<([0-9a-fA-F]{4,})>\]* *' 1 sub
expression(s)
DEBUG (re_compile): '(^0x([0-9a-fA-F]{4,}) *0x([0-9a-fA-F]{4,})
*.*+0x)|(^Entering kdb on processor.*0x([0-9a-fA-F]{4,}) *)' 5 sub expression(s)
DEBUG (re_compile): '^(EIP: +.*|PC *= *|pc *: *)\[*<([0-9a-fA-F]{4,})>\]* *'
2 sub expression(s)
DEBUG (re_compile): '^spinlock stuck at ([0-9a-fA-F]{4,}) *.*owner.*at
([0-9a-fA-F]{4,}) *' 2 sub expression(s)
DEBUG (re_compile): '^spin_lock[^ ]*\(([0-9a-fA-F]{4,}) *.*stuck at
*([0-9a-fA-F]{4,}) *.*PC\(([0-9a-fA-F]{4,}) *' 3 sub expression(s)
DEBUG (re_compile): 'ra *=+ *([0-9a-fA-F]{4,}) *' 1 sub expression(s)
DEBUG (re_compile): '^[io][04]: [0-9a-fA-F iosp:]+ ([io]7|ret_pc):
([0-9a-fA-F]{4,}) *' 2 sub expression(s)
DEBUG (re_compile): '^PSW *flags: *([0-9a-fA-F]{4,}) * *PSW addr:
*([0-9a-fA-F]{4,}) *' 2 sub expression(s)
DEBUG (re_compile): '^Kernel PSW: *([0-9a-fA-F]{4,}) *([0-9a-fA-F]{4,}) *' 2
sub expression(s)
DEBUG (re_compile): '^((Call Trace: )|(Trace:)|(\[*<([0-9a-fA-F]{4,})>\]*
*)|(Call backtrace:)|([0-9a-fA-F]{4,}) *|Function entered at
(\[*<([0-9a-fA-F]{4,})>\]* *)|Caller\[([0-9a-fA-F]{4,}) *\]|(<\[([0-9a-fA-F]{4,})\]>
*)|(\([0-9]+\) *(\[*<([0-9a-fA-F]{4,})>\]* *))|([0-9]+ +base=0x([0-9a-fA-F]{4,})
*)|(Kernel BackChain.*))' 18 sub expression(s)
DEBUG (re_compile): '^(r[0-9]{1,2}): *([0-9a-fA-F]{4,}) *' 2 sub
expression(s)
DEBUG (re_compile): '^(Kernel GPRS.*)' 1 sub expression(s)
DEBUG (re_compile): '^b[0-7] *: *([0-9a-fA-F]{4,}) *' 1 sub expression(s)
DEBUG (re_compile): '^((Instruction DUMP)|(Code *)): +((general
protection.*)|(Bad EIP value.*)|(<[0-9]+>)|(([<(]?[0-9a-fA-F]+[>)]?
+)+[<(]?[0-9a-fA-F]+[>)]?))(.*)$' 10 sub expression(s)
Oct 21 15:02:00 zuse1 kernel: CPU:    0
Oct 21 15:02:00 zuse1 kernel: EIP:    0010:[__free_pages_ok+27/480]   
Tainted: P 
Oct 21 15:02:00 zuse1 kernel: EIP:    0010:[<c012a17b>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
Oct 21 15:02:00 zuse1 kernel: EFLAGS: 00010282
Oct 21 15:02:00 zuse1 kernel: eax: c11622c0   ebx: 00000000   ecx: c11622c0 
 edx: cff466b0
Oct 21 15:02:00 zuse1 kernel: esi: c11622c0   edi: 00000005   ebp: 00000000 
 esp: c1435f20
Oct 21 15:02:00 zuse1 kernel: ds: 0018   es: 0018   ss: 0018
Oct 21 15:02:00 zuse1 kernel: Process kswapd (pid: 5, stackpage=c1435000)
Oct 21 15:02:00 zuse1 kernel: Stack: c1040000 c029cea0 c029ce88 c11622c0
c11622c0 c11622c0 00000005 00000b5d 
Oct 21 15:02:00 zuse1 kernel:        c0129901 c1434000 c029ce88 00000020
000003d0 00000006 000089ae c0129bbc 
Oct 21 15:02:00 zuse1 kernel:        000003d0 00000004 c03162e0 c029ce88
00000006 00000020 000003d0 c029ce88 
Oct 21 15:02:00 zuse1 kernel: Call Trace: [shrink_cache+449/768]
[shrink_caches+92/144] [try_to_free_pages+44/96] [kswapd_balance_pgdat+81/160]
[kswapd_balance+38/80] 
DEBUG (re_compile): '^(\([0-9]+\) *)' 1 sub expression(s)
Oct 21 15:02:00 zuse1 kernel: Call Trace: [<c0129901>] [<c0129bbc>]
[<c0129c1c>] [<c0129cd1>] [<c0129d46>] 
Oct 21 15:02:00 zuse1 kernel:    [<c0129e91>] [<c0129df0>] [<c0105000>]
[<c0105516>] [<c0129df0>] 
Oct 21 15:02:00 zuse1 kernel: Code: 0f 0b 8b 0d 2c 7f 2f c0 89 f0 29 c8 c1
f8 06 3b 05 20 7f 2f 
DEBUG (Oops_decode): 
DEBUG (re_compile): '^(([<(]?)([0-9a-fA-F]+)[)>]? *)|(Bad .*)' 4 sub
expression(s)
DEBUG (re_compile): '^ *([0-9a-fA-F]+)( <_XXX[^>]*>)?:(.*
+<_XXX\+0?x?([0-9a-fA-F]+)> *$)?.*' 4 sub expression(s)
DEBUG (Oops_format): 

>>EIP; c012a17b <__free_pages_ok+1b/1e0>   <=====
Trace; c0129901 <shrink_cache+1c1/300>
Trace; c0129bbc <shrink_caches+5c/90>
Trace; c0129c1c <try_to_free_pages+2c/60>
Trace; c0129cd1 <kswapd_balance_pgdat+51/a0>
Trace; c0129d46 <kswapd_balance+26/50>
Trace; c0129e91 <kswapd+a1/c0>
Trace; c0129df0 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0129df0 <kswapd+0/c0>
Code;  c012a17b <__free_pages_ok+1b/1e0>
00000000 <_EIP>:
Code;  c012a17b <__free_pages_ok+1b/1e0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012a17d <__free_pages_ok+1d/1e0>
   2:   8b 0d 2c 7f 2f c0         mov    0xc02f7f2c,%ecx
Code;  c012a183 <__free_pages_ok+23/1e0>
   8:   89 f0                     mov    %esi,%eax
Code;  c012a185 <__free_pages_ok+25/1e0>
   a:   29 c8                     sub    %ecx,%eax
Code;  c012a187 <__free_pages_ok+27/1e0>
   c:   c1 f8 06                  sar    $0x6,%eax
Code;  c012a18a <__free_pages_ok+2a/1e0>
   f:   3b 05 20 7f 2f 00         cmp    0x2f7f20,%eax

6 warnings issued.  Results may not be reliable.

[root@zuse1 /]# cat /proc/iomem 
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-0025e23f : Kernel code
  0025e240-002b35cb : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-d7ffffff : PCI Bus #01
  d0000000-d7ffffff : nVidia Corporation NV11 (GeForce2 MX)
    d0000000-d7ffffff : rivafb
d8000000-dbffffff : Intel Corporation 82815 815 Chipset Host Bridge and
Memory Controller Hub
dc000000-ddffffff : PCI Bus #01
  dc000000-dcffffff : nVidia Corporation NV11 (GeForce2 MX)
    dc000000-dcffffff : rivafb
de000000-dfffffff : PCI Bus #02
  df000000-df0fffff : Intel Corporation 82557 [Ethernet Pro 100]
  df100000-df1fffff : Intel Corporation 82557 [Ethernet Pro 100] (#2)
  df200000-df200fff : Intel Corporation 82557 [Ethernet Pro 100] (#2)
    df200000-df200fff : eepro100
e0000000-e00fffff : PCI Bus #02
  e0000000-e0000fff : Intel Corporation 82557 [Ethernet Pro 100]
    e0000000-e0000fff : eepro100
  e0001000-e0001fff : Brooktree Corporation Bt878
    e0001000-e0001fff : bttv
  e0002000-e0002fff : Brooktree Corporation Bt878
ffb00000-ffffffff : reserved

Motherboard is a Gigabyte 6OXET with 256 MB Ram PC133 and a Celeron 700
MHz/100.
Graphics is GeForce 2 MX Asus 7100 with 32MB (NVidia 1521 kernel-module)
Oops happened in idle mode (which means, apache, dnetc, mysql and so on
running,
no real load by web users or similar).
Hardware isn't changed since 2.4.9, all kernels before were perfectly stable
for me (except ntfs, parport and so on, you know).
Ooops happened after 17 hours uptime. Once so far. The box is running 24/7
usually.

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

