Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424381AbWLBTDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424381AbWLBTDi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 14:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424382AbWLBTDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 14:03:38 -0500
Received: from mail.1dial.com ([64.136.164.73]:27917 "EHLO
	MAIL02.inside.adbasesystems.com") by vger.kernel.org with ESMTP
	id S1424381AbWLBTDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 14:03:38 -0500
X-Modus-ReverseDNS: OK
X-Modus-BlackList: 64.124.13.3=OK;MrUmunhum@popdial.com=OK
X-Modus-RBL: 64.124.13.3=OK
X-Modus-Trusted: 64.124.13.3=NO
X-Modus-Audit: FALSE;0;0;0
Message-ID: <4571CE06.4040800@popdial.com>
Date: Sat, 02 Dec 2006 11:03:34 -0800
From: William Estrada <MrUmunhum@popdial.com>
Reply-To: MrUmunhum@popdial.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Mounting NFS root FS
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

  I have been trying to make FC5's kernel do a boot with an NFS root file system.  I see
the support is in the kernel(?).  I have tried this:

> [root@Server ~]# cat /tftpboot/pxelinux.cfg/0A0101
> SERIAL 0 9600
> Say
> 
> SAY Hello
> 
> SAY Trying NFS
> SAY ramdisk_size=10000 debug ip=dhcp initrd=NFS/initrd.gz lang=us apm=power-off console=ttyS0,9600 console=tty0 quiet root=/dev/nfs nfsroot=10.1.1.12:/tftpboot/NFS/Root_FS init=/bin/bash
> 
> Default NFS/vmlinuz
> 
> append  ramdisk_size=10000 debug ip=10.1.1.50 initrd=NFS/initrd.gz lang=us apm=power-off console=ttyS0,9600 console=tty0 quiet  root=/dev/nfs nfsroot=10.1.1.12:/tftpboot/NFS/Root_FS init=/bin/bash

  I get "mount: could not find file system: '/dev/root'" and then a kernel panic.

  I am using the FC5 kernel and the FC5 initrd.gz as you can see above.  

> [root@Server ~]# ls -lrt /tftpboot/NFS/
> total 2636
> drwxr-xr-x  4 root root    4096 Nov 26 18:41 SAVE
> -rwxr-xr-x  1 root root  932077 Nov 26 18:51 initrd.gz
> drwxr-xr-x 13 root root    4096 Nov 26 19:18 Root_FS
> -rwxr-xr-x  1 root root 1732515 Nov 26 19:37 vmlinuz

  I tried to build a new kernel many times, but that process failed.

  Am I missing something?  Do I need to change linuxrc?  Does someone have a simple example
of how to do an NFS Root FS?

  Would appreciate any points.

-- 
  Thanks for your time.

William Estrada

Email      : MrUmunhum at popdial dot com
Resume     : www.Mt-Umunhum-Wireless.net/resume/william_estrada.html
HTTP       : www.Mt-Umunhum-Wireless.net
