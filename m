Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbREOVP2>; Tue, 15 May 2001 17:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261549AbREOVPS>; Tue, 15 May 2001 17:15:18 -0400
Received: from 513.holly-springs.nc.us ([216.27.31.173]:53137 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S261546AbREOVPH>; Tue, 15 May 2001 17:15:07 -0400
Date: Tue, 15 May 2001 17:14:49 -0400
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: linux-kernel@vger.kernel.org
Subject: OOPS - 2.2.19, USB, Scanner
Message-ID: <20010515171449.A12348@513.holly-springs.nc.us>
Mail-Followup-To: Michael Rothwell <rothwell@holly-springs.nc.us>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just your friendly neighborhood oops report. Unfortunately, the kernel didn't log very much:

May 14 18:00:49 gateway kernel: scanner.c: read_scanner(0): funky result:-32. Please notify the maintainer. 
May 14 18:01:13 gateway PAM_pwdb[10338]: (login) session opened for user rothwell by (uid=0)
May 14 18:01:21 gateway PAM_pwdb[10364]: (su) session opened for user root by rothwell(uid=500)
May 14 18:01:46 gateway kernel: usb.c: USB disconnect on device 2 
May 14 18:02:00 gateway kernel: usb.c: USB new device connect, assigned device number 2 
May 14 18:02:09 gateway kernel: usb.c: deregistering driver ibmcam 
May 14 18:02:09 gateway kernel: usb.c: USB disconnect on device 1 
May 14 18:02:09 gateway kernel: usb.c: USB disconnect on device 2 
May 14 18:02:09 gateway kernel: usb.c: USB bus 1 deregistered 
May 14 18:02:09 gateway kernel: kmem_destroy: Can't free all objects c7fffb00 
May 14 18:02:09 gateway kernel: uhci: not all urb_priv's were freed 
May 14 18:02:09 gateway kernel: kmem_destroy: Can't free all objects c7fffaa0 
May 14 18:02:09 gateway kernel: uhci: not all QH's were freed 
May 14 18:02:09 gateway kernel: kmem_destroy: Can't free all objects c7fffa40 
May 14 18:02:09 gateway kernel: uhci: not all TD's were freed 
May 14 18:02:30 gateway kernel: usb_control/bulk_msg: timeout 
May 14 18:02:30 gateway kernel: Unable to handle kernel paging request at virtual address c886f350 
May 14 18:02:30 gateway kernel: current->tss.cr3 = 00101000, %%cr3 = 00101000 
May 14 18:02:30 gateway kernel: *pde = 07ffa063 
May 14 18:02:30 gateway kernel: *pte = 00000000 
May 14 18:02:30 gateway kernel: Oops: 0000 
May 14 18:02:30 gateway kernel: CPU:    0 

... the scanner appeared to hang while using SANE. I attempted to rmmod the usb modules, including scanner.o, and uhci.o. Oops.

-M

