Return-Path: <linux-kernel-owner+w=401wt.eu-S964876AbWL1CZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWL1CZG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 21:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWL1CZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 21:25:05 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:40621 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964876AbWL1CZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 21:25:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=p0gA2pXcvmwNcqYnGXmBccENeMypoP8pSJxthoXf69+nwx6sqII9Gfn+IG0Y0M/1IedaKmA2RJdI2m2DwJh+iBF4hVc1RLjFmhdKxQrO+j4MjOEr7jSYdBW0z/hLpA0WSr33rQbaHyRsZbik18wteNbdBSCfotxZ3RrsBaW6wBs=
Message-ID: <45932AF1.9040900@gmail.com>
Date: Thu, 28 Dec 2006 11:24:49 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Rene Herman <rene.herman@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: PATA -- pata_amd on 2.6.19 fails to IDENTIFY my DVD-ROM
References: <45893CAD.9050909@gmail.com> <45921E73.1080601@gmail.com> <4592B25A.4040906@gmail.com>
In-Reply-To: <4592B25A.4040906@gmail.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:
> Tejun Heo wrote:
> 
>> Rene Herman wrote:
> 
>>> I just tried the PATA driver for my AMD756 chip. During boot, it hangs
>>> for 3 minutes failing to identify my DVD-ROM (secondary slave) and does
>>> not give me access to it after it timed out.
>>
>> Please give a shot at v2.6.20-rc2 and report what the kernel says.
> 
> This IDENTIFY issue seems already fixed in -rc2. No more pause, and my
> DVD-ROM works fine again.

Great.

> Unfortunately, another issue seems to have
> cropped up. On 2.6.20-rc2, hdparm -t /dev/sda gets me ~ 24 M/s while
> both the old IDE driver and the 2.6.19 PATA driver do ~ 50 M/s
> 
> 2.6.20-rc2-ata:
> 
> # hdparm -t /dev/sda
> 
> /dev/sda:
>  Timing buffered disk reads:   72 MB in  3.03 seconds =  23.75 MB/sec
> 
> 2.6.19-ata:
> 
> # hdparm -t /dev/sda
> 
> /dev/sda:
>  Timing buffered disk reads:  150 MB in  3.00 seconds =  49.94 MB/sec

Everything seems fine in the dmesg.  Performance degradation is probably
some other issue in -rc kernel.  I'm suspecting recently fixed block
layer bug.  If it's still the same in the next -rc, please report.

Thanks.

-- 
tejun
