Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbUCNL5g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 06:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263346AbUCNL5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 06:57:32 -0500
Received: from sun1000.pwr.wroc.pl ([156.17.1.33]:36265 "EHLO
	sun1000.pwr.wroc.pl") by vger.kernel.org with ESMTP id S263345AbUCNL5a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 06:57:30 -0500
Date: Sun, 14 Mar 2004 12:57:27 +0100
From: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
To: linux-kernel@vger.kernel.org
Subject: [2.6.4] IDE performance drop again
Message-ID: <20040314115727.GA21362@sun1000.pwr.wroc.pl>
Reply-To: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Useless-Header: Vim powered ;^)
X-00-Privacy-Policy: S/MIME encrypted e-mail is welcome.
X-04-Privacy-Policy-My_SSL_Certificate: http://www.europki.pl/cgi-bin/dn-cert.pl?serial=000001D2&certdir=/usr/local/cafe/data/polish_ca/certs/user&type=email
X-05-Privacy-Policy-CA_SSL_Certificate: http://www.europki.pl/polish_ca/ca_cert/en_index.html
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

after switching from 2.6.1 to 2.6.4 I see IDE performance drop again.

hdparm /dev/hda

/dev/hda:
 multcount    =  1 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 8192 (on)
 geometry     = 26310/16/63, sectors = 26520480, start = 0

under 2.4.x and 2.6.1 i had about 40 MB/s in hdparm -ft. in 2.6.4 i get
at most 26 MB/s. changing readahead does not help. i'm using ac
scheduler.

lspci

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
00:07.1 IDE interface: VIA Technologies, Inc.  VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 10)
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 10)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 20)
00:0b.0 SCSI storage controller: Tekram Technology Co.,Ltd. TRM-S1040 (rev 01)
00:11.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)
00:11.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
00:14.0 Ethernet controller: Realtek Semiconductor Co., Ltd.  RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev b2)

/proc/interrupts 
           CPU0       
  0:    1602384          XT-PIC  timer
  1:       4247          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:       6328          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:     194179          XT-PIC  uhci_hcd, uhci_hcd, eth0
 11:          0          XT-PIC  VIA686A
 12:     100786          XT-PIC  nvidia, bttv0
 14:      27087          XT-PIC  ide0
 15:          5          XT-PIC  ide1
NMI:          0 
LOC:    1598373 
ERR:     260588
MIS:          0

regards, P

PS. I'm not subscribed, so please CC me your replies. thanks.
-- 
Pawel Dziekonski <pawel.dziekonski|@|pwr.wroc.pl>, KDM WCSS avatar:0:0:
Wroclaw Networking & Supercomputing Center, HPC Department
-> See message headers for privacy policy info.
