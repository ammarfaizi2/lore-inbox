Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVJHHlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVJHHlv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 03:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbVJHHlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 03:41:51 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:3449 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750785AbVJHHlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 03:41:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FAUQVm+Yx1Sal5flbAUuoWS1Aie7Z8HKwK8ZCc6hBWKbniMsdG2oE0KTSSUWLVXBffMr8IwWd5Van6nvJRfwJrzQXz3oWUkvcgkcR6rOUGAW7ov832m/D3IoE5/tZdS6ZFaQjA0pqeRdcD4czwMsvHlYGunLba9WRyXkIYHj1gY=
Message-ID: <43477836.6020107@gmail.com>
Date: Sat, 08 Oct 2005 16:41:42 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Walrond <andrew@walrond.org>
CC: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Anybody know about nforce4 SATA II hot swapping + linux raid?
References: <200510071111.46788.andrew@walrond.org>
In-Reply-To: <200510071111.46788.andrew@walrond.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Walrond wrote:
> I need to deploy some very resilient servers with hot swapable drives.
> 
> I always used dac960 based hardware raid for hot swapping in the past, but 
> sata drives are so cheap compared to scsi that I'm considering the Tyan GT24 
> server with 4 hot swappable SATA II drives (nforce4 pro controller)
> 
> 	http://www.tyan.com/products/html/gt24b2891.html
> 
> Before I place an order, I need to know whether sata II hot swapping is up to 
> scratch in the linux kernel, and whether it works nicely with linux software 
> raid (which I already use/am familiar with).
> 
> Any knowledge greatfully accepted :)
> 
> Andrew Walrond

  Unfortunately, SATA hoplug support is not ready yet.  Preliminary 
works are in progress though and it will happen.  Of course, I have 
absolutely no idea how distant the future is. :-)

  One more thing to note is that nVidia cannot supply information 
regarding SATA part (I think network part too) of its chipset to open 
source community.  So, it is possible that not everything goes smoothly 
with nf4 hotplug support even after other pieces come together eventually.

  If you're looking for stability/resilience for production machine, 
IMHO libata isn't still quite ready.

  libata maintainer Jeff Garzik maintains the following status page you 
might be interested in.

http://linux.yyz.us/sata/

-- 
tejun
