Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265228AbUGIVS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbUGIVS4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 17:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUGIVS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 17:18:56 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:31682 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S265228AbUGIVSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 17:18:54 -0400
Date: Fri, 9 Jul 2004 14:18:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jean-Christophe Dubois <jdubois@mc.com>
Subject: Re: [PATCH] Fix building on Solaris (and don't break Cygwin)
Message-ID: <20040709211853.GH28002@smtp.west.cox.net>
References: <20040709210011.GG28002@smtp.west.cox.net> <20040709211605.GA6126@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709211605.GA6126@infradead.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 10:16:05PM +0100, Christoph Hellwig wrote:

> On Fri, Jul 09, 2004 at 02:00:11PM -0700, Tom Rini wrote:
> > The following is from Jean-Christophe Dubois <jdubois@mc.com>.  On
> > Solaris 2.8, <stdint.h> does not exist, but <inttypes.h> does.  However,
> > on cygwin (the other odd place that the kernel is compiled on)
> > <inttypes.h> doesn't exist.  So we end up with something like the
> > following.
> > Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> 
> Yikes.  <stdint.h> is mandated by C99, please complain to sun instead or
> write up the header yourself - it's not that difficult anyway.

I forgot to CC Jean on this, but that's not exactly a nice option.  In
fact, it'd be fine to just switch to <inttypes.h>, afaics, except that
cygwin doesn't have that.

-- 
Tom Rini
http://gate.crashing.org/~trini/
