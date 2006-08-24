Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWHXJhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWHXJhl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 05:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWHXJhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 05:37:41 -0400
Received: from web25802.mail.ukl.yahoo.com ([217.12.10.187]:41836 "HELO
	web25802.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750987AbWHXJhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 05:37:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=lGufUY/9sQDtUqx7Lhj/rFYL0UQtq6bFuLSuE2jdsjXx+sAh/w71JcdLJiXFU9rsKe9BHRk+vHLTnm1SLaptteu60cT6ft7soqhcDhD3hIZAe56m9SLufHRnMpIX1cJdIqj/aC4z/75GPlsMRYnVlMgV7CHdqR4FY9uYCrkv82o=  ;
Message-ID: <20060824093739.5085.qmail@web25802.mail.ukl.yahoo.com>
Date: Thu, 24 Aug 2006 09:37:39 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : [HELP] Power management for embedded system
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060824090455.GA18202@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Russell King wrote:
> On Thu, Aug 24, 2006 at 08:44:25AM +0000, moreau francis wrote:
>> Mips one seems to be a copy and paste of arm one and both of them
>> have removed all APM bios stuff orginally part of i386 implementation.
> 
> The BIOS stuff makes no sense on ARM - there isn't a BIOS to do anything
> with.

I haven't said that it has been widely/wrongly removed...

> 
>> It doesn't seem that APM is something really stable and finished.
> 
> It's complete.  It's purpose is to provide the interface to userland so
> that programs know about suspend/resume events, and can initiate suspends.
> Eg, the X server.
> 

Is there something specific to ARM in this implementation ? I don't think
so and it's surely the reason why MIPS did copy it with almost no changes.
I understand that ARM implementation has been the first one but maybe now
why not making it the common power management for embedded system that
could be used by all arches which need it ?

BTW, why has apm_cpu_idle() logic been removed from ARM implementation ?

> The power management really comes from the Linux drivers themselves,
> which are written to peripherals off when they're not in use.  The other
> power saving comes from things like cpufreq - again, nothing to do with
> the magical "APM" or "ACPI" terms.

BTW why is it still called "APM" on ARM ?

thanks

Francis



