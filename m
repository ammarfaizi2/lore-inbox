Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVCRWEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVCRWEX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 17:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVCRWEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 17:04:22 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:34771 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261470AbVCRWCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 17:02:15 -0500
Subject: Re: Suspend-to-disk woes
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Erik =?ISO-8859-1?Q?Andr=E9n?= <erik.andren@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <423B01A3.8090501@gmail.com>
References: <423B01A3.8090501@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1111183452.3074.3.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 19 Mar 2005 09:04:12 +1100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The simplest solution is to mkswap your swap partitions during boot.

Nigel

On Sat, 2005-03-19 at 03:28, Erik Andrén wrote:
> Hello, I experienced a pretty nasty problem a couple of days back:
> 
> I ran 2.6.11-ck1 and built 2.6.11-ck2. The last thing I did before 
> booting the new kernel was to suspend-to-disk the old kernel (something 
> I usually do as I'm working on this laptop).
> I ran the new kernel a couple of days and decided to boot the old kernel 
> to do some performance tests. Imagine my dread as the old kernel instead 
> of detecting that the system has booted another kernel just reloads the 
> old suspend-to-disk image. The result is that after succesfully 
> resuming, my harddrive goes bonkers and starts to work. After a couple 
> of minutes the whole kernel hangs. I reboot and try to boot the -ck2 
> kernel again only to find that the system complains as it finds missing 
> nodes. The reisertools try to rebuild the system unsucessully. The 
> --rebuild-tree parameter worked but a lot of files were still missing. 
> In the end I had to reinstall the whole system as it went so unstable.
> 
> My question is: Why isn't there a check before resuming a 
> suspend-to-disk image if the system has booted another kernel since the 
> suspend to prevent this kind of hassle?
> //Regards Erik Andrén
> 
> Please cc me as I'm not on the lkml list yadda yadda
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

