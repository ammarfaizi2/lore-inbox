Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422934AbWKPKJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422934AbWKPKJm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 05:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423223AbWKPKJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 05:09:42 -0500
Received: from cantor.suse.de ([195.135.220.2]:59034 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422934AbWKPKJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 05:09:41 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch, -rc6] x86_64: UP build fixes
Date: Thu, 16 Nov 2006 11:09:37 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20061116084855.GA8848@elte.hu> <200611161022.04022.ak@suse.de> <20061116094852.GA19305@elte.hu>
In-Reply-To: <20061116094852.GA19305@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611161109.37172.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 November 2006 10:48, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > On Thursday 16 November 2006 10:17, Andrew Morton wrote:
> > > On Thu, 16 Nov 2006 10:01:01 +0100
> > > Andi Kleen <ak@suse.de> wrote:
> > > 
> > > > +#ifdef CONFIG_HOTPLUG_CPU
> > > >  	hotcpu_notifier(cpu_vsyscall_notifier, 0);
> > > > +#endif
> > > 
> > > this part isn't needed - the definition handles that.
> > 
> > Thanks. Updated patch appended.
> 
> my hotplug-CPU cleanup patch solves this in a cleaner way: by removing 
> all those #ifdefs as well.

Fine, but I suspect that late in the release it's better to go 
for minimal "obvious" fixes. Later it can then be cleaned up properly.

-Andi
