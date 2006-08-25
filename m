Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWHYKab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWHYKab (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 06:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWHYKab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 06:30:31 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38155 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932400AbWHYKaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 06:30:30 -0400
Date: Fri, 25 Aug 2006 12:30:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Core support for --combine -fwhole-program
Message-ID: <20060825103029.GV19810@stusta.de>
References: <1156429585.3012.58.camel@pmac.infradead.org> <1156433167.3012.119.camel@pmac.infradead.org> <20060824213302.GS19810@stusta.de> <1156498643.2984.28.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156498643.2984.28.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 10:37:23AM +0100, David Woodhouse wrote:
> On Thu, 2006-08-24 at 23:33 +0200, Adrian Bunk wrote:
> > If a "build everything except for assembler files at once" approach is 
> > possible, it should be possible to revert this and get even further 
> > savings.
> 
> Only if we build _everything_ at once, which may take an insane amount
> of RAM. Doing it a directory at a time makes a certain amount of sense,
> and tends to combine the most incestuous code -- although maybe
> combinations like building arch/$ARCH/kernel/ with kernel/ (and likewise
> mm) could be an interesting experiment.

My hope is "insane" would be something like "1 GB of RAM" that is no 
longer insane on current computers. [1]

> I suspected that most of the 'further savings' to which you refer above
> could be achieved more easily with -ffunction-sections -fdata-sections
> --gc-sections

AFAIR -ffunction-sections/-fdata-sections cause some overhead in the 
resulting binary?

> dwmw2

cu
Adrian

[1] The interesting cases are embedded systems needing a small kernel
    that gets built on a much bigger system.
    Whether this should be the default compile mode for everyone is a
    different issue.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

