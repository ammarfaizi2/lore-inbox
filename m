Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130927AbRAYSRV>; Thu, 25 Jan 2001 13:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135702AbRAYSRL>; Thu, 25 Jan 2001 13:17:11 -0500
Received: from scl-ims.phoenix.com ([134.122.1.73]:1806 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP
	id <S135670AbRAYSQx> convert rfc822-to-8bit; Thu, 25 Jan 2001 13:16:53 -0500
Message-ID: <D973CF70008ED411B273009027893BA409723E@irv-exch.phoenix.com>
From: David Christensen <David_Christensen@Phoenix.com>
To: "'Ondrej Sury'" <ondrej@globe.cz>, linux-kernel@vger.kernel.org
Subject: RE: 2.4.1-pre10 slowdown at boot.
Date: Thu, 25 Jan 2001 10:16:50 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-2"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you haven't already received this suggestion, remove the ACPI support
from the kernel and see if the situation improves.  The message "System
firmware supports: C2" indicates that your system supports CPU throttling,
which could cause the slowdown you describe.

Dave

-----Original Message-----
From: Ondrej Sury [mailto:ondrej@globe.cz]
Sent: Thursday, January 25, 2001 8:23 AM
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-pre10 slowdown at boot.



2.4.1-pre10 slows down after printing those (maybe ACPI or reiserfs issue),
and even SysRQ-(s,u,b) is not imediate and waits several (two+) seconds
before (syncing,remounting,booting).

ACPI: System description tables found
ACPI: System description tables loaded
ACPI: Subsystem enabled
ACPI: System firmware supports: C2
ACPI: System firmware supports: S0 S1 S4 S5
reiserfs: checking transaction log (device 03:04) ...
Warning, log replay starting on readonly filesystem


#### OTHER INFO ####

# mount
/dev/hda4 on / type reiserfs (rw,default,default)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
shm on /dev/shm type shm (rw)
/dev/hda2 on /mnt/store type vfat
(rw,default,umask=000,quiet,uni_xlate,nonumtail,codepage=852,iocharset=iso88
59-2)

# cat /proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 3
model name	: AMD Duron(tm) Processor
stepping	: 0
cpu MHz		: 601.378
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1199.30

# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev
02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 22)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 20)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev
01)

-- 
Ondøej Surý <ondrej@globe.cz>         Globe Internet s.r.o. http://globe.cz/
Tel: +420235365000   Fax: +420235365009         Plánièkova 1, 162 00 Praha 6
Mob: +420605204544   ICQ: 24944126             Mapa: http://globe.namape.cz/
GPG fingerprint:          CC91 8F02 8CDE 911A 933F  AE52 F4E6 6A7C C20D F273
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
