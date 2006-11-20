Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966352AbWKTSN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966352AbWKTSN5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966339AbWKTSNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:13:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16650 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S966314AbWKTSNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:13:20 -0500
Date: Mon, 20 Nov 2006 19:13:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, zippel@linux-m68k.org,
       jejb <james.bottomley@steeleye.com>
Subject: Re: how to handle indirect kconfig dependencies
Message-ID: <20061120181319.GX31879@stusta.de>
References: <20061116200741.fb607fe4.randy.dunlap@oracle.com> <455DBF3D.40801@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455DBF3D.40801@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 02:55:09PM +0100, Stefan Richter wrote:
> Randy Dunlap wrote:
> > I have a (randconfig) build of 2.6.19-rc5-mm2 with:
> [...]
> > so the question is:
> > (How) can kconfig follow the dependency chain and either
> > - prevent this odd config combination or
> > - see that 'select DEBUG_FS' implies 'select SYSFS' and then enable SYSFS
> > ?
> > 
> > I don't believe that the right answer is to add
> > 	depends on SYSFS
> > to DEBUG_READAHEAD.
> 
> I know this doesn't concludingly answer your question, but: All of the
> various shipped tools to generate .config need to be fixed to recognize
> "select" to imply a dependency like "depends on" does.
>...

BTW:
"All of the various shipped tools ... need to be fixed" is a bit 
misleading since one of the features of the 2.6 kconfig is that this 
code is shared by all tools.

> Stefan Richter

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

