Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVD1SUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVD1SUA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 14:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVD1STz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 14:19:55 -0400
Received: from [195.23.16.24] ([195.23.16.24]:44269 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262226AbVD1STe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 14:19:34 -0400
Message-ID: <4271292F.1000002@grupopie.com>
Date: Thu, 28 Apr 2005 19:19:27 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Mark Rosenstand <mark@ossholes.org>, linux-kernel@vger.kernel.org
Subject: Re: Extremely poor umass transfer rates
References: <1114704142.8410.4.camel@mjollnir.bootless.dk>	<20050428165915.GG30768@redhat.com>	<1114710941.8326.13.camel@mjollnir.bootless.dk> <20050428110614.00a0c193.rddunlap@osdl.org>
In-Reply-To: <20050428110614.00a0c193.rddunlap@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> [...]On Thu, 28 Apr 2005 19:55:40 +0200 Mark Rosenstand wrote:
> | On Thu, 2005-04-28 at 12:59 -0400, Dave Jones wrote:
 > [...]
> | > USB1.1 is painfully slow for storage.
> | 
> | Yeah, but I don't think it should be 30 kB/s.

Yes it should be much more than 30kB/s. I remember measuring about 900kB/s.

> | 
> | Some more details:
> | 
> | 
> | The line that 'hald' puts in fstab looks like this:
> | 
> | 	/dev/sdb /media/usbdisk vfat \
> | 		user,exec,noauto,utf8,noatime,sync,managed 0 0

The "sync" flag is what is killing your performance. It is needed if you 
intend to remove your usb pen without warning, but if you are going to 
unmount carefully you don't need it at all.

Try mounting the device as root somewhere else without the "sync" flag 
and measure the performance that way, to see the difference.

I hope this helps,

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
