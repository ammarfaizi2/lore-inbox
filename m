Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWFWOgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWFWOgB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWFWOgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:36:01 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:6886 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750791AbWFWOgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:36:00 -0400
Date: Fri, 23 Jun 2006 23:35:25 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, jeremy@goop.org,
       rdunlap@xenotime.net, clameter@sgi.com, akpm@osdl.org,
       ashok.raj@intel.com, ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [RFC][PATCH] avoid cpu hot removal if busy take3
Message-Id: <20060623233525.addf1892.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060623142746.GO16029@localdomain>
References: <20060623164042.3a828e8e.kamezawa.hiroyu@jp.fujitsu.com>
	<20060623142746.GO16029@localdomain>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 09:27:46 -0500
Nathan Lynch <ntl@pobox.com> wrote:

> KAMEZAWA Hiroyuki wrote:
> > This patch adds sysctl cpu_removal_migration.
> > If cpu_removal_migration == 1, all tasks are migrated by force.
> > If cpu_removal_migration == 0, cpu_hotremoval can fail because of not-migratable
> > tasks.
> > 
> > Note: cpu scheduler's notifier chain has the highest priority. then, this
> >       failure detection will be done at first.
> 
> I'm still not convinced that this is a good thing to do.  I reiterate:
> this can be implemented in userspace (probably with fewer lines of
> code, even).  Why should this policy be in the kernel?
> 
I don't think so.
If we can expect all things can be maintained by user-space in proper way,
why we need forced migration ? This patch is just one of possible workarounds. 
and implemtns, "success always" and "fail if busy" policy to cpu-hot-remove.

-Kame

