Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267363AbUBSQiq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 11:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267371AbUBSQip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 11:38:45 -0500
Received: from mail.shareable.org ([81.29.64.88]:10368 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S267363AbUBSQin
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 11:38:43 -0500
Date: Thu, 19 Feb 2004 16:38:38 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: tridge@samba.org, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
Message-ID: <20040219163838.GC2308@mail.shareable.org>
References: <Pine.LNX.4.58.0402171919240.2686@home.osdl.org> <16435.55700.600584.756009@samba.org> <Pine.LNX.4.58.0402181422180.2686@home.osdl.org> <Pine.LNX.4.58.0402181427230.2686@home.osdl.org> <16435.60448.70856.791580@samba.org> <Pine.LNX.4.58.0402181457470.18038@home.osdl.org> <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> For example, the rule can be that _any_ regular dentry create will 
> invalidate all the "case-insensitive" dentries. Just to be simple about 
> it.

If that's the rule, then with exactly the same algorithmic efficiency,
readdir+dnotify can be used to maintain the cache in userspace
instead.  There is nothing gained by using the helper module in that case.

It follows that a helper module is only useful if readdir+dnotify
isn't fast enough, and the invalidation rule has to be more selective.

(Although, maybe there are atomicity concerns I haven't thought of).

-- Jamie
