Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271712AbRIWCPs>; Sat, 22 Sep 2001 22:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273099AbRIWCPc>; Sat, 22 Sep 2001 22:15:32 -0400
Received: from knight.ca.mdis.co.jp ([202.253.208.54]:26857 "EHLO
	knight.ca.mdis.co.jp") by vger.kernel.org with ESMTP
	id <S271712AbRIWCPQ>; Sat, 22 Sep 2001 22:15:16 -0400
Message-Id: <200109230202.AA00028@prism.fa.mdis.co.jp>
From: Seiichi Nakashima <nakasei@fa.mdis.co.jp>
Date: Sun, 23 Sep 2001 11:02:39 +0900
To: tao@acc.umu.se
Cc: linux-kernel@vger.kernel.org, nakasei@fa.mdis.co.jp
Subject: linux-2.0.40-pre1 compile error
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.12
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear. David Weinehall

I am Seiichi Nakashima.

Today, I found a new linux-2.0.40-pre1 kernel patch in kernel.org tao's directory.
I download patch and applied to linux-2.0.39 and compile kernel, but compile error
occured at traps.c compile step.

My environment

Celeron-566, Memory-128MB, BX-chipset Mother( ASUS-CWBX )
and slackware-3.9 base.

# gcc -v
gcc version 2.7.2.3

(I compile slackware-8.0 base, but cannot compile first step)

I send you logs( make zImage 1> /tmp/log1 2> /tmp/log2 ) and config parameter.


< log2 >

dir.c: In function `ext2_readdir':
dir.c:157: warning: assignment from incompatible pointer type
super.c: In function `ext2_statfs':
super.c:714: warning: unused variable `overhead_per_group'
traps.c:66: parse error before `:'
traps.c:66: warning: data definition has no type or storage class
traps.c:66: parse error before `}'
traps.c:73: warning: data definition has no type or storage class
traps.c:73: parse error before `}'
traps.c:79: warning: data definition has no type or storage class
traps.c:79: parse error before `}'
traps.c: In function `die_if_kernel':
traps.c:153: parse error before `printk'
traps.c:159: parse error before `;'
traps.c:177: parse error before `printk'
traps.c:184: parse error before `void'
traps.c:184: `error_code' undeclared (first use this function)
traps.c:184: (Each undeclared identifier is reported only once
traps.c:184: for each function it appears in.)
traps.c:185: parse error before `void'
traps.c: At top level:
traps.c:185: parse error before `0'
traps.c:185: parse error before `5'
traps.c:185: parse error before string constant
traps.c:185: warning: function declaration isn't a prototype
traps.c:185: conflicting types for `die_if_kernel'
traps.c:115: previous declaration of `die_if_kernel'
traps.c:185: warning: data definition has no type or storage class
make[1]: *** [traps.o] Error 1
make: *** [linuxsubdirs] Error 2


< log1 >

gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
init/main.o 
init/main.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686 
-DUTS_MACHINE='"i386"' 
-c 
-o init/version.o init/version.c
set -e; for i in kernel drivers mm fs net ipc lib arch/i386/kernel arch/i386/mm arch/i386/lib; do make -C $i; 
done
make[1]: Entering directory `/usr/src/linux-2.0.40-pre1/kernel'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/kernel'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  
-fno-omit-frame-pointer 
-c sched.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
dma.o dma.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
fork.o fork.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
exec_domain.o 
exec_domain.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
panic.o panic.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
printk.o 
printk.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
sys.o sys.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
module.o 
module.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
exit.o exit.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
signal.o 
signal.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
itimer.o 
itimer.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
info.o info.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
time.o time.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
softirq.o 
softirq.
c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
resource.o 
resource.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
sysctl.o 
sysctl.c
rm -f kernel.o
ld -m elf_i386  -r -o kernel.o  sched.o dma.o fork.o exec_domain.o panic.o printk.o sys.o module.o exit.o 
signal.o 
itimer.o info.o time.o softirq.o resource.o sysctl.o
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/kernel'
make[1]: Leaving directory `/usr/src/linux-2.0.40-pre1/kernel'
make[1]: Entering directory `/usr/src/linux-2.0.40-pre1/drivers'
set -e; for i in block char net  pci; do make -C $i; done
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/drivers/block'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.0.40-pre1/drivers/block'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
ll_rw_blk.o 
ll_rw_blk.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
genhd.o genhd.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
floppy.o 
floppy.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
ide.o ide.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
ide-cd.o 
ide-cd.c
rm -f block.a
ar  rcs block.a  ll_rw_blk.o genhd.o floppy.o ide.o ide-cd.o
make[3]: Leaving directory `/usr/src/linux-2.0.40-pre1/drivers/block'
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/drivers/block'
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/drivers/char'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.0.40-pre1/drivers/char'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
serial.o 
serial.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
misc.o misc.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
tty_io.o 
tty_io.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
n_tty.o n_tty.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
console.o 
console.
c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
tty_ioctl.o 
tty_ioctl.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
pty.o pty.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
vt.o vt.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
mem.o mem.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
vc_screen.o 
vc_screen.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
random.o 
random.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
consolemap.o 
consolemap.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
selection.o 
selection.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
keyboard.o 
keyboard.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
defkeymap.o 
defkeymap.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
rtc.o rtc.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
vga.o vga.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
vesa_blank.o 
vesa_blank.c
rm -f char.a
ar  rcs char.a serial.o misc.o tty_io.o n_tty.o console.o tty_ioctl.o pty.o vt.o mem.o vc_screen.o random.o 
consolemap.o 
selection.o keyboard.o defkeymap.o rtc.o vga.o vesa_blank.o
make[3]: Leaving directory `/usr/src/linux-2.0.40-pre1/drivers/char'
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/drivers/char'
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/drivers/net'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.0.40-pre1/drivers/net'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
auto_irq.o 
auto_irq.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include  -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c 
Space.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
net_init.o 
net_init.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
loopback.o 
loopback.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include  -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686 -c 
dummy.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
rtl8139.o 
rtl8139.
c
rm -f net.a
ar  rcs net.a  auto_irq.o Space.o net_init.o loopback.o dummy.o rtl8139.o
make[3]: Leaving directory `/usr/src/linux-2.0.40-pre1/drivers/net'
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/drivers/net'
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/drivers/pci'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.0.40-pre1/drivers/pci'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
pci.o pci.c
rm -f pci.a
ar  rcs pci.a  pci.o
make[3]: Leaving directory `/usr/src/linux-2.0.40-pre1/drivers/pci'
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/drivers/pci'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/drivers'
make[2]: Nothing to be done for `all_targets'.
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/drivers'
make[1]: Leaving directory `/usr/src/linux-2.0.40-pre1/drivers'
make[1]: Entering directory `/usr/src/linux-2.0.40-pre1/mm'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/mm'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
memory.o 
memory.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
mmap.o mmap.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
filemap.o 
filemap.
c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
mprotect.o 
mprotect.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
mlock.o mlock.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
mremap.o 
mremap.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
kmalloc.o 
kmalloc.
c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
vmalloc.o 
vmalloc.
c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
swap.o swap.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
vmscan.o 
vmscan.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
page_io.o 
page_io.
c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
page_alloc.o 
page_alloc.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
swap_state.o 
swap_state.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
swapfile.o 
swapfile.c
rm -f mm.o
ld -m elf_i386  -r -o mm.o  memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o kmalloc.o vmalloc.o 
swap.o vmscan.o 
page_io.o page_alloc.o swap_state.o swapfile.o
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/mm'
make[1]: Leaving directory `/usr/src/linux-2.0.40-pre1/mm'
make[1]: Entering directory `/usr/src/linux-2.0.40-pre1/fs'
set -e; for i in ext2 fat msdos vfat proc isofs; do make -C $i; done
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/fs/ext2'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.0.40-pre1/fs/ext2'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
acl.o acl.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
balloc.o 
balloc.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
bitmap.o 
bitmap.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
dir.o dir.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
file.o file.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
fsync.o fsync.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
ialloc.o 
ialloc.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
inode.o inode.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
ioctl.o ioctl.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
namei.o namei.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
super.o super.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
symlink.o 
symlink.
c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
truncate.o 
truncate.c
rm -f ext2.o
ld -m elf_i386  -r -o ext2.o  acl.o balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o ioctl.o namei.o super.o 
symlink.o truncate.o
make[3]: Leaving directory `/usr/src/linux-2.0.40-pre1/fs/ext2'
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/fs/ext2'
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/fs/fat'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.0.40-pre1/fs/fat'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
fatfs_syms.o 
fatfs_syms.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
buffer.o 
buffer.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
cache.o cache.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
dir.o dir.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
file.o file.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
inode.o inode.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
misc.o misc.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
mmap.o mmap.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
tables.o 
tables.c
rm -f fat.o
ld -m elf_i386  -r -o fat.o fatfs_syms.o buffer.o cache.o dir.o file.o inode.o misc.o mmap.o tables.o
make[3]: Leaving directory `/usr/src/linux-2.0.40-pre1/fs/fat'
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/fs/fat'
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/fs/msdos'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.0.40-pre1/fs/msdos'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
msdosfs_syms.o 
msdosfs_syms.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
namei.o namei.c
rm -f msdos.o
ld -m elf_i386  -r -o msdos.o msdosfs_syms.o namei.o
make[3]: Leaving directory `/usr/src/linux-2.0.40-pre1/fs/msdos'
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/fs/msdos'
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/fs/vfat'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.0.40-pre1/fs/vfat'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
vfatfs_syms.o 
vfatfs_syms.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
namei.o namei.c
rm -f vfat.o
ld -m elf_i386  -r -o vfat.o vfatfs_syms.o namei.o
make[3]: Leaving directory `/usr/src/linux-2.0.40-pre1/fs/vfat'
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/fs/vfat'
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/fs/proc'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.0.40-pre1/fs/proc'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
procfs_syms.o 
procfs_syms.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
inode.o inode.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
root.o root.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
base.o base.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
mem.o mem.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
link.o link.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
fd.o fd.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
array.o array.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
kmsg.o kmsg.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
net.o net.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
scsi.o scsi.c
rm -f proc.o
ld -m elf_i386  -r -o proc.o procfs_syms.o inode.o root.o base.o mem.o link.o fd.o array.o kmsg.o net.o scsi.o
make[3]: Leaving directory `/usr/src/linux-2.0.40-pre1/fs/proc'
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/fs/proc'
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/fs/isofs'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.0.40-pre1/fs/isofs'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
namei.o namei.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
inode.o inode.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
file.o file.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
dir.o dir.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
util.o util.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
rock.o rock.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
symlink.o 
symlink.
c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
joliet.o 
joliet.c
rm -f isofs.o
ld -m elf_i386  -r -o isofs.o  namei.o inode.o file.o dir.o util.o rock.o symlink.o joliet.o
make[3]: Leaving directory `/usr/src/linux-2.0.40-pre1/fs/isofs'
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/fs/isofs'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/fs'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
nls.o nls.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
open.o open.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
read_write.o 
read_write.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
inode.o inode.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
devices.o 
devices.
c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
file_table.o 
file_table.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
buffer.o 
buffer.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
super.o super.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
block_dev.o 
block_dev.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
stat.o stat.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
exec.o exec.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
pipe.o pipe.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
namei.o namei.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
fcntl.o fcntl.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
ioctl.o ioctl.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
readdir.o 
readdir.
c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
select.o 
select.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
fifo.o fifo.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
locks.o locks.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
filesystems.o 
filesystems.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
dcache.o 
dcache.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
bad_inode.o 
bad_inode.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
binfmt_elf.o 
binfmt_elf.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
binfmt_aout.o 
binfmt_aout.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
binfmt_script.o 
binfmt_script.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
noquot.o 
noquot.c
rm -f fs.o
ld -m elf_i386  -r -o fs.o nls.o open.o read_write.o inode.o devices.o file_table.o buffer.o super.o  block_dev.o 
stat.o 
exec.o pipe.o namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o filesystems.o dcache.o bad_inode.o 
binfmt_elf.o 
binfmt_aout.o binfmt_script.o noquot.o
rm -f filesystems.a
ar  rcs filesystems.a  ext2/ext2.o fat/fat.o msdos/msdos.o vfat/vfat.o proc/proc.o isofs/isofs.o
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/fs'
make[1]: Leaving directory `/usr/src/linux-2.0.40-pre1/fs'
make[1]: Entering directory `/usr/src/linux-2.0.40-pre1/net'
set -e; for i in core ethernet unix 802 ipv4; do make -C $i; done
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/net/core'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.0.40-pre1/net/core'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
sock.o sock.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
skbuff.o 
skbuff.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
iovec.o iovec.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
datagram.o 
datagram.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
sysctl_net_core.o 
sysctl_net_core.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
dev.o dev.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
dev_mcast.o 
dev_mcast.c
rm -f core.o
ld -m elf_i386  -r -o core.o  sock.o skbuff.o iovec.o datagram.o sysctl_net_core.o dev.o dev_mcast.o
make[3]: Leaving directory `/usr/src/linux-2.0.40-pre1/net/core'
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/net/core'
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/net/ethernet'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.0.40-pre1/net/ethernet'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
eth.o eth.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
sysctl_net_ether.o 
sysctl_net_ether.c
rm -f ethernet.o
ld -m elf_i386  -r -o ethernet.o  eth.o sysctl_net_ether.o 
make[3]: Leaving directory `/usr/src/linux-2.0.40-pre1/net/ethernet'
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/net/ethernet'
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/net/unix'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.0.40-pre1/net/unix'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
af_unix.o 
af_unix.
c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
garbage.o 
garbage.
c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
sysctl_net_unix.o 
sysctl_net_unix.c
rm -f unix.o
ld -m elf_i386  -r -o unix.o  af_unix.o garbage.o sysctl_net_unix.o
make[3]: Leaving directory `/usr/src/linux-2.0.40-pre1/net/unix'
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/net/unix'
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/net/802'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.0.40-pre1/net/802'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
p8023.o p8023.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
sysctl_net_802.
o 
sysctl_net_802.c
rm -f 802.o
ld -m elf_i386  -r -o 802.o  p8023.o sysctl_net_802.o
make[3]: Leaving directory `/usr/src/linux-2.0.40-pre1/net/802'
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/net/802'
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/net/ipv4'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.0.40-pre1/net/ipv4'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
utils.o utils.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
route.o route.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
proc.o proc.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
timer.o timer.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
protocol.o 
protocol.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
packet.o 
packet.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
ip_input.o 
ip_input.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
ip_fragment.o 
ip_fragment.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
ip_forward.o 
ip_forward.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
ip_options.o 
ip_options.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
ip_output.o 
ip_output.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
ip_sockglue.o 
ip_sockglue.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
tcp.o tcp.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
tcp_input.o 
tcp_input.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
tcp_output.o 
tcp_output.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
tcp_timer.o 
tcp_timer.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
raw.o raw.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
udp.o udp.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
arp.o arp.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
icmp.o icmp.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
devinet.o 
devinet.
c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
af_inet.o 
af_inet.
c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
igmp.o igmp.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
ip_fw.o ip_fw.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
sysctl_net_ipv4.o 
sysctl_net_ipv4.c
rm -f ipv4.o
ld -m elf_i386  -r -o ipv4.o  utils.o route.o proc.o timer.o protocol.o packet.o ip_input.o ip_fragment.o 
ip_forward.
o 
ip_options.o ip_output.o ip_sockglue.o tcp.o tcp_input.o tcp_output.o tcp_timer.o raw.o udp.o arp.o icmp.o 
devinet.o 
af_inet.o igmp.o ip_fw.o sysctl_net_ipv4.o
make[3]: Leaving directory `/usr/src/linux-2.0.40-pre1/net/ipv4'
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/net/ipv4'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/net'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
socket.o 
socket.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
protocols.o 
protocols.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
sysctl_net.o 
sysctl_net.c
rm -f network.a
ar  rcs network.a  socket.o protocols.o sysctl_net.o core/core.o ethernet/ethernet.o unix/unix.o 802/802.o 
ipv4/ipv4.
o
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/net'
make[1]: Leaving directory `/usr/src/linux-2.0.40-pre1/net'
make[1]: Entering directory `/usr/src/linux-2.0.40-pre1/ipc'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/ipc'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
util.o util.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
msg.o msg.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
sem.o sem.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
shm.o shm.c
rm -f ipc.o
ld -m elf_i386  -r -o ipc.o  util.o msg.o sem.o shm.o
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/ipc'
make[1]: Leaving directory `/usr/src/linux-2.0.40-pre1/ipc'
make[1]: Entering directory `/usr/src/linux-2.0.40-pre1/lib'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.0.40-pre1/lib'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
errno.o errno.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
ctype.o ctype.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
string.o 
string.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
vsprintf.o 
vsprintf.c
rm -f lib.a
ar  rcs lib.a  errno.o ctype.o string.o vsprintf.o
make[2]: Leaving directory `/usr/src/linux-2.0.40-pre1/lib'
make[1]: Leaving directory `/usr/src/linux-2.0.40-pre1/lib'
make[1]: Entering directory `/usr/src/linux-2.0.40-pre1/arch/i386/kernel'
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
apm.o apm.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
process.o 
process.
c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
signal.o 
signal.c
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -D__ASSEMBLY__ -traditional -c entry.S -o entry.o
gcc -D__KERNEL__ -I/usr/src/linux-2.0.40-pre1/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strength-reduce -pipe -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686  -c -o 
traps.o traps.c
make[1]: Leaving directory `/usr/src/linux-2.0.40-pre1/arch/i386/kernel'


< .config >

#
# Automatically generated by make menuconfig: don't edit
#

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# General setup
#
# CONFIG_MATH_EMULATION is not set
CONFIG_MEM_STD=y
# CONFIG_MEM_ENT is not set
# CONFIG_MEM_SPECIAL is not set
CONFIG_MAX_MEMSIZE=1024
CONFIG_NET=y
# CONFIG_MAX_16M is not set
CONFIG_PCI=y
CONFIG_SYSVIPC=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_KERNEL_ELF=y
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
CONFIG_M686=y
# CONFIG_MTRR is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_POWER_OFF=y
# CONFIG_APM_IGNORE_MULTIPLE_SUSPEND is not set

#
# Floppy, IDE, and other block devices
#
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_BLK_DEV_IDE_PCMCIA is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_TRITON is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_HD is not set

#
# Networking options
#
# CONFIG_FIREWALL is not set
# CONFIG_NET_ALIAS is not set
CONFIG_INET=y
# CONFIG_IP_FORWARD is not set
# CONFIG_IP_MULTICAST is not set
CONFIG_SYN_COOKIES=y
# CONFIG_IP_ACCT is not set
# CONFIG_IP_ROUTER is not set
# CONFIG_NET_IPIP is not set
# CONFIG_INET_PCTCP is not set
# CONFIG_INET_RARP is not set
# CONFIG_NO_PATH_MTU_DISCOVERY is not set
CONFIG_IP_NOSR=y
CONFIG_SKB_LARGE=y
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_AX25 is not set
# CONFIG_NETLINK is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
# CONFIG_EQUALIZER is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_RADIO is not set
CONFIG_NET_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_SMC is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_EEXPRESS_PRO100B is not set
# CONFIG_DE4X5 is not set
# CONFIG_DEC_ELCP is not set
# CONFIG_DGRS is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_RTL8139=y
# CONFIG_EPIC is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_EISA is not set
# CONFIG_NET_POCKET is not set
# CONFIG_TR is not set
# CONFIG_FDDI is not set
# CONFIG_ARCNET is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# CD-ROM drivers (not for SCSI or IDE/ATAPI drives)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Filesystems
#
# CONFIG_QUOTA is not set
# CONFIG_MINIX_FS is not set
# CONFIG_EXT_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_XIA_FS is not set
CONFIG_NLS=y
CONFIG_ISO9660_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y

#
# Select available code pages
#
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
CONFIG_PROC_FS=y
# CONFIG_NFS_FS is not set
# CONFIG_SMB_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Character devices
#
CONFIG_SERIAL=y
# CONFIG_DIGI is not set
# CONFIG_CYCLADES is not set
# CONFIG_STALDRV is not set
# CONFIG_RISCOM8 is not set
# CONFIG_PRINTER is not set
# CONFIG_SPECIALIX is not set
# CONFIG_MOUSE is not set
# CONFIG_UMISC is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_FTAPE is not set
# CONFIG_WATCHDOG is not set
CONFIG_RTC=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# Kernel hacking
#
# CONFIG_PROFILE is not set

----
Seiichi Nakashima  nakasei@fa.mdis.co.jp
