Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267515AbUBSUAS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267516AbUBSUAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:00:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:165 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267515AbUBSUAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:00:13 -0500
Date: Thu, 19 Feb 2004 12:04:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jamie Lokier <jamie@shareable.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
In-Reply-To: <40351306.1080207@zytor.com>
Message-ID: <Pine.LNX.4.58.0402191202350.1439@ppc970.osdl.org>
References: <Pine.LNX.4.58.0402181422180.2686@home.osdl.org>
 <Pine.LNX.4.58.0402181427230.2686@home.osdl.org> <16435.60448.70856.791580@samba.org>
 <Pine.LNX.4.58.0402181457470.18038@home.osdl.org> <16435.61622.732939.135127@samba.org>
 <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org>
 <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org>
 <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org>
 <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
 <Pine.LNX.4.58.0402191150120.1270@ppc970.osdl.org> <40351306.1080207@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Feb 2004, H. Peter Anvin wrote:
> 
> How about a compomise - super-intelligent complete nincompoop bastard?

Ok, but in the meantime I think I can save face by saying that you only 
need two system calls, by simply making a "lseek(fd, 0, SEEK_SET)" 
implicitly set the first bit. So then the "set second bit if first is set" 
just becomes a "dcache fill complete" notifier.

So I'll take half credit.

		Linus "super-complete bastard" Torvalds
