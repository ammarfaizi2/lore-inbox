Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVDNUSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVDNUSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 16:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVDNUSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 16:18:48 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17615 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261495AbVDNUSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 16:18:36 -0400
Date: Thu, 14 Apr 2005 22:18:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: Matt Mackall <mpm@selenic.com>
Cc: Stefan Seyfried <seife@suse.de>, Herbert Xu <herbert@gondor.apana.org.au>,
       Andreas Steinmetz <ast@domdv.de>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050414201812.GB2801@elf.ucw.cz>
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <20050414065124.GA1357@elf.ucw.cz> <20050414080837.GA1264@gondor.apana.org.au> <200504141104.40389.rjw@sisk.pl> <20050414171127.GL3174@waste.org> <425EC41A.4020307@suse.de> <20050414195352.GM3174@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414195352.GM3174@waste.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > So we would need to zero out the suspend image in swap to prevent the
> > retrieval of this data from the running machine (imagine a
> > remote-root-hole).
> >
> > Zeroing out the suspend image means "write lots of megabytes to the
> > disk" which takes a lot of time.
> 
> Zero only the mlocked regions. This should take essentially no time at
> all. Swsusp knows which these are because they have to be mlocked

I believe this is tricky to implement. You are free to produce patch,
and if that patch is nicer/simpler than Anreas's code, I may consider
it.

> But this is all solvable without resorting to yet another encrypted
> block device scheme. Such a scheme shouldn't even be considered until
> all the other options are thoroughly explored. Any scheme that's
> encrypting the suspend image and then storing the key in the clear is
> either obviously broken or obviously doesn't actually need encryption.

Andreas solved real problem. You are waving hands. Obviously your next
mail should contain a patch.
							Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
