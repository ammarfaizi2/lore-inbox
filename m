Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132603AbRDELld>; Thu, 5 Apr 2001 07:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132607AbRDELlY>; Thu, 5 Apr 2001 07:41:24 -0400
Received: from master.tardis.ed.ac.uk ([193.62.81.6]:34551 "HELO
	master.tardis.ed.ac.uk") by vger.kernel.org with SMTP
	id <S132603AbRDELlL>; Thu, 5 Apr 2001 07:41:11 -0400
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: make oldconfig can change Alpha system type on 2.2.19
Date: Thu, 05 Apr 2001 12:40:25 +0100
From: Brian Campbell <bacam@tardis.ed.ac.uk>
Message-Id: <20010405114026.9D2707AE2@omega.tardis.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    
make oldconfig can change Alpha system type on 2.2.19

[2.] Full description of the problem/report:
With the system type set to `Cabriolet' (CONFIG_ALPHA_CABRIOLET)
running make oldconfig causes it to change to `EB64+' (CONFIG_ALPHA_EB64P)
without asking.

(See end for probable cause.)

[3.] Keywords (i.e., modules, networking, kernel):
kernel, configuration, alpha

[4.] Kernel version (from /proc/version):
Linux version 2.2.19 (bacam@kamelion) (gcc version 2.95.2 20000220
(Debian GNU/Linux)) #8 Thu Apr 5 10:42:25 BST 2001

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
N/A

[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux kamelion 2.2.19 #8 Thu Apr 5 10:42:25 BST 2001 alpha unknown
 
Gnu C                  2.95.2
Gnu make               3.78.1
binutils               2.9.5.0.37
util-linux             2.10f
modutils               2.3.11
e2fsprogs              1.18
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.54
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         ne 8390 rtl8139 tulip


[7.2.] Processor information (from /proc/cpuinfo):

cpu                     : Alpha
cpu model               : EV4
cpu variation           : 0
cpu revision            : 0
cpu serial number       : Linux_is_Great!
system type             : EB64+
system variation        : Cabriolet
system revision         : 0
system serial number    : MILO-0000
cycle frequency [Hz]    : 0 
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 34
max. addr. space #      : 63
BogoMIPS                : 268.43
kernel unaligned acc    : 7 (pc=fffffc00003947f4,va=11ffffe9a)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : N/A
cpus detected           : 0

[7.3.] Module information (from /proc/modules):
N/A

[7.4.] SCSI information (from /proc/scsi/scsi)
N/A

[7.5.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
        think to be relevant):

[X.] Other notes, patches, fixes, workarounds:

The Configure script chooses the old value for a `choice' by testing
each possibility in turn and using the last one.  Now choosing
Carbriolet also sets EB64P, but EB64P is later in the choice list and
thus is chosen as the default (and the Cabriolet setting is ignored).

