Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932696AbVJCVsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbVJCVsT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 17:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932698AbVJCVsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 17:48:19 -0400
Received: from customer.iplannetworks.net ([200.69.215.65]:37132 "HELO
	mail.most.com.ar") by vger.kernel.org with SMTP id S932696AbVJCVsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 17:48:18 -0400
Date: Mon, 3 Oct 2005 18:46:26 -0300
From: Juan D Ch <jchimienti@most.com.ar>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13.2 aacraid regression
Message-ID: <20051003214626.GA18578@most.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi this is my first post in the list. I will try to make this mail short 
and useful, sorry but english is not my first language.

I have a client that has a HP Proliant ML 150 G2 with a 6 port SATA RAID
Controler Adaptec 2610SA, with HP part number 372953-B21. 
I tried to install debian, but 2.6.8 kernel doesn't support this controler.
So I installed the system in a PATA drive and then compiled the 2.6.13.2 
kernel from kernel.org. This kernel recognizes the controler so i formatted 
the array and start coping data. I copied some  dirs in /dev/sda1 
and then, after transferring a random amount of data (sometimes a couple
of MB, sometimes a few GB) the following messages appear:

------

Sep 30 10:16:59 syrah kernel: aacraid: Host adapter reset request. SCSI 
hang ?
Sep 30 10:16:59 syrah kernel: aacraid: Host adapter appears dead
Sep 30 10:16:59 syrah kernel: scsi: Device offlined - not ready after error 
recovery: host 0 channel 0 id 0 lun 0
Sep 30 10:16:59 syrah last message repeated 2 times
Sep 30 10:16:59 syrah kernel: SCSI error : <0 0 0 0> return code = 0x6000000
Sep 30 10:16:59 syrah kernel: end_request: I/O error, dev sda, sector 895
Sep 30 10:16:59 syrah kernel: scsi0 (0:0): rejecting I/O to offline device

-----

When this happens, I need to reboot in order to see the device again.

I tried 2.6.12.6 with the same options and the controller works fine.

As this is a production server it's difficult for me to track down the
exact change that introduced this error; so any hints would be highly
appreciated.

Thanks a lot


juandie

-- 
