Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbUKLOXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbUKLOXC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 09:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbUKLOXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 09:23:02 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:29366 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S262531AbUKLOWt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 09:22:49 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-11.tower-45.messagelabs.com!1100269367!7363842!1
X-StarScan-Version: 5.4.2; banners=-,-,-
X-Originating-IP: [66.10.26.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: /proc/bus/i2c is missing
Date: Fri, 12 Nov 2004 09:22:46 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC4070@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: /proc/bus/i2c is missing
Thread-Index: AcTIwdK0GhOhobP+R0Gk6HgFrscDpQAASSEg
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Karel Kulhavy" <clock@twibright.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You need the core i2c modules loaded.

$ lsmod
Module                  Size  Used by
adm1021                12092  0
i2c_piix4               5648  0
i2c_sensor              2912  1 adm1021
i2c_dev                 7776  0
i2c_core               19312  4 adm1021,i2c_piix4,i2c_sensor,i2c_dev


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Karel Kulhavy
Sent: Friday, November 12, 2004 9:12 AM
To: linux-kernel@vger.kernel.org
Subject: /proc/bus/i2c is missing

Hello

linux 2.6.8.1

I insmoded i2c-parport and pcf8591 modules and i2c-1 appeared in my /dev
(previously, only i2c-0 was there):

	clock@oberon:~$ ls /dev/i2* 
	/dev/i2c-0  /dev/i2c-1
	
	/dev/i2c:
	0  1

/usr/src/linux/Documentation/i2c says "You can
examine /proc/bus/i2c to see what number corresponds to which adapter."
I don't have any /proc/i2c:

	clock@oberon:~$ ls /proc/i2c
	ls: /proc/i2c: No such file or directory

However, I have /proc:
	clock@oberon:~$ ls /proc
	             devices      mtrr
	             diskstats    net
	             dma          partitions
	             driver       pci
	             execdomains  scsi
	             filesystems  self
	             fs           slabinfo
	             ide          stat
	             interrupts   swaps
	  [...]      iomem        sys
	             ioports      sysrq-trigger
	             irq          sysvipc
	             kallsyms     tty
	             kcore        uptime
	             kmsg         version
	             loadavg      vmstat
	             locks
	  buddyinfo  mdstat
	  bus        meminfo
	  cmdline    misc
	  config.gz  modules
	  cpuinfo    mounts

How can I make /proc/i2c appear?

Cl<
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
