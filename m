Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVFERnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVFERnm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 13:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVFERnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 13:43:42 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13835 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261599AbVFERn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 13:43:27 -0400
Date: Sun, 5 Jun 2005 19:43:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPU type .config <-> i386/Makefile question[s]
Message-ID: <20050605174322.GF4992@stusta.de>
References: <200506051458.50307.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506051458.50307.nick@linicks.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2005 at 02:58:50PM +0100, Nick Warne wrote:

> Hello all,

Hi Nick,

> I am still a n00b here learning, so by all means tell me to get lost if what I 
> am about to say is total bollocks...
> 
> I was just running through building the new 2.4.31 kernel on my Quake2 box, 
> with looking at building this time with a few optimisations.
>...
> Is there a specific reason why the flags aren't -march=pentium2, pentiumpro 
> etc?

the specific reason is that kernel 2.4 is in a maintainance mode and 
such changes are not considered being worth the risk of breaking 
anything anywhere with any of the supported gcc versions.

In kernel 2.6, this is already handled the way you expect it.

> Also I notice that if I changed the top level Makefile to include my specific 
> CPU, then the i386/Makefile adds += -march=i686 to the build lines AFTER 
> CFLAGS~ thus the second one will take precedence (I guess) anyway, and the 
> -march CFLAG changes are basically over-ridden?

Users are not expected to manually set any CFLAGS.

It might work in your case, but unless you _really_ know what you are 
doing you always risk some breakage.

> Regards,
> 
> Nick

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

