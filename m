Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWEAJY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWEAJY3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 05:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWEAJY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 05:24:29 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26898 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751073AbWEAJY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 05:24:28 -0400
Date: Mon, 1 May 2006 11:24:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] kernel/sys.c: possible cleanups
Message-ID: <20060501092428.GW3570@stusta.de>
References: <20060501071134.GH3570@stusta.de> <20060501001803.48ac34df.akpm@osdl.org> <20060501073514.GQ3570@stusta.de> <1146469146.20760.31.camel@laptopd505.fenrus.org> <20060501004925.36e4dd21.akpm@osdl.org> <20060501085939.GV3570@stusta.de> <20060501020722.62bc5050.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501020722.62bc5050.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 02:07:22AM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > So the work would expand to:
> >  - writing 200 feature-removal-schedule.txt entries
> >  - marking 200 functions and variables as __deprecated_for_modules
> >
> >  And in a few months:
> >  - removing 200 feature-removal-schedule.txt entries
> >  - removing 200 __deprecated_for_modules markers
> >  - removing the 200 unused exports
> 
> Don't bother with all that stuff - a modprobe-time warning across a few
> kernel releases is sufficient to make any developers who are dependent upon
> an export aware of their problem.
> 
> Changing the export to EXPORT_UNUSED_SYMBOL() and then later removing the
> export is adequate.

OK, let's get this into 2.6.17 - it can't break anything and makes 
developers sooner aware of this.

Can we also create the rule that changing an EXPORT_UNUSED_SYMBOL() back 
to an EXPORT_SYMBOL() requires an in-kernel user of the export? 
Otherwise all this "there is no stable API for external modules" saying 
starts to become nonsense.

If we give developers 6 months of EXPORT_UNUSED_SYMBOL() warning this 
should be enough for them to submit their code for review and inclusion 
into the kernel.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

