Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263417AbUJ2Rj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263417AbUJ2Rj6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 13:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbUJ2Rj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 13:39:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:30343 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263460AbUJ2Rfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:35:52 -0400
Date: Fri, 29 Oct 2004 10:35:46 -0700
From: Chris Wright <chrisw@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm2: `key_init' multiple definition
Message-ID: <20041029103546.G14339@build.pdx.osdl.net>
References: <20041029014930.21ed5b9a.akpm@osdl.org> <20041029114511.GJ6677@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041029114511.GJ6677@stusta.de>; from bunk@stusta.de on Fri, Oct 29, 2004 at 01:45:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk (bunk@stusta.de) wrote:
> On Fri, Oct 29, 2004 at 01:49:30AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.10-rc1-mm1:
> >...
> > +key_init-ordering-fix.patch

I don't think this is needed.  The fix in Linus's tree should be
sufficient, which was simply:

-subsys_initcall(key_init);
+security_initcall(key_init);

> >  Fix early oops with the key management code
> >...
> > All 381 patches:
> >...
> > reiser4-only.patch
> >   reiser4: main fs

This should really be reiser_key_init, or similar.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
