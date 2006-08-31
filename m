Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWHaG1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWHaG1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 02:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWHaG1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 02:27:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39317 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750711AbWHaG1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 02:27:21 -0400
Subject: Re: [FOR 2.6.18 FIX][PATCH]  drm: radeon flush TCL VAP for vertex
	program enable/disable
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@linux.ie>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0608301550090.27779@g5.osdl.org>
References: <Pine.LNX.4.64.0608302314360.21600@skynet.skynet.ie>
	 <20060830154152.9ac71753.akpm@osdl.org>
	 <Pine.LNX.4.64.0608301550090.27779@g5.osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 31 Aug 2006 08:27:13 +0200
Message-Id: <1157005633.2715.62.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-30 at 15:53 -0700, Linus Torvalds wrote:
> 
> On Wed, 30 Aug 2006, Andrew Morton wrote:
> > 
> > That's a somewhat weird-looking patch.  It adds code which is quite
> > dissimilar from all the other cases in that switch statement.
> 
> It looks ok to me, although you have to look into the caller to see why it 
> does what it does.
> 
> It would be "prettier" if it changed the size and data of the incoming 
> packet instead, but the code as is isn't actually set up to be able to do 
> that (the size setup and verification stuff is done before the fixup).
> 
> That said, I'd have expected that the VAP state flush is really something 
> that the _client_ should do when it generates the commands, not the kernel 
> after the fact. 

but the client is unprivileged userspace!
The kernel needs to ensure correctness and probably even enforce it.


