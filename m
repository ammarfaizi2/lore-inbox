Return-Path: <linux-kernel-owner+w=401wt.eu-S1751266AbXANM4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbXANM4o (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 07:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbXANM4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 07:56:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2302 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751266AbXANM4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 07:56:44 -0500
Date: Sun, 14 Jan 2007 13:56:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux v2.6.20-rc5
Message-ID: <20070114125648.GV7469@stusta.de>
References: <Pine.LNX.4.64.0701141858490.7122@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701141858490.7122@boston.corp.fedex.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2007 at 07:03:12PM +0800, Jeff Chua wrote:
> 
> On 1/14/07, Adrian Bunk <bunk@stusta.de> wrote:
> >On Sun, Jan 14, 2007 at 03:38:24PM +0800, Jeff Chua wrote:
> >>
> >> setting CONFIG_PARAVIRT=y will return in ...
> >>
> >>       vmmon.ko module unknown symbol paravirt_ops
> >>
> >Please send the 2.6.20-rc5 .config you saw this with.
> 
> Adrian,
> 
> 
> Only difference is (without CONFIG_PARAVIRT) ...
> 
> < CONFIG_PARAVIRT=y
> ---
> ># CONFIG_PARAVIRT is not set
> 
> 
> Thanks,
> Jeff.
> 
> 
> Here's my .config ...
>...

I don't have any illegal modules for testing, but the resulting kernel 
looks good (and many other of the drivers in your kernel would break if 
paravirt_ops wasn't exported).

Could it be you compiled the module against a CONFIG_PARAVIRT=y tree and 
tried to use it with a CONFIG_PARAVIRT=n kernel?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

