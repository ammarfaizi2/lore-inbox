Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317454AbSHCDbO>; Fri, 2 Aug 2002 23:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317457AbSHCDbO>; Fri, 2 Aug 2002 23:31:14 -0400
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:46808 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S317454AbSHCDbN>; Fri, 2 Aug 2002 23:31:13 -0400
Message-ID: <3D4B4F1D.8080901@linuxhq.com>
Date: Fri, 02 Aug 2002 23:33:49 -0400
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: scsi_mod unresolved symbol elv_queue_empty
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently, there is an error resolving the symbol elv_queue_empty in 
scsi_mod.o.  The only file that I know calls this function is 
ll_rw_blk.c, but it does include blk.h (which includes elevator.h).  So 
I am at a loss... any suggestions?

[1.] Unresolved symbol in scsi_mod
[2.] Unresolved symbol in scsi_mod.o (elv_queue_empty)
[3.] kernel, modules, scsi
[4.] Linux version 2.5.30 (root@boolean) (gcc version 3.2 20020720 (Red 
Hat Linux Rawhide 3.2-0.1)) #3 Fri Aug 2 11:38:01 EDT 2002
[5.]
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.30; fi
depmod: *** Unresolved symbols in 
/lib/modules/2.5.30/kernel/drivers/scsi/scsi_mod.o
depmod:         elv_queue_empty

[6.] N/A

[7.1.] Software
Gnu C                  gcc 3.2 20020720
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.19
e2fsprogs              1.27
pcmcia-cs              3.1.31
PPP                    2.4.1
Linux C Library        2.2.90
Dynamic linker (ldd)   2.2.90
Procps                 2.0.7
Net-tools              1.60
Kbd                    60:
Sh-utils               2.0.12

[7.2.] Processor
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : 00/08
stepping        : 1
cpu MHz         : 448.321
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 884.73

