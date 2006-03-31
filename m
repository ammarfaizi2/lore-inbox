Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWCaTIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWCaTIx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 14:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWCaTIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 14:08:53 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19725 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751392AbWCaTIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 14:08:53 -0500
Date: Fri, 31 Mar 2006 21:08:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: smp_locks reference_discarded errors
Message-ID: <20060331190851.GB22677@stusta.de>
References: <20060325033948.GA15564@redhat.com> <20060325235035.5fcb902f.akpm@osdl.org> <20060326154042.GB13684@redhat.com> <20060326161055.GA4584@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060326161055.GA4584@mars.ravnborg.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 06:10:55PM +0200, Sam Ravnborg wrote:
> On Sun, Mar 26, 2006 at 10:40:42AM -0500, Dave Jones wrote:
> > 
> > came out of a 'make buildcheck' a day or two ago (the following day,
> > Sam nuked reference_discarded.pl in favour of it being done
> > magically somewhere else (I've not looked into how its done now).
> The check is part of modpost now. modpost is only used when building
> modules but that holds true for most builds anyway therefore I did not
> move it to a separate executable.
>...

This doesn't sound good.

This means that we have no longer any tool that warns us about e.g. 
references from non-__exit code to __exit code [1]?

> 	Sam

cu
Adrian

[1] __exit, not __{dev,cpu,mem}exit

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

