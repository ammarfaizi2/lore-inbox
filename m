Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284318AbRLMQVK>; Thu, 13 Dec 2001 11:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284330AbRLMQUu>; Thu, 13 Dec 2001 11:20:50 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:56839 "HELO
	service.sh.cvut.cz") by vger.kernel.org with SMTP
	id <S284318AbRLMQUm>; Thu, 13 Dec 2001 11:20:42 -0500
Date: Thu, 13 Dec 2001 17:20:37 +0100
From: Jan Janak <J.Janak@sh.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: User/kernelspace stuff to set/get kernel variables
Message-ID: <20011213172037.B22634@devitka.sh.cvut.cz>
In-Reply-To: <20011213155532Z284289-18284+114@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011213155532Z284289-18284+114@vger.kernel.org>; from devilkin@gmx.net on Thu, Dec 13, 2001 at 04:54:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2001 at 04:54:05PM +0100, DevilKin wrote:
> Hello
> 
> I've been looking on the web, and couldn't really find what i would want...
> 
> Basically: is it possible to - one way or another - set variables at kernel boot and read those using userspace utilities?
> 
> for instance: i boot my kernel (using any old bootmanager that accepts kernel params)
> 
> 
> LILO: linux network=dhcp
> 
> 
> and later, in the init scripts, i check the value of this variable using some sort of userspace program, and if it happends to be 'dhcp' i'll invoke the dhcp client. 
> Otherwise i'd just give a static address.
> 
> I have other uses for this, for instance, you want your disks to be FSCK'ed, but don't wanna boot first, or, don't wanna go in single user mode
> 
> 
> LILO: linux dofsck=true
> 
> 
> Does something like this exist? Is it implementable in an easy way? (I know a few programming languages, but only little C(++)....)
> 

    If you pass a parameter that is not recognized by the kernel, it will be passed to init as environment variable,
 so all you need to do is check for the variable in your init scripts ($network in your example).

   regards, Jan.

> Thanks
> 
> 
> DK
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
