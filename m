Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbUAFPA4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 10:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbUAFPAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 10:00:55 -0500
Received: from smtp.ncy.finance-net.fr ([62.161.220.65]:54280 "EHLO
	smtp.ncy.finance-net.fr") by vger.kernel.org with ESMTP
	id S264471AbUAFPAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 10:00:54 -0500
Date: Tue, 06 Jan 2004 15:57:04 +0100
From: newbiz <newbiz@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031015 Debian/1.4-0jds2
X-Accept-Language: fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: =?ISO-8859-1?Q?Karel_Kulhav=FD?= <clock@twibright.com>
Subject: Re: won't work: 2.6.0 && SiI 3112 SATA
References: <20040106135634.A5825@beton.cybernet.src>
In-Reply-To: <20040106135634.A5825@beton.cybernet.src>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Message-Id: <S264471AbUAFPAy/20040106150054Z+23529@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karel Kulhavý a écrit le 06.01.2004 13:56:

> I try to make Adaptec SATA RAID AAR-1210SA (in fact, SiI 3112 ACT 144 chip)
> work under 2.6.0
> 
> When booting, get "hde: lost interrupt" and DMA errors. Tried to switch
> on/off local and I/O APIC (singleproc board) and the errors stay the same.
> 
> Are these errors experienced on all SiI3112 boards? Are they experienced
> also in 2.4 kernel? Shall I try some "newer" kernel than 2.6.0?

I have NF7-S too (and Seagate sata 120), and it works for me with :

- 2.4.23 and libata 
(ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.23-libata2.patch.bz2)
- 2.6.0 and libata (CONFIG_SCSI_SATA=m and CONFIG_SCSI_SATA_SIL=m)

But it doesn't work with the siimage driver (CONFIG_BLK_DEV_SIIMAGE=m) 
under 2.4.23 (didn't try it under 2.6, since it worked with libata...)

Question (for Jeff ?) :

Why is my drive (with 2.4.23 and libata2) on /dev/sda ? Why isn't it on 
/dev/hde, like (afaik) everybody else ? I'd like to run hdparm to 
improve performance (hdparm -tT gives ~ 20 Mb/s)

Thanks

--


