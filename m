Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292836AbSCMItw>; Wed, 13 Mar 2002 03:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292815AbSCMItb>; Wed, 13 Mar 2002 03:49:31 -0500
Received: from [203.197.61.9] ([203.197.61.9]:51842 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S292813AbSCMIt2>; Wed, 13 Mar 2002 03:49:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: vinolin <vinolin@nodeinfotech.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Iner Module Communications
Date: Wed, 13 Mar 2002 14:22:05 +0530
X-Mailer: KMail [version 1.2]
Cc: Robert Love <rml@tech9.net>
MIME-Version: 1.0
Message-Id: <02031314220503.00884@Vinolin>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday 13 March 2002 11:23, Robert Love wrote:

> You can call functions and touch data in other functions ... the kernel
> image, even with modules, is one big flat monolithic model.
>
> You will probably want to EXPORT_SYMBOL the functions and variables you
> want to touch ... see other modules.  But basically you can access
> anything that is exported once your module is linked.
>
> Carefully consider _why_ you need "inter-module communication",
> though... and design to those (hopefully proper) goals.
>
>        Robert Love


Thanks Robert.
Actually i'm trying to segregate IP and ICMP from the linux stack.
Thogh i do insmod of IP as well as ICMP, i'm having the linux stack as well.
In this case, if i do EXPORT_SYMBOL,
  the LKM ICMP module can refer the IP module instead of refering LKM IP 
module. But i want the LKM ICMP communicate to LKM IP only, not the kernel's 
IP.

Is EXPORT_SYMBOL the only way to solve this ? Any other idea ?

Thanks,
Vinolin.
