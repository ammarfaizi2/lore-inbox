Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267064AbUBSJLi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 04:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267052AbUBSJLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 04:11:38 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:51362 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S267064AbUBSJLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 04:11:35 -0500
Date: Thu, 19 Feb 2004 10:11:32 +0100
From: David Weinehall <tao@acc.umu.se>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, paulmck@us.ibm.com,
       arjanv@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-ID: <20040219091132.GE17140@khan.acc.umu.se>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Christoph Hellwig <hch@infradead.org>, paulmck@us.ibm.com,
	arjanv@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20040216190927.GA2969@us.ibm.com> <20040217073522.A25921@infradead.org> <20040217124001.GA1267@us.ibm.com> <20040217161929.7e6b2a61.akpm@osdl.org> <1077108694.4479.4.camel@laptop.fenrus.com> <20040218140021.GB1269@us.ibm.com> <20040218211035.A13866@infradead.org> <20040218150607.GE1269@us.ibm.com> <20040218222138.A14585@infradead.org> <20040218145132.460214b5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218145132.460214b5.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 02:51:32PM -0800, Andrew Morton wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > I don't understand why IBM is pushing this dubious change right now,
> 
> It isn't a dubious change, on technical grounds.  It is reasonable for a
> distributed filesystem to want to be able to shoot down pte's which map
> sections of pagecache.  Just as it is reasonable for the filesystem to be
> able to shoot down the pagecache itself.
> 
> We've exported much lower-level stuff than this, because some in-kernel
> module happened to use it.

Probably not always the right choice, though...  I highly suspect we
far to much of our intestines are easily available.

[snip]

> We need to give Paul a reasoned and logically consistent answer to his
> request.  For that we need to establish some sort of framework against
> which to make a decision and then make the decision.  
> 
> One approach is a fait-accomplis from the top-level maintainer.  Here,
> we're trying to do it in a different way.
> 
> I have proposed two criteria upon which this should be judged:
> 
> a) Does the export make technical sense?  Do filesystems have
>    legitimate need for access to this symbol?
> 
> (really, a) is sufficient grounds, but for real-world reasons:)
> 
> b) Does the IBM filsystem meet the kernel's licensing requirements?
> 
> 
> It appears that the answers are a): yes and b) probably.

a.) Definitely
b.) Perhaps
 
> Please, feel free to add additional criteria.  We could also ask "do we
> want to withhold this symbols to encourage IBM to GPL the filesystem" or
> "do we simply refuse to export any symbol which is not used by any GPL
> software" (if so, why?).  Over to you.

Well, I wasn't altogether joking when I suggested IBM should GPL gpfs.
A couple of questions:

* Is gpfs a commercial product in the sense that it's something IBM
  earns revenue from?
* Does gpfs contain third party "Intellectual Property" (no, I'm not
  particularly fond of using that expression, but I digress)

If the answer is NO to both of these questions, why _not_ GPL the code?
If the answer is NO to only the second question, is the revenue from
gpfs big enough to warrant keeping it proprietary?

> But at the end of the day, if we decide to not export this symbol, we owe
> Paul a good, solid reason, yes?

Yup.  Silence isn't always golden, sometimes it's outright shitty.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
