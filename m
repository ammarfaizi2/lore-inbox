Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267285AbUBSVov (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267317AbUBSVou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:44:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41626 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267285AbUBSVnz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:43:55 -0500
Date: Thu, 19 Feb 2004 21:43:53 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tridge <tridge@samba.org>, Jamie Lokier <jamie@shareable.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
Message-ID: <20040219214353.GI31035@parcelfarce.linux.theplanet.co.uk>
References: <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org> <Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org> <20040219204515.GG31035@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0402191255540.1439@ppc970.osdl.org> <Pine.LNX.4.58.0402191340080.1439@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402191340080.1439@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 01:45:32PM -0800, Linus Torvalds wrote:
> So we'd see very quickly if these tentative dentries were to escape 
> outside of __d_lookup().

Ahem...  You'll see them (at least) in dcache pruning codepaths.  And
those will dereference inodes...
