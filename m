Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267371AbUBSQuI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 11:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267380AbUBSQuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 11:50:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:34189 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267371AbUBSQuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 11:50:04 -0500
Date: Thu, 19 Feb 2004 08:54:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: tridge@samba.org, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <20040219163838.GC2308@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
References: <Pine.LNX.4.58.0402171919240.2686@home.osdl.org>
 <16435.55700.600584.756009@samba.org> <Pine.LNX.4.58.0402181422180.2686@home.osdl.org>
 <Pine.LNX.4.58.0402181427230.2686@home.osdl.org> <16435.60448.70856.791580@samba.org>
 <Pine.LNX.4.58.0402181457470.18038@home.osdl.org> <16435.61622.732939.135127@samba.org>
 <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org>
 <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Feb 2004, Jamie Lokier wrote:
> Linus Torvalds wrote:
> > For example, the rule can be that _any_ regular dentry create will 
> > invalidate all the "case-insensitive" dentries. Just to be simple about 
> > it.
> 
> If that's the rule, then with exactly the same algorithmic efficiency,
> readdir+dnotify can be used to maintain the cache in userspace
> instead.  There is nothing gained by using the helper module in that case.

Wrong.

Because the dnotify would trigger EVEN FOR SAMBA OPERATIONS.

Think about it. Think about samba doing a "rename()" within the directory.

		Linus
