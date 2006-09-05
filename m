Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbWIEQBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbWIEQBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 12:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbWIEQBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 12:01:14 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55046 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965122AbWIEQBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 12:01:13 -0400
Date: Tue, 5 Sep 2006 18:01:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Mirkin <amirkin@sw.ru>
Subject: Re: [RFC][PATCH] fail kernel compilation in case of unresolved symbols
Message-ID: <20060905160104.GF9173@stusta.de>
References: <44FD7FED.7000603@sw.ru> <20060905153159.GA13082@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060905153159.GA13082@uranus.ravnborg.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2006 at 05:31:59PM +0200, Sam Ravnborg wrote:
> On Tue, Sep 05, 2006 at 05:47:25PM +0400, Kirill Korotaev wrote:
> > At stage 2 modpost utility is used to check modules.
> > In case of unresolved symbols modpost only prints warning.
> > 
> > IMHO it is a good idea to fail compilation process in case of
> > unresolved symbols, since usually such errors are left unnoticed,
> > but kernel modules are broken.
> 
> The primary reason why we do not fail in this case is that building
> external modules often result in unresolved symbols at modpost time.
> 
> And there is many legitime uses of external modules that we shall support.

Is there a way we can get this only for building the kernel itself?
In this case an unresolved symbol is a real bug that should cause an 
abort of the compilation.

I'm often doing compile tests for the kernel, and the current warnings 
are too easy to miss.

> 	Sam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

