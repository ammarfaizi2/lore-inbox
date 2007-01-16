Return-Path: <linux-kernel-owner+w=401wt.eu-S932228AbXAPDuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbXAPDuM (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 22:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbXAPDuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 22:50:12 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:10592 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932228AbXAPDuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 22:50:10 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:subject:date:to:x-mailer:from;
        b=P5zuS7///z5LnxcScvgn4IOgoB60vNQwpGYHusfv8kVgV9+IRDp+itiNIFlmMteT+aXLeDW8PvXMtVJcSDbVnegxuw+WpDNapnTIqi1D27OSTlHOzP4vb5X6PNO0gyTWK1StAz7UXJEZNlQPBnHXnlxiO6gHlYxD7e8/fcHTuxk=
In-Reply-To: <45ABDBF5.9000900@walrond.org>
References: <45AB8CB9.2000209@walrond.org> <20070115170412.GA26414@aepfle.de> <45ABBB8B.6000505@walrond.org> <20070115175437.GA26944@aepfle.de> <45ABDBF5.9000900@walrond.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <91B1A3E1-A745-4EB3-893F-8AC7D2497FFF@gmail.com>
Cc: Olaf Hering <olaf@aepfle.de>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Subject: Re: Initramfs and /sbin/hotplug fun
Date: Mon, 15 Jan 2007 21:50:01 -0600
To: Andrew Walrond <andrew@walrond.org>
X-Mailer: Apple Mail (2.752.2)
From: Mark Rustad <mrustad@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 15, 2007, at 1:54 PM, Andrew Walrond wrote:

> Olaf Hering wrote:
>> Why do you need /sbin/hotplug anyway, just for firmware loading for a
>> non-modular kernel?
>
> I guess this is unusual, but FWIW...
>
> I have a custom distro and I was just looking for the easiest way  
> to create a bootable rescue pen-drive. So I just took a working  
> distro, added an init->sbin/init symlink, cpio'ed it into an  
> initramfs, and booted it up. Works a treat, except for the early  
> hotplug calls.

I have a kernel that needs to have early hotplug calls to load  
firmware. I just rolled my own simple hotplug scripts to only address  
that issue and have not had a problem since. The mdev in busybox that  
is in the gentoo initramfs didn't seem to be able to handle it, so I  
just made my own scripts. In my case I needed QLogic firmware so root  
could be on FC.

FWIW, it is a real PITA to not be able to build a monolithic kernel  
that can bring up root on its own. I will stipulate that I am an old- 
school guy that likes monolithic kernels, but I do feel that  
something has been lost. Yes, I am aware of the reasons for the  
change, else I would have written something when I was fighting the  
battle, but I still don't have to like it.

-- 
Mark Rustad, MRustad@mac.com


