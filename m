Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbVI2AAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbVI2AAu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 20:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVI2AAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 20:00:50 -0400
Received: from fmr24.intel.com ([143.183.121.16]:16303 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751257AbVI2AAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 20:00:48 -0400
Date: Wed, 28 Sep 2005 17:00:31 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org, "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [PATCH][Fix][Resend] Fix Bug #4959: Page tables corrupted during resume on x86-64 (take 3)
Message-ID: <20050928170031.D30088@unix-os.sc.intel.com>
References: <200509281624.29256.rjw@sisk.pl> <200509282118.54670.ak@suse.de> <200509282224.43397.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200509282224.43397.rjw@sisk.pl>; from rjw@sisk.pl on Wed, Sep 28, 2005 at 10:24:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 10:24:42PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, 28 of September 2005 21:18, Andi Kleen wrote:
> > Also Suresh S. has a patch out to turn the initial page tables
> > into initdata. It'll probably conflict with that. Needs to be coordinated
> > with him.
> 
> Do you mean the patch at:
> http://www.x86-64.org/lists/discuss/msg07297.html ?
> Unfortunately it interferes with the current swsusp code, which uses
> init_level4_pgt anyway.
> 
> Could we please treat my patch as a (very much needed) urgent bugfix
> and make the whole swsusp code in line with the Suresh's patch later on?
> 
> Suresh, could you please say what you think of it?

My patch as such shouldn't change the behavior of the existing swsup
code. I am making only boot_level4_pgt as initdata. But not the 
init_level4_pgt.

thanks,
suresh
