Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316269AbSEKTxW>; Sat, 11 May 2002 15:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316270AbSEKTxV>; Sat, 11 May 2002 15:53:21 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:18103 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S316269AbSEKTxV>; Sat, 11 May 2002 15:53:21 -0400
Message-ID: <3CDD7671.6010203@wanadoo.fr>
Date: Sat, 11 May 2002 21:52:17 +0200
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.15 IDE 60
In-Reply-To: <Pine.LNX.4.10.10205111210320.3133-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> You have to specify which of the 6 revisions of the chipset you have.
> Also in some cases which of the 13 sub-revisions, and the latter is
> determined by the sub-vender-device.

hde is ST310212A UDMA(66), hdg is SAMSUNG SV0322A UDMA(33) (motherboard 
BE6).

# lspci -v gives (2.5.14 PCI_NAMES not set) :

00:13.0 Unknown mass storage controller: Triones Technologies, Inc. 
HPT366 (rev 01)
	Flags: bus master, medium devsel, latency 120, IRQ 11
	I/O ports at cc00 [size=8]
	I/O ports at d000 [size=4]
	I/O ports at d400 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]

00:13.1 Unknown mass storage controller: Triones Technologies, Inc. 
HPT366 (rev 01)
	Flags: bus master, medium devsel, latency 120, IRQ 11
	I/O ports at d800 [size=8]
	I/O ports at dc00 [size=4]
	I/O ports at e000 [size=256]

# scanpci -v:

pci bus 0x0000 cardnum 0x13 function 0x00: vendor 0x1103 device 0x0004
  Device unknown
   STATUS    0x0200  COMMAND 0x0005
   CLASS     0x01 0x80 0x00  REVISION 0x01
   BIST      0x00  HEADER 0x80  LATENCY 0x78  CACHE 0x08
   BASE0     0x0000cc01  addr 0x0000cc00  I/O
   BASE1     0x0000d001  addr 0x0000d000  I/O
   BASE4     0x0000d401  addr 0x0000d400  I/O
   MAX_LAT   0x08  MIN_GNT 0x08  INT_PIN 0x01  INT_LINE 0x0b
   BYTE_0    0x10c9a731  BYTE_1  0x00  BYTE_2  0x80736b0  BYTE_3  0xffffffff

pci bus 0x0000 cardnum 0x13 function 0x01: vendor 0x1103 device 0x0004
  Device unknown
   STATUS    0x0200  COMMAND 0x0007
   CLASS     0x01 0x80 0x00  REVISION 0x01
   BIST      0x00  HEADER 0x80  LATENCY 0x78  CACHE 0x08
   BASE0     0x0000d801  addr 0x0000d800  I/O
   BASE1     0x0000dc01  addr 0x0000dc00  I/O
   BASE4     0x0000e001  addr 0x0000e000  I/O
   MAX_LAT   0x08  MIN_GNT 0x08  INT_PIN 0x02  INT_LINE 0x0b
   BYTE_0    0x10caa731  BYTE_1  0x00  BYTE_2  0x8073a28  BYTE_3  0xffffffff

# cat /proc/ide/hpt366 :
                              HighPoint HPT366/368/370

Controller: 0
Chipset: HPT366
--------------- Primary Channel --------------- Secondary Channel 
--------------
Enabled:        yes                             yes
--------------- drive0 --------- drive1 ------- drive0 ---------- drive1 
-------
DMA capable:    yes              no             no                no
Mode:           UDMA             off            off               off

Controller: 1
Chipset: HPT366
--------------- Primary Channel --------------- Secondary Channel 
--------------
Enabled:        yes                             yes
--------------- drive0 --------- drive1 ------- drive0 ---------- drive1 
-------
DMA capable:    yes              no             no                no
Mode:           UDMA             off            off               off

-- 
Pierre
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

