Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284301AbRLMQEA>; Thu, 13 Dec 2001 11:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284302AbRLMQDv>; Thu, 13 Dec 2001 11:03:51 -0500
Received: from mercury.ccmr.cornell.edu ([128.84.231.97]:19986 "EHLO
	mercury.ccmr.cornell.edu") by vger.kernel.org with ESMTP
	id <S284301AbRLMQDj>; Thu, 13 Dec 2001 11:03:39 -0500
From: Daniel Freedman <freedman@ccmr.cornell.edu>
Date: Thu, 13 Dec 2001 11:03:38 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: User/kernelspace stuff to set/get kernel variables
Message-ID: <20011213110338.I7781@ccmr.cornell.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011213155532Z284289-18284+114@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011213155532Z284289-18284+114@vger.kernel.org>; from devilkin@gmx.net on Thu, Dec 13, 2001 at 04:54:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2001, DevilKin wrote:
> Hello
> 
> I've been looking on the web, and couldn't really find what i would want...
> 
> Basically: is it possible to - one way or another - set variables at kernel boot and read those using userspace utilities?

Sorry, I don't know, but see below for possible solution to your problem anyway.

> for instance: i boot my kernel (using any old bootmanager that accepts kernel params)
> 
> 
> LILO: linux network=dhcp

You might want to familiarize yourself with the following kernel parameter:

"ip=<client-ip>:<server-ip>:<gw-ip>:<netmask>:<hostname>:<device>:<autoconf>"

where most options are obvious, and you'll probably want device to be
"eth0" and autoconf to be "dhcp".

HTH,

Daniel


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
> Thanks
> 
> 
> DK
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Daniel A. Freedman
Laboratory for Atomic and Solid State Physics
Department of Physics
Cornell University
