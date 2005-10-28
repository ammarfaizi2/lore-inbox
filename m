Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751815AbVJ1V3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbVJ1V3q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbVJ1V3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:29:45 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10513 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751815AbVJ1V3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:29:45 -0400
Date: Fri, 28 Oct 2005 23:29:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Claudio Scordino <cloud.of.andor@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: The "best" value of HZ
Message-ID: <20051028212942.GE4180@stusta.de>
References: <200510280118.42731.cloud.of.andor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510280118.42731.cloud.of.andor@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 01:18:41AM +0200, Claudio Scordino wrote:

> Hi,

Hi Claudio,

>     during the last years there has been a lot of discussion about the "best" 
> value of HZ... On i386 was 100, then became 1000, and finally was set to 250.
> I'm thinking to do an evaluation of this parameter using different 
> architectures.
> 
> Has anybody thought to give the possibility to modify the value of HZ at boot 
> time instead of at compile time ? This would allow to easily test different 
> values on different machines and create a table containing the "best" value 
> for each architecture...  At this moment, instead, we have to recompile the 
> kernel for each different value :(
> 
> Do you think there would be much work to do that ? 
> Do you think it would be a desired feature the knowledge of the best value for 
> each architecture with more precision ?

the best value for HZ is not architecture specific, it depends on the 
usage pattern.

The rule is roughly:
- low HZ for computations
- high HZ for interactive usage

Making HZ selectable at boot time wouldn't be hard, but I doubt it's 
worth it because it would make the kernel both bigger and slower.

> Thanks,
> 
>       Claudio

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

