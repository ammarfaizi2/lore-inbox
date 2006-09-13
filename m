Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWIMPOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWIMPOu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 11:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWIMPOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 11:14:49 -0400
Received: from smtp-server.carlislefsp.com ([12.28.84.26]:65506 "EHLO
	smtp-server.carlislefsp.com") by vger.kernel.org with ESMTP
	id S1750893AbWIMPOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 11:14:48 -0400
X-Archive-Filename: imail115816048768921472 
X-Qmail-Scanner-Mail-From: stever@carlislefsp.com via imail
X-Qmail-Scanner: 1.24st (Clear:RC:1(10.10.3.184):. Processed in 0.078295 secs Process 21472)
Message-ID: <45082055.7010309@carlislefsp.com>
Date: Wed, 13 Sep 2006 10:14:29 -0500
From: Steve Roemen <stever@carlislefsp.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: isicom module oops 2.6.17.13
References: <4506DAD7.8030307.reply@wsc.cz>
In-Reply-To: <4506DAD7.8030307.reply@wsc.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

after adding that patch to 2.6.18-rc6-mm2 and trying another card (an 
isi5634 pci/8) i get this in dmesg while loading the driver:

faxserver2:~# modprobe isicom
faxserver2:~# cat /var/log/kern.log

Sep 13 09:59:11 localhost kernel: isicom 0000:00:10.0: ISI PCI 
Card(Device ID 0x2052)
Sep 13 09:59:14 localhost kernel: isicom 0000:00:10.0: -Done
Sep 13 09:59:15 localhost kernel: 00, FP: e09c762c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7640
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7654
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7668
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c767c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7690
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c76a4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c76b8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c76cc
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c76e0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c76f4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7708
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c771c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7730
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7744
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7758
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c776c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7780
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7794
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c77a8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c77bc
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c77d0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c77e4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c77f8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c780c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7820
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7834
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7848
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c785c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7870
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7884
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7898
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c78ac
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c78c0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c78d4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c78e8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c78fc
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7910
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7924
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7938
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c794c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7960
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7974
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7988
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c799c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c79b0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c79c4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c79d8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c79ec
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7a00
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7a14
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7a28
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7a3c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7a50
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7a64
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7a78
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7a8c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7aa0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7ab4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7ac8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7adc
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7af0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7b04
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7b18
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7b2c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7b40
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7b54
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7b68
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7b7c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7b90
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7ba4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7bb8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7bcc
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7be0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7bf4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7c08
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7c1c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7c30
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7c44
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7c58
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7c6c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7c80
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7c94
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7ca8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7cbc
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7cd0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7ce4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7cf8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7d0c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7d20
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7d34
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7d48
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7d5c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7d70
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7d84
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7d98
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7dac
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7dc0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7dd4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7de8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7dfc
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7e10
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7e24
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7e38
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7e4c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7e60
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7e74
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7e88
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7e9c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7eb0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7ec4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7ed8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7eec
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7f00
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7f14
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7f28
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7f3c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7f50
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7f64
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7f78
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7f8c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7fa0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7fb4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7fc8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7fdc
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c7ff0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8004
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8018
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c802c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8040
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8054
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8068
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c807c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8090
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c80a4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c80b8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c80cc
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c80e0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c80f4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8108
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c811c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8130
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8144
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8158
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c816c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8180
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8194
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c81a8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c81bc
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c81d0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c81e4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c81f8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c820c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8220
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8234
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8248
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c825c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8270
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8284
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8298
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c82ac
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c82c0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c82d4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c82e8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c82fc
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8310
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8324
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8338
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c834c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8360
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8374
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8388
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c839c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c83b0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c83c4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c83d8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c83ec
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8400
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8414
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8428
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c843c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8450
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8464
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8478
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c848c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c84a0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c84b4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c84c8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c84dc
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c84f0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8504
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8518
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c852c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8540
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8554
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8568
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c857c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8590
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c85a4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c85b8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c85cc
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c85e0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c85f4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8608
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c861c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8630
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8644
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8658
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c866c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8680
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8694
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c86a8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c86bc
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c86d0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c86e4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c86f8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c870c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8720
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8734
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8748
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c875c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8770
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8784
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8798
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c87ac
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c87c0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c87d4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c87e8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c87fc
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8810
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8824
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8838
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c884c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8860
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8874
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8888
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c889c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c88b0
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c88c4
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c88d8
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c88ec
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8900
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8914
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8928
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c893c
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8950
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8964
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
FD: e09c7000, FP: e09c8978
Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 5, FC: 9, FD: 
e09c7000, FP: e09c898c
Sep 13 09:59:17 localhost kernel: isicom: probe of 0000:00:10.0 failed 
with error -5


Steve


Jiri Slaby wrote:
> Steve Roemen wrote:
>   
>> kernel version 2.6.17.13
>> running debian version 3.1
>>
>> lspci -vvv info for the device:
>> 0000:00:10.0 Communication controller: PLX Technology, Inc.: Unknown 
>> device 2028 (rev 01)
>>        Subsystem: Unknown device 2028:1000
>>        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
>> ParErr+ Stepping- SERR+ FastB2B-
>>        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR-
>>        Interrupt: pin A routed to IRQ 5
>>        Region 0: Memory at c6efee80 (32-bit, non-prefetchable) [size=128]
>>        Region 1: I/O ports at 2000 [size=128]
>>        Region 3: I/O ports at 2080 [size=16]
>>
>> When loading the module isicom for an ISI4608 pci card, with the 
>> firmware in /usr/lib/hotplug/firmware/ It dumps this crash log:
>>
>> isicom 0000:00:10.0: ISI PCI Card(Device ID 0x2028)
>> isicom 0000:00:10.0: -Done
>> BUG: unable to handle kernel paging request at virtual address e09cf000
>> printing eip:
>> e0a42e0b
>> *pde = 1ff9a067
>> *pte = 00000000
>> Oops: 0000 [#1]
>> Modules linked in: isicom firmware_class shpchp ide_scsi reiserfs ext3 
>> jbd epca st ohci_hcd ehci_hcd pci_hotplug mousedev evdev tsdev psmouse 
>> rtc raid5 xor raid0 tlan sd_mod ide_cd cdrom ide_disk ide_generic 
>> pdc202xx_new aec62xx alim15x3 amd74xx atiixp cmd64x cs5520 cs5530 
>> cy82c693 generic hpt34x ns87415 opti621 pdc202xx_old rz1000 sc1200 
>> serverworks siimage sis5513 slc90e66 triflex trm290 via82cxxx floppy 
>> usb_storage piix ide_core fbcon tileblit font bitblit softcursor vga16fb 
>> cfbcopyarea vgastate cfbimgblt cfbfillrect usbserial usbhid usbkbd 
>> uhci_hcd usbcore sym53c8xx scsi_transport_spi scsi_mod raid1 md_mod unix
>> CPU:    0
>> EIP:    0060:[<e0a42e0b>]    Not tainted VLI
>> EFLAGS: 00010286   (2.6.17.13 #2)
>> EIP is at isicom_probe+0x4a4/0x83b [isicom]
>> eax: 00000000   ebx: 00002080   ecx: 00004c72   edx: 00002080
>> esi: e09cf000   edi: 0000208e   ebp: 00005c6c   esp: de4e9df8
>> ds: 007b   es: 007b   ss: 0068
>> Process modprobe (pid: 2044, threadinfo=de4e8000 task=df4385b0)
>> Stack: de4e9e54 de4e9e38 ded99f70 00002084 dffcc4ec 00000000 e0a490c0 
>> dffcc448
>>       004e9e38 e0a490c0 00000000 0000208c 00002084 00000000 dffcc4b0 
>> dffcc448
>>       e09cd008 deb8ed20 dffcc400 dffcc400 e0a463c0 e0a463ec c019e28e 
>> dffcc400
>> Call Trace:
>> <c019e28e> pci_device_probe+0x38/0x59  <c01e068c> 
>> driver_probe_device+0x45/0x8f
>> <c01e072d> __driver_attach+0x0/0x5c  <c01e0764> __driver_attach+0x37/0x5c
>> <c01dfd7f> bus_for_each_dev+0x46/0x6c  <c01e057c> driver_attach+0x14/0x18
>> <c01e072d> __driver_attach+0x0/0x5c  <c01e0038> bus_add_driver+0x5b/0xe6
>> <c019df4a> __pci_register_driver+0x3b/0x5d  <e0a424b8> 
>> isicom_setup+0x1df/0x24b [isicom]
>> <c0126c44> sys_init_module+0x11d7/0x12a6  <c0102923> syscall_call+0x7/0xb
>> Code: 85 d2 74 02 8b 3a 50 51 53 56 31 f6 ff 74 24 20 57 68 63 42 a4 e0 
>> e8 69 18 6d df e9 ec 01 00 00 8b 74 24 40 89 e9 89 da 83 c6 04 <f3> 66 
>> 6f 31 c0 8b 54 24 2c 66 ef 68 de 46 03 00 31 f6 e8 98 47
>> EIP: [<e0a42e0b>] isicom_probe+0x4a4/0x83b [isicom] SS:ESP 0068:de4e9df8
>>
>>
>>
>> here's the list of firmware in /usr/lib/hotplug/firmware/
>> -r-xr-xr-x  1 root root  7325 2006-09-11 14:23 isi4608.bin
>> -r-xr-xr-x  1 root root  7497 2006-09-11 14:23 isi4616.bin
>> -r-xr-xr-x  1 root root  6213 2006-09-11 14:23 isi608.bin
>> -r-xr-xr-x  1 root root  6513 2006-09-11 14:23 isi608em.bin
>> -r-xr-xr-x  1 root root  6533 2006-09-11 14:23 isi616em.bin
>>     
>
> Hi,
>
> could you, please test this patch and send the results appeared in dmesg?
>
> diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
> index 6cca4b2..510c3cc 100644
> --- a/drivers/char/isicom.c
> +++ b/drivers/char/isicom.c
> @@ -1758,7 +1758,8 @@ static int __devinit load_firmware(struc
>  
>  	for (frame = (struct stframe *)fw->data;
>  			frame < (struct stframe *)(fw->data + fw->size);
> -			frame++) {
> +			frame = (struct stframe *)((u8 *)frame + 4 +
> +				frame->count)) {
>  		if (WaitTillCardIsFree(base))
>  			goto errrelfw;
>  
> @@ -1768,6 +1769,8 @@ static int __devinit load_firmware(struc
>  
>  		word_count = frame->count / 2 + frame->count % 2;
>  		outw(word_count, base);
> +		dev_info(&pdev->dev, "WC: %u, FC: %u, FD: %p, FP: %p\n",
> +				word_count, frame->count, fw->data, frame);
>  		InterruptTheCard(base);
>  
>  		udelay(100); /* 0x2f */
>   
