Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWFWPgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWFWPgj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWFWPgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:36:39 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:5520 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751472AbWFWPgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:36:38 -0400
Date: Sat, 24 Jun 2006 00:34:44 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Pavel Machek <pavel@suse.cz>
Cc: ntl@pobox.com, linux-kernel@vger.kernel.org, jeremy@goop.org,
       rdunlap@xenotime.net, clameter@sgi.com, akpm@osdl.org,
       ashok.raj@intel.com, ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [RFC][PATCH] avoid cpu hot removal if busy take3
Message-Id: <20060624003444.f84ef901.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060623151005.GB22250@elf.ucw.cz>
References: <20060623164042.3a828e8e.kamezawa.hiroyu@jp.fujitsu.com>
	<20060623142746.GO16029@localdomain>
	<20060623233525.addf1892.kamezawa.hiroyu@jp.fujitsu.com>
	<20060623151005.GB22250@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 17:10:05 +0200
Pavel Machek <pavel@suse.cz> wrote:

> On Fri 2006-06-23 23:35:25, KAMEZAWA Hiroyuki wrote:
> > I don't think so.
> > If we can expect all things can be maintained by user-space in proper way,
> > why we need forced migration ? This patch is just one of possible workarounds. 
> > and implemtns, "success always" and "fail if busy" policy to cpu-hot-remove.
> 
> So... we have piece of policy in kernel, that maybe should not be
> there (forced migration). Now, you want to make that policy optional,
> and add second piece of policy?
> 
> No no, I'm afraid.							Pavel
> 

Ah, okay. the kernel has the policy in it, so we don't need another policy...
Hmm...
I want another one policy which is more conservative,
but if people says  "don't do that", I'll give up this patch..
and consider how to explain users.

Thanks,
-Kame


