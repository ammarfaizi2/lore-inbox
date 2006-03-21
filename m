Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751841AbWCUXS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbWCUXS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 18:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWCUXS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 18:18:57 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:57477 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751841AbWCUXS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 18:18:56 -0500
Message-ID: <442089CB.1000008@comcast.net>
Date: Tue, 21 Mar 2006 18:18:35 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@lxorguk.ukuu.org.uk
Subject: 2.6.16-rc6-ide1 irq trap, io hang problem solved?
Content-Type: multipart/mixed;
 boundary="------------060802050900080108010207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060802050900080108010207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've seen some traffic here to suggest that the problem was tracked 
down, but I saw nothing about it being solved completely.  Currently my 
system hangs whenever an irq trap message appears, usually after some 
sort of disk io on SATA drives. Is it fixed in the GIT patchset recently 
posted or is this still open?  

0000:00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2) 
(prog-if 8a [Master SecP PriP])

0000:00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA 
Controller (rev f3) (prog-if 85 [Master SecO PriO])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 815a
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 225


Attached are the hdparm -I's of the drives except atapi.
If it's too big they'll be available at
http://signal-lost.homeip.net/files/sda.txt
http://signal-lost.homeip.net/files/sdb.txt
http://signal-lost.homeip.net/files/sdc.txt
http://signal-lost.homeip.net/files/sdd.txt



--------------060802050900080108010207
Content-Type: text/plain;
 name="sda.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sda.txt"


/dev/sda:

ATA device, with non-removable media
	Model Number:       Maxtor 6L200S0                          
	Serial Number:      L50Q31GH            
	Firmware Revision:  BACE1G10
Standards:
	Supported: 7 6 5 4 
	Likely used: 7
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors:  398297088
	device size with M = 1024*1024:      194481 MBytes
	device size with M = 1000*1000:      203928 MBytes (203 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 1
	Advanced power management level: unknown setting (0x0000)
	Recommended acoustic management value: 192, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	NOP cmd
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
	   *	48-bit Address feature set 
	   *	Automatic Acoustic Management feature set 
		SET MAX security extension
		Advanced Power Management feature set
	   *	DOWNLOAD MICROCODE cmd
	   *	General Purpose Logging feature set
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
Checksum: correct

--------------060802050900080108010207
Content-Type: text/plain;
 name="sdb.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sdb.txt"


/dev/sdb:

ATA device, with non-removable media
	Model Number:       Maxtor 6L200S0                          
	Serial Number:      L50P6WMH            
	Firmware Revision:  BACE1G10
Standards:
	Supported: 7 6 5 4 
	Likely used: 7
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors:  398297088
	device size with M = 1024*1024:      194481 MBytes
	device size with M = 1000*1000:      203928 MBytes (203 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 1
	Advanced power management level: unknown setting (0x0000)
	Recommended acoustic management value: 192, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	NOP cmd
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
	   *	48-bit Address feature set 
	   *	Automatic Acoustic Management feature set 
		SET MAX security extension
		Advanced Power Management feature set
	   *	DOWNLOAD MICROCODE cmd
	   *	General Purpose Logging feature set
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
Checksum: correct

--------------060802050900080108010207
Content-Type: text/plain;
 name="sdc.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sdc.txt"


/dev/sdc:

ATA device, with non-removable media
	Model Number:       Maxtor 6Y120P0                          
	Serial Number:      Y40D924E            
	Firmware Revision:  YAR41VW0
Standards:
	Supported: 7 6 5 4 
	Likely used: 7
Configuration:
	Logical		max	current
	cylinders	16383	0
	heads		16	0
	sectors/track	63	0
	--
	LBA    user addressable sectors:  240121728
	device size with M = 1024*1024:      117246 MBytes
	device size with M = 1000*1000:      122942 MBytes (122 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 1
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 1
	Advanced power management level: unknown setting (0x0000)
	Recommended acoustic management value: 192, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	NOP cmd
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
	   *	Automatic Acoustic Management feature set 
		SET MAX security extension
		Advanced Power Management feature set
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
HW reset results:
	CBLID- above Vih
	Device num = 0 determined by the jumper
Checksum: correct

--------------060802050900080108010207
Content-Type: text/plain;
 name="sdd.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sdd.txt"


/dev/sdd:

ATA device, with non-removable media
	Model Number:       WDC WD1000BB-00CAA0                     
	Serial Number:      WD-WMA8C1134895
	Firmware Revision:  16.06V16
Standards:
	Supported: 5 4 3 2 
	Likely used: 6
Configuration:
	Logical		max	current
	cylinders	16383	0
	heads		16	0
	sectors/track	63	0
	--
	LBA    user addressable sectors:  195371568
	device size with M = 1024*1024:       95396 MBytes
	device size with M = 1000*1000:      100030 MBytes (100 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 40	Queue depth: 1
	Standby timer values: spec'd by Standard, with device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 1
	Recommended acoustic management value: 128, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	Device Configuration Overlay feature set 
	   *	Automatic Acoustic Management feature set 
		SET MAX security extension
	   *	DOWNLOAD MICROCODE cmd
Security: 
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
HW reset results:
	CBLID- above Vih
	Device num = 1 determined by the jumper
Checksum: correct

--------------060802050900080108010207--
