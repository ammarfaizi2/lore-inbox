Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbUKLOnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbUKLOnj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 09:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUKLOmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 09:42:40 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:35207 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S262537AbUKLOhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 09:37:22 -0500
Date: Fri, 12 Nov 2004 14:37:21 +0000
From: Karel Kulhavy <clock@twibright.com>
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/bus/i2c is missing
Message-ID: <20041112143721.GA19867@beton.cybernet.src>
References: <2E314DE03538984BA5634F12115B3A4E01BC4070@email1.mitretek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E314DE03538984BA5634F12115B3A4E01BC4070@email1.mitretek.org>
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 09:22:46AM -0500, Piszcz, Justin Michael wrote:
> You need the core i2c modules loaded.

I have "<*> I2C support" and "<*> I2C device interface" switched on in make
menuconfig (non-modular). I skimmed through the whole I2C support submenu
and didn't find any i2c core. Just i2c core debugging messages, but it isn't
probably what you mean.

Which option in make menuconfig is i2c_core?

And btw I found this:
root@oberon:/usr/src/linux-2.6.8.1-patched/drivers/i2c/busses# find /sys/bus/i2c/sys/bus/i2c
/sys/bus/i2c/drivers
/sys/bus/i2c/drivers/pcf8591
/sys/bus/i2c/drivers/lm85
/sys/bus/i2c/drivers/lm85/0-002e
/sys/bus/i2c/drivers/eeprom
/sys/bus/i2c/drivers/eeprom/0-0052
/sys/bus/i2c/drivers/eeprom/0-0050
/sys/bus/i2c/drivers/dev_driver
/sys/bus/i2c/drivers/i2c_adapter
/sys/bus/i2c/devices
/sys/bus/i2c/devices/0-002e
/sys/bus/i2c/devices/0-0052
/sys/bus/i2c/devices/0-0050

Isn't it what the documentation talks about as /proc/bus/i2c? Or is it
something different?

Cl<
> 
> $ lsmod
> Module                  Size  Used by
> adm1021                12092  0
> i2c_piix4               5648  0
> i2c_sensor              2912  1 adm1021
> i2c_dev                 7776  0
> i2c_core               19312  4 adm1021,i2c_piix4,i2c_sensor,i2c_dev
> 
> 
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Karel Kulhavy
> Sent: Friday, November 12, 2004 9:12 AM
> To: linux-kernel@vger.kernel.org
> Subject: /proc/bus/i2c is missing
> 
> Hello
> 
> linux 2.6.8.1
> 
> I insmoded i2c-parport and pcf8591 modules and i2c-1 appeared in my /dev
> (previously, only i2c-0 was there):
> 
> 	clock@oberon:~$ ls /dev/i2* 
> 	/dev/i2c-0  /dev/i2c-1
> 	
> 	/dev/i2c:
> 	0  1
> 
> /usr/src/linux/Documentation/i2c says "You can
> examine /proc/bus/i2c to see what number corresponds to which adapter."
> I don't have any /proc/i2c:
> 
> 	clock@oberon:~$ ls /proc/i2c
> 	ls: /proc/i2c: No such file or directory
> 
> However, I have /proc:
> 	clock@oberon:~$ ls /proc
> 	             devices      mtrr
> 	             diskstats    net
> 	             dma          partitions
> 	             driver       pci
> 	             execdomains  scsi
> 	             filesystems  self
> 	             fs           slabinfo
> 	             ide          stat
> 	             interrupts   swaps
> 	  [...]      iomem        sys
> 	             ioports      sysrq-trigger
> 	             irq          sysvipc
> 	             kallsyms     tty
> 	             kcore        uptime
> 	             kmsg         version
> 	             loadavg      vmstat
> 	             locks
> 	  buddyinfo  mdstat
> 	  bus        meminfo
> 	  cmdline    misc
> 	  config.gz  modules
> 	  cpuinfo    mounts
> 
> How can I make /proc/i2c appear?
> 
> Cl<
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
