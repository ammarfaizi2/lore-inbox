Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267058AbUBRXBk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267066AbUBRXBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:01:40 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:11790 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267058AbUBRXBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:01:12 -0500
Date: Wed, 18 Feb 2004 23:00:55 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, tovalds@osdl.org
Cc: Christoph Hellwig <hch@infradead.org>, paulmck@us.ibm.com,
       arjanv@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-ID: <20040218230055.A14889@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, tovalds@osdl.org, paulmck@us.ibm.com,
	arjanv@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20040216190927.GA2969@us.ibm.com> <20040217073522.A25921@infradead.org> <20040217124001.GA1267@us.ibm.com> <20040217161929.7e6b2a61.akpm@osdl.org> <1077108694.4479.4.camel@laptop.fenrus.com> <20040218140021.GB1269@us.ibm.com> <20040218211035.A13866@infradead.org> <20040218150607.GE1269@us.ibm.com> <20040218222138.A14585@infradead.org> <20040218145132.460214b5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040218145132.460214b5.akpm@osdl.org>; from akpm@osdl.org on Wed, Feb 18, 2004 at 02:51:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 02:51:32PM -0800, Andrew Morton wrote:
> a) Does the export make technical sense?  Do filesystems have
>    legitimate need for access to this symbol?
> 
> (really, a) is sufficient grounds, but for real-world reasons:)
> 
> b) Does the IBM filsystem meet the kernel's licensing requirements?
> 
> 
> It appears that the answers are a): yes and b) probably.

Well, the answer to b) is most likely not.  I see it very hard to argue to
have something like gpfs not beeing a derived work.  The glue code they
had online certainly looked very much like a derived work, and if the new
version got better they wouldn't have any reason to remove it from the
website, right?

> Please, feel free to add additional criteria.  We could also ask "do we
> want to withhold this symbols to encourage IBM to GPL the filesystem" or
> "do we simply refuse to export any symbol which is not used by any GPL
> software" (if so, why?).

Yes.  Andrew, please read the GPL, it's very clear about derived works.
Then please tell me why you think gpfs is not a derived work.

> But at the end of the day, if we decide to not export this symbol, we owe
> Paul a good, solid reason, yes?

Yes.  We've traditionally not exported symbols unless we had an intree user,
and especially not if it's for a module that's not GPL licensed.

We had this discussion with Linus a few time, maybe he can comment again to
make it clear.
