Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWFWPLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWFWPLz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWFWPLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:11:55 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48094 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751438AbWFWPLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:11:54 -0400
Date: Fri, 23 Jun 2006 17:10:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Nathan Lynch <ntl@pobox.com>, linux-kernel@vger.kernel.org,
       jeremy@goop.org, rdunlap@xenotime.net, clameter@sgi.com, akpm@osdl.org,
       ashok.raj@intel.com, ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [RFC][PATCH] avoid cpu hot removal if busy take3
Message-ID: <20060623151005.GB22250@elf.ucw.cz>
References: <20060623164042.3a828e8e.kamezawa.hiroyu@jp.fujitsu.com> <20060623142746.GO16029@localdomain> <20060623233525.addf1892.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623233525.addf1892.kamezawa.hiroyu@jp.fujitsu.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-06-23 23:35:25, KAMEZAWA Hiroyuki wrote:
> On Fri, 23 Jun 2006 09:27:46 -0500
> Nathan Lynch <ntl@pobox.com> wrote:
> 
> > KAMEZAWA Hiroyuki wrote:
> > > This patch adds sysctl cpu_removal_migration.
> > > If cpu_removal_migration == 1, all tasks are migrated by force.
> > > If cpu_removal_migration == 0, cpu_hotremoval can fail because of not-migratable
> > > tasks.
> > > 
> > > Note: cpu scheduler's notifier chain has the highest priority. then, this
> > >       failure detection will be done at first.
> > 
> > I'm still not convinced that this is a good thing to do.  I reiterate:
> > this can be implemented in userspace (probably with fewer lines of
> > code, even).  Why should this policy be in the kernel?
> > 
> I don't think so.
> If we can expect all things can be maintained by user-space in proper way,
> why we need forced migration ? This patch is just one of possible workarounds. 
> and implemtns, "success always" and "fail if busy" policy to cpu-hot-remove.

So... we have piece of policy in kernel, that maybe should not be
there (forced migration). Now, you want to make that policy optional,
and add second piece of policy?

No no, I'm afraid.							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
