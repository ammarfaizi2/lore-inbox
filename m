Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262997AbVCDTG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbVCDTG2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 14:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262999AbVCDTAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 14:00:37 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:49929 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262991AbVCDS4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 13:56:40 -0500
Date: Fri, 4 Mar 2005 19:56:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, kai@germaschewski.name,
       Sam Ravnborg <sam@ravnborg.org>,
       Vincent Vanackere <vincent.vanackere@gmail.com>, keenanpepper@gmail.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1
Message-ID: <20050304185638.GE3327@stusta.de>
References: <422550FC.9090906@gmail.com> <20050302012331.746bf9cb.akpm@osdl.org> <65258a58050302014546011988@mail.gmail.com> <20050302032414.13604e41.akpm@osdl.org> <20050302140019.GC4608@stusta.de> <1109931797.28203.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109931797.28203.2.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 09:23:17PM +1100, Rusty Russell wrote:
> On Wed, 2005-03-02 at 15:00 +0100, Adrian Bunk wrote:
> > Why doesn't an EXPORT_SYMBOL create a reference?
> 
> It does: EXPORT_SYMBOL(x) drops the address of "x", including
> __attribute_used__, in the __ksymtab section.
> 
> However, if CONFIG_MODULES=n, it does nothing: perhaps that is what you
> are seeing.

That's not the problem.

And it has nothing to do with any gcc 4.0 issues mentioned in this 
thread - I saw this problem with gcc 3.3 .

Try the attached .config in 2.6.11-rc4-mm1 (not in 2.6.11-mm1).

> Rusty.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

