Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVDORCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVDORCH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 13:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVDORCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 13:02:06 -0400
Received: from waste.org ([216.27.176.166]:41355 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261865AbVDORCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 13:02:03 -0400
Date: Fri, 15 Apr 2005 10:00:12 -0700
From: Matt Mackall <mpm@selenic.com>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Stefan Seyfried <seife@suse.de>, Herbert Xu <herbert@gondor.apana.org.au>,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050415170010.GV3174@waste.org>
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <20050414065124.GA1357@elf.ucw.cz> <20050414080837.GA1264@gondor.apana.org.au> <200504141104.40389.rjw@sisk.pl> <20050414171127.GL3174@waste.org> <425EC41A.4020307@suse.de> <20050414195352.GM3174@waste.org> <425F8CE6.90200@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425F8CE6.90200@domdv.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 11:44:06AM +0200, Andreas Steinmetz wrote:
> Matt Mackall wrote:
> > Zero only the mlocked regions. This should take essentially no time at
> > all. Swsusp knows which these are because they have to be mlocked
> > after resume as well. If it's not mlocked, it's liable to be swapped
> > out anyway.
> 
> Nitpicking:
> What happens if the disk decides to relocate a close to failing sector
> containing mlocked data during resume zeroing? This just means that
> there will be sensitive data around on the disk that can't be  zeroed
> out anymore but which might be recovered by specialized
> companies/institutions.
> Encrypting these data in the first place reduces this problem to a
> single potentially problematic sector.

Well that's what the dmcrypt phase is for.

-- 
Mathematics is the supreme nostalgia of our time.
