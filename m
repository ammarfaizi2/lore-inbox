Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWFWD1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWFWD1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 23:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWFWD1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 23:27:46 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:19363 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751160AbWFWD1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 23:27:46 -0400
Date: Fri, 23 Jun 2006 12:29:02 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, jeremy@goop.org,
       clameter@sgi.com, ntl@pobox.com, akpm@osdl.org, ashok.raj@intel.com,
       ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [PATCH] avoid cpu removal if busy revisited
Message-Id: <20060623122902.3fcabd9b.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060622201953.95bcd6d2.rdunlap@xenotime.net>
References: <20060623105058.96937576.kamezawa.hiroyu@jp.fujitsu.com>
	<20060622201953.95bcd6d2.rdunlap@xenotime.net>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 20:19:53 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote
> 
> Maybe cpu_removal_migrate?  I think that inverts the sysctl
> values though, like so:
> 
> If cpu_removal_migrate == 1, all tasks are migrated by force.
> If cpu_removal_migrate == 0, cpu_hotremoval can fail because of
> not-migratable tasks (tasks bound to the target CPU).
> 
> and init. the sysctl value to 1 as default.
> 
Hmm, I did so at the fist touch but inverted to make default to be 0.
But if default value "1" is Okay, I'll invert. It makes sense.


> > +int moderate_cpu_removal;
> 
> This is also declared (defined?  I get those mixed up) in
> kernel/sysctl.c.  One of them (this one I think) should be
> extern, but we prefer externs in a header file if possible.
> 
> 
Thanks, I'll fix and test carefully...
I need barrels of coffee today..

Thanks,
-Kame

