Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290082AbSAQRrh>; Thu, 17 Jan 2002 12:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290084AbSAQRr1>; Thu, 17 Jan 2002 12:47:27 -0500
Received: from at8.tphys.uni-linz.ac.at ([140.78.103.8]:34061 "EHLO
	mail.tphys.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S290082AbSAQRrQ>; Thu, 17 Jan 2002 12:47:16 -0500
Message-Id: <200201171747.g0HHl8M27679@at18.tphys.uni-linz.ac.at>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Alexander Puchmayr <alexander.puchmayr@jku.at>
Reply-To: alexander.puchmayr@jku.at
Organization: University Linz, Austria
To: linux-atm-general-request@lists.sourceforge.net
Subject: ATM ENI Problems with SMP
Date: Thu, 17 Jan 2002 18:47:08 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I have an Efficient ENI 155 ATM adapter running with Linux 2.4.16/17.
When I turn on SMP support (The board is an ASUS P2B-DS with two P3/800), the 
eni driver crashes with "driver error - ident mismatch"-Error.

Without SMP support activated in the kernel, the card works fine.


Is there a problem with SMP-Support for ATM?


I turned on the ENI_DEBUG-option, the output is:

Jan 17 18:16:06 atm73 kernel: eni(itf 0): driver error - ident mismatch
Jan 17 18:16:06 atm73 kernel: ---recent events---
Jan 17 18:16:06 atm73 kernel: poll_rx.slow
Jan 17 18:16:06 atm73 kernel: rx_vcc(1)
Jan 17 18:16:06 atm73 kernel: rx_vcc(2: host dsc=0x12a1, nic dsc=0x1ab2)
Jan 17 18:16:06 atm73 kernel: rx_aal5
Jan 17 18:16:06 atm73 kernel: rx_vcc(3)
Jan 17 18:16:06 atm73 kernel: poll_rx done
Jan 17 18:16:06 atm73 kernel: INT: RX DMA complete, starting dequeue_rx
Jan 17 18:16:06 atm73 kernel: dequeued (size=2065,pos=0x1ab2)
Jan 17 18:16:06 atm73 kernel: pushing (len=8216)
Jan 17 18:16:06 atm73 kernel: dequeue_rx done, starting poll_rx
Jan 17 18:16:06 atm73 kernel: poll_rx done
Jan 17 18:16:06 atm73 kernel: do_tx: skb=0xf529eca0, 80 bytes
Jan 17 18:16:06 atm73 kernel: put_dma: 0x352948c8+0x50
Jan 17 18:16:06 atm73 kernel: INT: TX DMA COMPLETE
Jan 17 18:16:06 atm73 kernel: INT: TX COMPLETE
Jan 17 18:16:06 atm73 kernel: INT: service, starting get_service
Jan 17 18:16:06 atm73 kernel: getting from service
Jan 17 18:16:06 atm73 kernel: get_service done, starting poll_rx
Jan 17 18:16:06 atm73 kernel: poll_rx.slow
Jan 17 18:16:06 atm73 kernel: rx_vcc(1)
Jan 17 18:16:06 atm73 kernel: rx_vcc(2: host dsc=0x1ae1, nic dsc=0x1b1e)
Jan 17 18:16:06 atm73 kernel: rx_aal5
Jan 17 18:16:06 atm73 kernel: rx_vcc(3)
Jan 17 18:16:06 atm73 kernel: poll_rx done
Jan 17 18:16:06 atm73 kernel: INT: RX DMA complete, starting dequeue_rx
Jan 17 18:16:06 atm73 kernel: dequeued (size=61,pos=0x1b1e)
Jan 17 18:16:06 atm73 kernel: pushing (len=202)
Jan 17 18:16:06 atm73 kernel: dequeue_rx done, starting poll_rx
Jan 17 18:16:06 atm73 kernel: poll_rx done
Jan 17 18:16:06 atm73 kernel: do_tx: skb=0xf52c30c0, 9188 bytes
Jan 17 18:16:06 atm73 kernel: put_dma: 0x35314008+0x23e4
Jan 17 18:16:06 atm73 kernel: INT: TX DMA COMPLETE
Jan 17 18:16:06 atm73 kernel: do_tx: skb=0xf52c2b80, 9188 bytes
Jan 17 18:16:06 atm73 kernel: put_dma: 0x35308008+0x23e4
Jan 17 18:16:06 atm73 kernel: INT: TX DMA COMPLETE
Jan 17 18:16:06 atm73 kernel: do_tx: skb=0xf5299180, 9188 bytes
Jan 17 18:16:06 atm73 kernel: put_dma: 0x35318008+0x23e4
Jan 17 18:16:06 atm73 kernel: INT: TX COMPLETE
Jan 17 18:16:06 atm73 kernel: INT: TX DMA COMPLETE
Jan 17 18:16:06 atm73 kernel: do_tx: skb=0xf529ede0, 9188 bytes
Jan 17 18:16:06 atm73 kernel: put_dma: 0x3530c008+0x23e4
Jan 17 18:16:06 atm73 kernel: INT: TX DMA COMPLETE
Jan 17 18:16:06 atm73 kernel: do_tx: skb=0xf529f140, 9188 bytes
Jan 17 18:16:06 atm73 kernel: put_dma: 0x35310008+0x23e4
Jan 17 18:16:06 atm73 kernel: INT: TX COMPLETE
Jan 17 18:16:06 atm73 kernel: INT: TX DMA COMPLETE
Jan 17 18:16:06 atm73 kernel: do_tx: skb=0xf5299180, 47 bytes
Jan 17 18:16:06 atm73 kernel: do_tx: skb=0xf53269a0, 9188 bytes
Jan 17 18:16:06 atm73 kernel: put_dma: 0x353a4c60+0x2f
Jan 17 18:16:06 atm73 kernel: put_dma: 0x37e94000+0x1
Jan 17 18:16:06 atm73 kernel: put_dma: 0x35320008+0x23e4
Jan 17 18:16:06 atm73 kernel: INT: TX DMA COMPLETE
Jan 17 18:16:06 atm73 kernel: do_tx: skb=0xf5299680, 9188 bytes
Jan 17 18:16:06 atm73 kernel: put_dma: 0x352dc008+0x23e4
Jan 17 18:16:06 atm73 kernel: INT: TX COMPLETE
Jan 17 18:16:06 atm73 kernel: INT: TX DMA COMPLETE
Jan 17 18:16:06 atm73 kernel: do_tx: skb=0xf543f520, 1416 bytes
Jan 17 18:16:06 atm73 kernel: put_dma: 0x357c7808+0x588
Jan 17 18:16:06 atm73 kernel: INT: TX DMA COMPLETE
Jan 17 18:16:06 atm73 kernel: INT: TX COMPLETE
Jan 17 18:16:06 atm73 last message repeated 2 times
Jan 17 18:16:06 atm73 kernel: bug interrupt
Jan 17 18:16:06 atm73 kernel: ---dump ends here---


Thanks in advance
	Alexander Puchmayr

-- 
---
Alexander Puchmayr 
Institut für Theoretische Physik     Altenbergerstr. 69, A-4040 Linz
Johannes-Kepler Universitaet         Phone: ++43 732/2468-8633
A-4040 Linz, Austria                 Fax:   ++43 732/2468-8585
E-Mail: alexander.puchmayr@jku.at


