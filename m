Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbUCHVEf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbUCHVEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:04:35 -0500
Received: from mail0.lsil.com ([147.145.40.20]:42926 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261230AbUCHVE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:04:27 -0500
Message-ID: <53CF1076699CD711B7DD0002A51363F102C36031@exw-ks.ks.lsil.com>
From: "Dachepalli, Sudhir" <sudhir.dachepalli@lsil.com>
To: "'Linux-Kernel (E-mail)'" <linux-kernel@vger.kernel.org>
Subject: Help in setting up serial console on 64 bit machine
Date: Mon, 8 Mar 2004 15:04:04 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello SerialConsole user,
 
         I have a problem while setting up serial console to direct kernel
printk
messages to serial console. I dont see messages getting displayed.
 
My setup
---------
1. IA 64 machine.
2. Redhat AS 3.0
3. Kernel 2.4.18-e.37smp
4. Server Hardware : HP rx5670
 
Serial Console setup
--------------------
1. I have connected serial cable between two linux terminals.
2. open minicom on both servers.
3. changed the settings to 9600-8-n-1, no h/w flow control, no s/w flow
control, stop bits =1.
4. I typed some charecters on server 1 and saw the charecters appear in
server 2's minicom.
5. I typed some charecters on server 2 and saw the charecters appear in
server 1's minicom.
6. I have changed the kernel command line for booting the kernel . PLEASE
SEE BELOW FOR "elilo.conf".
7. label=serial ( elilo  entry to boot the serial console setup. )
8. I have also checked the options in "make menuconfig" and found everything
correct for serial console setup.
 
After selecting "label=serial" and botting the OS the following is the
command line from proc.
[root@beast root]# cat /proc/cmdline
BOOT_IMAGE=scsi0:EFI\redhat\vmlinuz-2.4.18-e.37smp  root=LABEL=/
console=ttyS1,9600n8 console=tty0 ro
 
The kernel cmdline seems to be correct but the messages are not directed on
console.
I have setup serial consoles on 32 bit machines earlier, but not on 64 bit.
 
Please throw me some pointers to make it work.
 
 
regards,
sudhir dachepalli
 
 
 
[root@beast root]# uname -a
Linux beast 2.4.18-e.37smp #1 SMP Tue Aug 5 16:07:26 EDT 2003 ia64 unknown
 
[root@beast root]# cat /etc/*release*
Red Hat Linux Advanced Server release 2.1AS (Derry)
prompt
timeout=50
default=2.4.18-e.37smp
 
image=vmlinuz-2.4.18-e.37
 label=2.4.18-e.37
 initrd=initrd-2.4.18-e.37.img
 read-only
 append="root=LABEL=/"
 
image=vmlinuz-2.4.18-e.37
 label=scsi-128
 initrd=scsi-128.img
 read-only
 root=/dev/sda4
 
image=vmlinuz-2.4.18-e.37smp
 label=2.4.18-e.37smp
 initrd=initrd-2.4.18-e.37smp.img
 read-only
 append="root=LABEL=/"
 
image=vmlinuz-2.4.18-e.37smp
 label=serial
 initrd=initrd-2.4.18-e.37smp.img
 read-only
 append="root=LABEL=/ console=ttyS1,9600n8 console=tty0"
 
image=vmlinuz-2.4.18-e.37smp
 label=lyq
 initrd=lyq.img
 read-only
 append="root=LABEL=/"
 
image=vmlinuz-2.4.18-e.37smp
 label=mpp
 initrd=mpp.img
 read-only
 root=/dev/sda4
 
image=vmlinuz-2.4.18-e.12smp
 label=linux
 initrd=initrd-2.4.18-e.12smp.img
 read-only
 root=/dev/sda4
 
image=vmlinuz-2.4.18-e.12
 label=linux-up
 initrd=initrd-2.4.18-e.12.img
 read-only
 root=/dev/sda4
 
 
-
To unsubscribe from this list: send the line "unsubscribe linux-serial" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
