Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278286AbRKAIEy>; Thu, 1 Nov 2001 03:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278287AbRKAIEp>; Thu, 1 Nov 2001 03:04:45 -0500
Received: from flaske.stud.ntnu.no ([129.241.56.72]:5019 "EHLO
	flaske.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S278286AbRKAIEi>; Thu, 1 Nov 2001 03:04:38 -0500
Date: Thu, 1 Nov 2001 09:03:48 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: Juergen Hasch <Hasch@t-online.de>
Cc: linux-kernel@vger.kernel.org, J Sloan <jjs@pobox.com>
Subject: Re: Intel EEPro 100 with kernel drivers
Message-ID: <20011101090348.E2102@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011029021339.B23985@stud.ntnu.no> <3BDCD06E.8AF8FF69@pobox.com> <20011031090125.B10751@stud.ntnu.no> <15yzpC-26N6dEC@fwd04.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15yzpC-26N6dEC@fwd04.sul.t-online.com>; from Hasch@t-online.de on Wed, Oct 31, 2001 at 07:10:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Hasch:
> If you use the e100 driver, you can look at 
> /proc/net/PRO_LAN_ADAPTERS/eth0.info
> If the "Tx_TCO_Packets" entry isn't zero after NFS times out,
> this may be your problem.
> With the eepro100 driver you will only see overruns with ifconfig.

Here's the full /proc/net/PRO_LAN_Adapters/eth0.info output (after NFS
timeouts):

gekko:~# cat /proc/net/PRO_LAN_Adapters/eth0.info 
Description               Intel(R) 8255x-based Ethernet Adapter
Driver_Name               e100
Driver_Version            1.6.22
PCI_Vendor                0x8086
PCI_Device_ID             0x1229
PCI_Subsystem_Vendor      0x1028
PCI_Subsystem_ID          0x009b
PCI_Revision_ID           0x0008
PCI_Bus                   2
PCI_Slot                  4
IRQ                       16
System_Device_Name        eth0
Current_HWaddr            00:B0:D0:F0:8B:65
Permanent_HWaddr          00:B0:D0:F0:8B:65
Part_Number               07195d-000

Link                      up
Speed                     100
Duplex                    full
State                     up

Rx_Packets                27747043
Tx_Packets                25999146
Rx_Bytes                  1730389022
Tx_Bytes                  21884644
Rx_Errors                 0
Tx_Errors                 0
Rx_Dropped                0
Tx_Dropped                0
Multicast                 0
Collisions                0
Rx_Length_Errors          0
Rx_Over_Errors            0
Rx_CRC_Errors             0
Rx_Frame_Errors           0
Rx_FIFO_Errors            0
Rx_Missed_Errors          0
Tx_Aborted_Errors         0
Tx_Carrier_Errors         0
Tx_FIFO_Errors            0
Tx_Heartbeat_Errors       0
Tx_Window_Errors          0

Rx_TCP_Checksum_Good      0
Rx_TCP_Checksum_Bad       0
Tx_TCP_Checksum_Good      0
Tx_TCP_Checksum_Bad       0

Tx_Abort_Late_Coll        0
Tx_Deferred_Ok            0
Tx_Single_Coll_Ok         0
Tx_Multi_Coll_Ok          0
Rx_Long_Length_Errors     0
Rx_Align_Errors           0

Tx_Flow_Control_Pause     0
Rx_Flow_Control_Pause     0
Rx_Flow_Control_Unsup     0

Tx_TCO_Packets            0
Rx_TCO_Packets            1
scbp = 0xf89da000        bddp = 0xf77568c0


-- 
Thomas
