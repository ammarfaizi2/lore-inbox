Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317054AbSGSVSH>; Fri, 19 Jul 2002 17:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317036AbSGSVSH>; Fri, 19 Jul 2002 17:18:07 -0400
Received: from flaske.stud.ntnu.no ([129.241.56.72]:24536 "EHLO
	flaske.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S317030AbSGSVSE>; Fri, 19 Jul 2002 17:18:04 -0400
Date: Fri, 19 Jul 2002 23:21:06 +0200
From: Thomas =?iso-8859-1?Q?Lang=E5s?= <tlan@stud.ntnu.no>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.4.18 and 2.4.19 problems
Message-ID: <20020719212106.GA14331@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
References: <20020719192607.GA13880@stud.ntnu.no> <20020719140416.A25577@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020719140416.A25577@eng2.beaverton.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield:
> So this is the dmesg for the redhat 2.4.18-3? You said above that
> it found the disks, but, further down the qla driver inits and shows:

I did a dmesg on one of the machines currently without disks, but, the
error shown below is what we get with the std linux-kernel; 
"Cable unplugged".  

This is from our syslog from when we booted up one machine with drives:
kern.info:Jul 19 16:53:45 gekko.stud.ntnu.no kernel: qla2x00_set_info starts at address = f8955060 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: qla2x00: Found  VID=1077 DID=2200 SSVID=1077 SSDID=2 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi1: Found a QLA2200  @ bus 0, device 0x0, irq 16, iobase 0xdc00 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi(1): Allocated 4096 SRB(s) 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi(1): LIP reset occurred 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi(1): Waiting for LIP to complete... 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi(1): LOOP UP detected 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi1: Topology - (F_Port), Host Loop address 0xffff 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi1: Host table full. 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi1: Topology - (F_Port), Host Loop address 0xffff 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi1: Host table full. 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi-qla0-adapter-node=200000e08b02894b; 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi-qla0-adapter-port=210000e08b02894b; 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi-qla0-target-0=2000005013d01808; 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi-qla0-target-1=2000005013d016d3; 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi-qla0-target-2=2000005013d0158d; 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi-qla0-target-3=2000005013d0154b; 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: qla2x00: Found  VID=1077 DID=2200 SSVID=1077 SSDID=2 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi2: Found a QLA2200  @ bus 0, device 0x0, irq 20, iobase 0xd800 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi(2): Allocated 4096 SRB(s) 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi(2): LIP reset occurred 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi(2): Waiting for LIP to complete... 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi(2): LOOP UP detected 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi2: Topology - (F_Port), Host Loop address 0xffff 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi2: Host table full. 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi2: Topology - (F_Port), Host Loop address 0xffff 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi2: Host table full. 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi(1): Waiting for LIP to complete... 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi-qla1-adapter-node=200000e08b02854b; 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi-qla1-adapter-port=210000e08b02854b; 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi-qla1-target-0=2000005013d01808; 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi-qla1-target-1=2000005013d016d3; 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi-qla1-target-2=2000005013d0158d; 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi-qla1-target-3=2000005013d0154b; 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi1 : QLogic QLA2200 PCI to Fibre Channel Host Adapter: bus 0 device 0 
irq 16 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi2 : QLogic QLA2200 PCI to Fibre Channel Host Adapter: bus 0 device 0 
irq 20 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi1: Topology - (F_Port), Host Loop address 0xffff 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi(1:0:0:0): Enabled tagged queuing, queue depth 16. 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi(1:0:1:0): Enabled tagged queuing, queue depth 16. 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi(1:0:2:0): Enabled tagged queuing, queue depth 16. 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi(1:0:3:0): Enabled tagged queuing, queue depth 16. 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi(2:0:0:0): Enabled tagged queuing, queue depth 16. 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi(2:0:0:1): Enabled tagged queuing, queue depth 16. 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi(2:0:1:0): Enabled tagged queuing, queue depth 16. 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi(2:0:2:0): Enabled tagged queuing, queue depth 16. 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel: scsi(2:0:3:0): Enabled tagged queuing, queue depth 16. 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel:  /dev/scsi/host1/bus0/target0/lun0: p1 
kern.info:Jul 19 16:53:54 gekko.stud.ntnu.no kernel:  /dev/scsi/host2/bus0/target0/lun1: p1 


(We've got an in-production system that we plan to migrate, so
we need it running untill we find a viable solution to this problem.)


> You might want to check the hardware and connections. I've seen the qla
> (I'm using some beta6 with 2.5.25) get confused as to the state of the
> adapter and its connection.

This is actually the first time I ever see this, never seen it before, and
we've been using qla for one year now, this august. Started seeing this
odd behaviour with qla and vanilla kernel, together with Dell's 2650
(Dual P4 Xeon).

> If you turn on scsi logging (be careful, if syslog is running you can get
> infinite logging), and insmod your driver, you might get some useful
> information, I use:
> 	echo scsi log scan 5  >/proc/scsi/scsi
> The above is safe to use with syslog running (since it logs the scsi
> scanning that happens when the adapter comes up, but not all IO).
> Also, cat /proc/scsi/scsi and /proc/scsi/qla*/[0-9] and see what they show.

I'll try this when I get back to work over the weekend.

> If the adapter appears to find devices, but scanning does not (likely
> lun problems), try manually scanning for a device, for example:
> 	echo scsi add-single-device 1 0 0 0 >/proc/scsi/scsi
> Where the numbering above is host, channel, target-id, and then lun.

We did try this tho, but I'm unsure on which of the kernels, etc, it was
getting late and we had to get the other system back online for the 
weekend.  I'll get back to you on this on monday.

-- 
Thomas
