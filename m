Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWDDJfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWDDJfz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 05:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWDDJfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 05:35:54 -0400
Received: from pproxy.gmail.com ([64.233.166.183]:1157 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932430AbWDDJfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 05:35:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BQof846QaO7EizWkKEm1IHq52RxMDZawHgMzQNux/8ehnDOH2jCLEmwnV8lGeGIMGrxss04G64q5LJFPSZjHPIh2DPNnDbZqge3cyQo1k117bDcv4dCJbCd7o/QrIkSNVHb85EI4p52QDtu2y+ueza97qmH/FrzDDEQo8S6HEOg=
Message-ID: <44323DE9.7030106@gmail.com>
Date: Tue, 04 Apr 2006 18:35:37 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Mauro Tassinari <mtassinari@cmanet.it>, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: libata/sata status on ich[?]
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAAyTp2U2YnGEW3ub1INE9nAAEAAAAA@cmanet.it> <44323C24.4010402@garzik.org>
In-Reply-To: <44323C24.4010402@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Mauro Tassinari wrote:
>> Hi Jeff, All,
>>
>> our latest tests on previously reported ICH6 platforms show
>> 2.6.16.git not reporting any device on 4th master port.
>> The same behaviour was previously observed with 2.6.16-mm2,
>> regardless the hd brand and type.
> 
> Is this fixed in 2.6.17-rc1?
> 
> 
>> 2.6.16.1
>> ata1: dev 0 ATA-6, max UDMA/100, 321672960 sectors: LBA48
>> ata2: dev 0 ATA-7, max UDMA/133, 320173056 sectors: LBA48
> 
>> 2.6.16-git16
>> ata_piix 0000:00:1f.2: MAP [ P0 P1 P2 P3 ]
>> ata1: dev 0 ATA-6, max UDMA/100, 321672960 sectors: LBA48
>> ata2: SATA port has no device.
> 
> Thanks for that info.  Can you also provide 'lspci -vvv' (run as root)?
> 

Hello, all.

This should be fixed by the ata_piix map patch I've submitted and is 
currently in #upstream. [ P0 P1 P2 P3 ] should be [ P0 P2 P1 P3 ].

Thanks.

-- 
tejun
