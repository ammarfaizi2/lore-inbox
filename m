Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWDDVBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWDDVBZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 17:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWDDVBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 17:01:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56280 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750822AbWDDVBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 17:01:24 -0400
Date: Tue, 4 Apr 2006 14:00:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, mtk-manpages@gmx.net,
       nickpiggin@yahoo.com.au
Subject: Re: [patch 1/1] sys_sync_file_range()
Message-Id: <20060404140008.6dedc374.akpm@osdl.org>
In-Reply-To: <20060404205055.GA5745@agluck-lia64.sc.intel.com>
References: <200603300741.k2U7fQLe002202@shell0.pdx.osdl.net>
	<20060404205055.GA5745@agluck-lia64.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luck, Tony" <tony.luck@intel.com> wrote:
>
> On Wed, Mar 29, 2006 at 11:41:11PM -0800, akpm@osdl.org wrote:
> > @@ -318,8 +318,9 @@
> >  #define __NR_unshare		310
> >  #define __NR_set_robust_list	311
> >  #define __NR_get_robust_list	312
> > +#define __NR_sys_sync_file_range 313
> 
> What's up with the __NR_sys_yada_yada?

brainfart.  sync_file_range() and splice() will get fixed once Linus
resurfaces.

>  Except for recent entries (kexec,
> splice, and now sync_file_range) all of the other names in here have
> dropped the "sys_".
> 
> Is it too late to fix __NR_sys_kexec_load (since it is out in the
> wild now?)

It only affects users of the _syscallN macros in unistd.h.  I don't expect
that fixing kexec will break much.
