Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWIFP6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWIFP6Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 11:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWIFP6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 11:58:16 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:36624 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751189AbWIFP6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 11:58:15 -0400
Date: Wed, 6 Sep 2006 17:58:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Kirill Korotaev <dev@sw.ru>
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Mirkin <amirkin@sw.ru>
Subject: Re: [RFC][PATCH] fail kernel compilation in case of unresolved symbols
Message-ID: <20060906155805.GT9173@stusta.de>
References: <44FD7FED.7000603@sw.ru> <20060905153159.GA13082@uranus.ravnborg.org> <20060905160104.GF9173@stusta.de> <44FEE3CF.7090603@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FEE3CF.7090603@sw.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 07:05:51PM +0400, Kirill Korotaev wrote:
> Adrian Bunk wrote:
> >On Tue, Sep 05, 2006 at 05:31:59PM +0200, Sam Ravnborg wrote:
> >
> >>On Tue, Sep 05, 2006 at 05:47:25PM +0400, Kirill Korotaev wrote:
> >>
> >>>At stage 2 modpost utility is used to check modules.
> >>>In case of unresolved symbols modpost only prints warning.
> >>>
> >>>IMHO it is a good idea to fail compilation process in case of
> >>>unresolved symbols, since usually such errors are left unnoticed,
> >>>but kernel modules are broken.
> >>
> >>The primary reason why we do not fail in this case is that building
> >>external modules often result in unresolved symbols at modpost time.
> >>
> >>And there is many legitime uses of external modules that we shall support.
> 
> >Is there a way we can get this only for building the kernel itself?

s/kernel itself/modules shipped with the kernel/

> >In this case an unresolved symbol is a real bug that should cause an 
> >abort of the compilation.
> IMHO for kernel linking will fail...
> 
> Don't you consider the kernel to be broken if suddenly one of your modules
> began to have unresolved symbols?
>...

> Thanks,
> Kirill

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

