Return-Path: <linux-kernel-owner+w=401wt.eu-S1751523AbWLNFWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWLNFWt (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 00:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWLNFWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 00:22:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56571 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523AbWLNFWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 00:22:48 -0500
X-Greylist: delayed 671 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 00:22:48 EST
Date: Thu, 14 Dec 2006 00:10:15 -0500
From: Bill Nottingham <notting@redhat.com>
To: Greg KH <gregkh@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061214051015.GA3506@nostromo.devel.redhat.com>
Mail-Followup-To: Greg KH <gregkh@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
	Martin Bligh <mbligh@mbligh.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214005532.GA12790@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH (gregkh@suse.de) said: 
> An updated version is below.

If you're adding this, you should probably schedule EXPORT_SYMBOL_GPL
for removal at the same time, as this essentially renders that irrelevant.

That being said...

First, this is adding the measure at module load time. Any copyright
infringment happens on distribution; module load isn't (necessarily)
that; if I write random code and load it, without ever sending it
to anyone, I'm not violating the license, and this would prevent that.
So it seems somewhat misplaced.

Secondly...

> Oh, and for those who have asked me how we would enforce this after this
> date if this decision is made, I'd like to go on record that I will be
> glad to take whatever legal means necessary to stop people from
> violating this.

There's nothing stopping you undertaking these means now. Addition of
this measure doesn't change the copyright status of any code - what was
a violation before would still be a violation. Copyright's not something
like trademark, where it's sue-or-lose - there's no requirement for
constant action, and there's no requirement for enforcement measures.
If I reproduce and start selling copies of the White album, it doesn't
matter that there wasn't a mechanism on the CD that prevented me doing
that - it's still a copyright violation.

Hence, the only purpose of a clause like this legally would seem to be
to *intentionally* go after people using the DMCA. Which seems... tacky.

Of course, I don't have significant code of note in the kernel, so I can't
really prevent you from doing this if you want...

Bill
