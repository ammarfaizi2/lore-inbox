Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbUBTRPA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 12:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbUBTRPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 12:15:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:36804 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261348AbUBTRO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 12:14:58 -0500
Date: Fri, 20 Feb 2004 09:19:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(),
 O_CLEAN
In-Reply-To: <20040220170438.GA19722@elte.hu>
Message-ID: <Pine.LNX.4.58.0402200911260.2533@ppc970.osdl.org>
References: <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org>
 <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
 <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
 <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
 <20040220120417.GA4010@elte.hu> <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org>
 <20040220170438.GA19722@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Feb 2004, Ingo Molnar wrote:
> 
> there's another class of problems: is it an issue that directory renames
> that move this directory (higher up in the directory hierarchy of this
> directory) do not invalidate the cache? In that case there's no dnotify
> event either.

This is one of the reasons why I worry about user-space caching. It's just 
damn hard to get right. 

It's hard in kernel space too, of course, but we've had smart people
working on the dcache for years. So if we can sanely avoid duplication, 
that would be a good thing.

		Linus
