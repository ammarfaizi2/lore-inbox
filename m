Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268144AbUHXBZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268144AbUHXBZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 21:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267967AbUHXBWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 21:22:43 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:18073 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S269090AbUHXBSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 21:18:42 -0400
Date: Tue, 24 Aug 2004 02:18:22 +0100
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, suparna@in.ibm.com
Subject: Re: [PATCH] Writeback page range hint
Message-ID: <20040824011822.GB15668@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	suparna@in.ibm.com
References: <200408232138.i7NLcfJd019125@hera.kernel.org> <20040824010723.GA15668@redhat.com> <20040823181400.7d721370.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040823181400.7d721370.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 06:14:00PM -0700, Andrew Morton wrote:

 > >   > +	int nonblocking:1;		/* Don't get stuck on request queues */
 > >   > +	int encountered_congestion:1;	/* An output: a queue is full */
 > >   > +	int for_kupdate:1;		/* A kupdate writeback */
 > >   > +	int for_reclaim:1;		/* Invoked from the page allocator */
 > > 
 > >  Causes sparse spew..
 > > 
 > >  include/linux/writeback.h:54:19: warning: dubious one-bit signed bitfield
 > >  include/linux/writeback.h:55:30: warning: dubious one-bit signed bitfield
 > >  include/linux/writeback.h:56:19: warning: dubious one-bit signed bitfield
 > >  include/linux/writeback.h:57:19: warning: dubious one-bit signed bitfield
 > 
 > That's fussy of it.  I assume this shuts it up?

very likely (its 2am, and I'm feeling too lazy to check).
though, is there any real reason why they are bitfields at all ?

I'll double check it in the morning when the nightly sparse cron jobs mail me 8-)

		Dave


