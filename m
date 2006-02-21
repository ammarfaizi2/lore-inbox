Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbWBUSoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbWBUSoJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 13:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbWBUSoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 13:44:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23303 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932581AbWBUSoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 13:44:08 -0500
Date: Tue, 21 Feb 2006 19:44:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove the CONFIG_CC_ALIGN_* options
Message-ID: <20060221184406.GZ4661@stusta.de>
References: <20060220223654.GR4661@stusta.de> <20060221175640.GB9070@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221175640.GB9070@mars.ravnborg.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 06:56:40PM +0100, Sam Ravnborg wrote:
> On Mon, Feb 20, 2006 at 11:36:54PM +0100, Adrian Bunk wrote:
> > I don't see any use case for the CONFIG_CC_ALIGN_* options:
> > - they are only available if EMBEDDED
> > - people using EMBEDDED will most likely also enable 
> >   CC_OPTIMIZE_FOR_SIZE
> > - the default for -Os is to disable alignment
> > 
> > In case someone is doing performance comparisons and discovers that the
> > default settings gcc chooses aren't good, the only sane thing is to
> > discuss whether it makes sense to change this, not through offering 
> > options to change this locally.
> 
> I leave it to other to judge if this is wortwhile or not - I have no
> numbers to back up either with or without.
> It is though a nice cleaning effort in the Makefile.
> 
> But if we back-out this then cc-option-aling should go as well,
> including description in Documentation/kbuild/makefiles.txt

My patch doesn't remove cc-option-align, and it's still used in 
arch/i386/Makefile.cpu.

The point of my patch is that there's no reason why a user should set 
different align options (if a developer wants to benchmark different 
align options, adding them to the CFLAGS in the Makefile is still 
trivial).

> 	Sam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

