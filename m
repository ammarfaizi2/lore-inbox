Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWC3Ap3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWC3Ap3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 19:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWC3Ap3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 19:45:29 -0500
Received: from smop.co.uk ([81.5.177.201]:409 "EHLO hades.smop.co.uk")
	by vger.kernel.org with ESMTP id S1751234AbWC3Ap3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 19:45:29 -0500
Date: Thu, 30 Mar 2006 01:45:18 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       Andi Kleen <ak@muc.de>
Subject: Re: 2.6.16-mm1 leaks in dvb playback
Message-ID: <20060330004518.GA23404@smop.co.uk>
Reply-To: adrian@smop.co.uk
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, Andi Kleen <ak@muc.de>
References: <20060326211514.GA19287@wyvern.smop.co.uk> <20060327172356.7d4923d2.akpm@osdl.org> <20060328070220.GA29429@smop.co.uk> <20060327231630.76e97b83.akpm@osdl.org> <20060329233712.GA21810@smop.co.uk> <20060329160648.59395d67.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060329160648.59395d67.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
From: Adrian Bridgett <adrian@smop.co.uk>
X-smop.co.uk-MailScanner: Found to be clean
X-smop.co.uk-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.702,
	required 5, autolearn=not spam, AWL -0.10, BAYES_00 -2.60,
	NO_RELAYS -0.00)
X-smop.co.uk-MailScanner-From: adrian@smop.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 16:06:48 -0800 (-0800), Andrew Morton wrote:
> adrian <adrian@smop.co.uk> wrote:
> >
> > On Mon, Mar 27, 2006 at 23:16:30 -0800 (-0800), Andrew Morton wrote:
> > > It's unlikely that the sock_inode_cache leak is related to the dcache leak,
> > > but we won't know until we know...
> > 
> > Looks like this might be the same issus as "dcache leak in 2.6.16-git8
> > (II)"...
> > 
> > I think I've found the patch which causes the leak - it was the
> > "use fget_light() in net/socket.c" patch.   I can't see anything
> > I'll try and confirm tomorrow with a nice fresh build.   The command

Well I've just tried 2.6.11-mm1 with that patch reverted and it still
leaks so I must be mistaken I'm afraid.  I'll go and trawl through the
builds I've done and try a simpler config as I reverted back to a
bigger config to confirm it.

Sorry - I had gone through carefully and that was the one that made
the difference.  Back to some more builds :-(

Adrian
