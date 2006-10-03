Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965273AbWJCGyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965273AbWJCGyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 02:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965274AbWJCGyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 02:54:47 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:45171 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965266AbWJCGyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 02:54:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dgUZAPkbJTcnyT0vZQ4ceSeWp58u9PevQPW3tbVAmkpjQs/qaPzBRLngRPZozhxnRFoByHglAKnnr2Xfp3fQmkCPDyj9ZUJQSSXMGh7psPYOx9x33ZgjevWeVBuAZUrmzE2qsH+29lyQxiwOcqwnGf4hYCZpv2r3QqrLHPmiNOw=
Message-ID: <4522093D.9040506@gmail.com>
Date: Tue, 03 Oct 2006 15:54:53 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Molle Bestefich <molle.bestefich@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: SATA repeated failure (command 0x35 timeout, status 0xd8)
References: <62b0912f0609240816q54c3535bt86f781745ecbfa13@mail.gmail.com>	 <4518B643.6030407@gmail.com> <62b0912f0610011927k789b63f4r370b419e5b98bb5f@mail.gmail.com>
In-Reply-To: <62b0912f0610011927k789b63f4r370b419e5b98bb5f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Molle Bestefich wrote:
[--snip--]
> The above repeats itself thru modes UDMA/66, UDMA/44, UDMA/33,
> UDMA/25, UDMA/16, PIO4, PIO3, PIO1 and PIO0.

Can you full dmesg for this?  Preferably w/ timestamp?

> At which point /dev/sdb disappears completely, only to reappear as 
> /dev/sdh:
> ===============
> SCSI device sdh: 398297088 512-byte hdwr sectors (203928 MB)
> sdh: Write Protect is off
> sdh: Mode Sense: 00 3a 00 00
> SCSI device sdh: drive cache: write back
> SCSI device sdh: 398297088 512-byte hdwr sectors (203928 MB)
> sdh: Write Protect is off
> sdh: Mode Sense: 00 3a 00 00
> SCSI device sdh: drive cache: write back
> ===============
> 
> (Odd.)
> 
> I don't get why PowerMax works this drive just fine while Linux
> doesn't.  Perhaps because PowerMax only uses SMART commands and
> doesn't transfer data over the SATA bus?
> 
> Anyway, with the device now failing fairly consistently, I guess I
> should begin moving around cables, controllers, disks etc. again.  I'm
> very worried about doing this though, since I'm pretty sure that it'll
> break the MD array on the disks very quickly..

Your problem seems to be hardware transmission error.  I don't know what 
a powermax is and doesn't know what it does, so you'll have to play the 
swap-and-see-what-breaks game to figure out the problematic part.

Thanks.

-- 
tejun
