Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263010AbVFXPXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263010AbVFXPXr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 11:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263022AbVFXPXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 11:23:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:34011 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263010AbVFXPXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 11:23:41 -0400
Date: Fri, 24 Jun 2005 08:23:11 -0700
From: Greg KH <greg@kroah.com>
To: tvrtko.ursulin@sophos.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050624152311.GB29955@kroah.com>
References: <OF831AC472.851744FE-ON8025702A.004A57EC-8025702A.004B5AE9@sophos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF831AC472.851744FE-ON8025702A.004A57EC-8025702A.004B5AE9@sophos.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 02:43:04PM +0100, tvrtko.ursulin@sophos.com wrote:
> On 24/06/2005 09:18:08 linux-kernel-owner wrote:
> 
> >Now I just know I'm going to regret this somehow...
> 
> You got that right! ;)
> 
> >Comments?  Questions?  Criticisms?
> 
> It's cool and small. I like it, and I agree with Michael policy vs. policy 
> analisys.

Thanks.

> I applied it to 2.6.12 (of course some manual intervention was needed) and 
> are you curious about what happened next? Below are the relevant logs and 
> outputs. As you can see, some of them are not working as expected.

Yeah, 2.6.12-git5 was what it was against, sorry I didn't mention that.


> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI: Probing PCI hardware (bus 00)
> ndevfs: creating file '0000:00' with major 0 and minor 0
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> ndevfs: creating file '0000:01' with major 0 and minor 0
> Boot video device is 0000:01:00.0
> ndevfs: creating file '0000:02' with major 0 and minor 0

Hm, that is odd.  That shouldn't happen.

Wait, I think it was due to where you put the class hooks, try it
against Linus's latest tree, it will work better there (in fact, I don't
know if it would work properly in 2.6.12 due to the class driver core
changes.)

Could you try that and let me know if it still has issues?

thanks,

greg k-h
