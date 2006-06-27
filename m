Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWF0InZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWF0InZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 04:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWF0InZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 04:43:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32717 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751283AbWF0InY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 04:43:24 -0400
Date: Tue, 27 Jun 2006 18:42:37 +1000
From: Nathan Scott <nathans@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>,
       Steven Whitehouse <swhiteho@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060627184237.A1295371@wobbly.melbourne.sgi.com>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com> <20060623144928.GA32694@infradead.org> <20060626200300.GA15424@elte.hu> <20060627063339.GA27938@elte.hu> <20060627181632.A1297906@wobbly.melbourne.sgi.com> <20060627082240.GA672@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060627082240.GA672@elte.hu>; from mingo@elte.hu on Tue, Jun 27, 2006 at 10:22:40AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 10:22:40AM +0200, Ingo Molnar wrote:
> yeah, you are right - sorry about that.

No worries.

> which is in essence an open-coded GFP_NOFAIL implementation. Here's what 
> __GFP_NOFAIL does:

Heh, trust me, I know very well what the code does here.

> and since XFS makes use of KM_SLEEP in 130+ callsites, that means it is 
> in essence using GFP_NOFAIL massively!

Their locations have been carefully audited and understood.  The original
issue here was IRIX being able to do a very good of preventing kernel
memory allocation failures, which I suspect caused the original XFS guys
to be fairly relaxed in their handling of memory allocation failures.
Its caused us no end of pain with the Linux port, I assure you.

But, I digress.  If Christoph says you have a problem, you probably do;
he really is not biased XFS's way - he's driven us to make many changes
leading up to our major merge points too, and he will happily point out
crappy code in XFS as well. ;-)

cheers.

-- 
Nathan
