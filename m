Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267514AbUHPKiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267514AbUHPKiy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 06:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267516AbUHPKiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 06:38:54 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:21509 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267514AbUHPKiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 06:38:52 -0400
Date: Mon, 16 Aug 2004 11:38:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20040816113848.A9683@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0408151311340.27003@skynet> <20040815133432.A1750@infradead.org> <Pine.LNX.4.58.0408160038320.9944@skynet> <20040816101732.A9150@infradead.org> <Pine.LNX.4.58.0408161019040.21177@skynet> <20040816105014.A9367@infradead.org> <Pine.LNX.4.58.0408161101050.21177@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0408161101050.21177@skynet>; from airlied@linux.ie on Mon, Aug 16, 2004 at 11:29:48AM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 11:29:48AM +0100, Dave Airlie wrote:
> 1) move the DRM to be a real PCI driver now - stop fb from working on same
> card
> 
> 2) move the DRM to act like a real PCI driver when fb isn't loaded, when
> we merge we rip the code out..

3) stop making broken changes.

	You do stop fb from beeing loaded after drm
and thus break perfectly working setups during stable series.  And you
introduce indeterministic behaviour, and although I haven't looked at the
code because unlike every guideline tells you you didn't post it to do the
list, probably horribly broken code.

If you want pci_driver semantics - and apparently you do - move fbdev
and drm into a common driver or introduce a stub.  This was discussed to
death and all kinds of list and Kernel Summit and now please follow what
was agreed on instead of introducing subtile hacks.
