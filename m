Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261306AbSJUJ1i>; Mon, 21 Oct 2002 05:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261307AbSJUJ1i>; Mon, 21 Oct 2002 05:27:38 -0400
Received: from ulima.unil.ch ([130.223.144.143]:32640 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S261306AbSJUJ1g>;
	Mon, 21 Oct 2002 05:27:36 -0400
Date: Mon, 21 Oct 2002 11:33:41 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.44 Call Trace
Message-ID: <20021021093341.GG2917@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got those:

Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace: [<c01d57b8>]  [<c01d575a>]  [<d91fc107>]  [<d92093e8>]  [<d9208d00>]  [<c01d7f68>]  [<d9209414>]  [<d92093e8>]  [<c01d6c65>]  [<d92093f4>]  [<d92093e8>]  [<c01d6d1f>]  [<d92093e8>]  [<c01cd36b>]  [<d9208d00>]  [<d9208d00>]  [<d91fbf6c>]  [<d9208d00>]  [<c02238b9>]  [<d9208d00>]  [<d91ff58a>]  [<d9208d00>]  [<c011c151>]  [<d91ed060>]  [<d91ed060>]  [<c010786b>] 
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 2940 SCSI adapter>
        aic7870: Single Channel A, SCSI Id=7, 16/253 SCBs

(scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 8)
  Vendor: LACIE     Model: CDRW-12432S       Rev: 1.21
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
end_request: I/O error, dev 03:40, sector 0
end_request: I/O error, dev 03:40, sector 0
Badness in put_device at drivers/base/core.c:139
Call Trace: [<c01d58fe>]  [<c022ecf0>]  [<c022319c>]  [<c0222f58>]  [<d9208d00>]  [<c0223adc>]  [<d9208d00>]  [<c0222ff0>]  [<c011cb23>]  [<d91ff5bf>]  [<d9208d00>]  [<c011d123>]  [<c011c3d3>]  [<c010786b>] 
Badness in put_device at drivers/base/core.c:139
Call Trace: [<c01d58fe>]  [<c022ae37>]  [<c022319c>]  [<c0222f58>]  [<d9208d00>]  [<c0223adc>]  [<d9208d00>]  [<c0222ff0>]  [<c011cb23>]  [<d91ff5bf>]  [<d9208d00>]  [<c011d123>]  [<c011c3d3>]  [<c010786b>] 
scsi : 0 hosts left.


Which gives:

dmesg | ksymoops -v /usr/src/linux/vmlinux -m /usr/src/linux/System.map 
ksymoops 2.4.5 on i686 2.5.44.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.44/ (default)
     -m /usr/src/linux/System.map (specified)

3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Call Trace: [<c01d57b8>]  [<c01d575a>]  [<d91fc107>]  [<d92093e8>]  [<d9208d00>]  [<c01d7f68>]  [<d9209414>]  [<d92093e8>]  [<c01d6c65>]  [<d92093f4>]  [<d92093e8>]  [<c01d6d1f>]  [<d92093e8>]  [<c01cd36b>]  [<d9208d00>]  [<d9208d00>]  [<d91fbf6c>]  [<d9208d00>]  [<c02238b9>]  [<d9208d00>]  [<d91ff58a>]  [<d9208d00>]  [<c011c151>]  [<d91ed060>]  [<d91ed060>]  [<c010786b>] 
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c01d57b8 <get_device+28/90>
Trace; c01d575a <device_register+4a/80>
Trace; d91fc107 <END_OF_CODE+c0804/????>
Trace; d92093e8 <END_OF_CODE+cdae5/????>
Trace; d9208d00 <END_OF_CODE+cd3fd/????>
Trace; c01d7f68 <driver_make_dir+28/30>
Trace; d9209414 <END_OF_CODE+cdb11/????>
Trace; d92093e8 <END_OF_CODE+cdae5/????>
Trace; c01d6c65 <put_driver+25/90>
Trace; d92093f4 <END_OF_CODE+cdaf1/????>
Trace; d92093e8 <END_OF_CODE+cdae5/????>
Trace; c01d6d1f <driver_register+4f/60>
Trace; d92093e8 <END_OF_CODE+cdae5/????>
Trace; c01cd36b <pci_register_driver+3b/50>
Trace; d9208d00 <END_OF_CODE+cd3fd/????>
Trace; d9208d00 <END_OF_CODE+cd3fd/????>
Trace; d91fbf6c <END_OF_CODE+c0669/????>
Trace; d9208d00 <END_OF_CODE+cd3fd/????>
Trace; c02238b9 <scsi_register_host+39/220>
Trace; d9208d00 <END_OF_CODE+cd3fd/????>
Trace; d91ff58a <END_OF_CODE+c3c87/????>
Trace; d9208d00 <END_OF_CODE+cd3fd/????>
Trace; c011c151 <sys_init_module+4e1/640>
Trace; d91ed060 <END_OF_CODE+b175d/????>
Trace; d91ed060 <END_OF_CODE+b175d/????>
Trace; c010786b <syscall_call+7/b>

Call Trace: [<c01d58fe>]  [<c022ecf0>]  [<c022319c>]  [<c0222f58>]  [<d9208d00>]  [<c0223adc>]  [<d9208d00>]  [<c0222ff0>]  [<c011cb23>]  [<d91ff5bf>]  [<d9208d00>]  [<c011d123>]  [<c011c3d3>]  [<c010786b>] 
Call Trace: [<c01d58fe>]  [<c022ae37>]  [<c022319c>]  [<c0222f58>]  [<d9208d00>]  [<c0223adc>]  [<d9208d00>]  [<c0222ff0>]  [<c011cb23>]  [<d91ff5bf>]  [<d9208d00>]  [<c011d123>]  [<c011c3d3>]  [<c010786b>] 
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c01d58fe <put_device+de/f0>
Trace; c022ecf0 <sg_detach+c0/220>
Trace; c022319c <scsi_host_chk_and_release+1ac/250>
Trace; c0222f58 <scsi_tp_for_each_host+78/90>
Trace; d9208d00 <END_OF_CODE+cd3fd/????>
Trace; c0223adc <scsi_unregister_host+3c/90>
Trace; d9208d00 <END_OF_CODE+cd3fd/????>
Trace; c0222ff0 <scsi_host_chk_and_release+0/250>
Trace; c011cb23 <qm_symbols+f3/1e0>
Trace; d91ff5bf <END_OF_CODE+c3cbc/????>
Trace; d9208d00 <END_OF_CODE+cd3fd/????>
Trace; c011d123 <free_module+e3/f0>
Trace; c011c3d3 <sys_delete_module+d3/2a0>
Trace; c010786b <syscall_call+7/b>
Trace; c01d58fe <put_device+de/f0>
Trace; c022ae37 <sr_detach+47/80>
Trace; c022319c <scsi_host_chk_and_release+1ac/250>
Trace; c0222f58 <scsi_tp_for_each_host+78/90>
Trace; d9208d00 <END_OF_CODE+cd3fd/????>
Trace; c0223adc <scsi_unregister_host+3c/90>
Trace; d9208d00 <END_OF_CODE+cd3fd/????>
Trace; c0222ff0 <scsi_host_chk_and_release+0/250>
Trace; c011cb23 <qm_symbols+f3/1e0>
Trace; d91ff5bf <END_OF_CODE+c3cbc/????>
Trace; d9208d00 <END_OF_CODE+cd3fd/????>
Trace; c011d123 <free_module+e3/f0>
Trace; c011c3d3 <sys_delete_module+d3/2a0>
Trace; c010786b <syscall_call+7/b>


2 warnings issued.  Results may not be reliable.

I don't know what to do with those???

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
