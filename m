Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVGNOit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVGNOit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 10:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVGNOit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 10:38:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62596 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261418AbVGNOij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 10:38:39 -0400
Date: Thu, 14 Jul 2005 15:38:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Yura Pakhuchiy <pakhuchiy@gmail.com>
Cc: Nathan Scott <nathans@sgi.com>, linux-xfs@oss.sgi.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       tibor@altlinux.ru, pakhuchiy@iptel.by
Subject: Re: XFS corruption on move from xscale to i686
Message-ID: <20050714143830.GA17842@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Yura Pakhuchiy <pakhuchiy@gmail.com>,
	Nathan Scott <nathans@sgi.com>, linux-xfs@oss.sgi.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tibor@altlinux.ru, pakhuchiy@iptel.by
References: <1120756552.5298.10.camel@pc299.sam-solutions.net> <20050708042146.GA1679@frodo> <60868aed0507130822c2e9e97@mail.gmail.com> <20050714012048.GB937@frodo> <60868aed050714065047e3aaec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60868aed050714065047e3aaec@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 04:50:01PM +0300, Yura Pakhuchiy wrote:
> 2005/7/14, Nathan Scott <nathans@sgi.com>:
> > On Wed, Jul 13, 2005 at 06:22:28PM +0300, Yura Pakhuchiy wrote:
> > > I found patch by Greg Ungreger to fix this problem, but why it's still
> > > not in mainline? Or it's a gcc problem and should be fixed by gcc folks?
> > 
> > Yes, IIRC the patch was incorrect for other platforms, and it sure
> > looked like an arm-specific gcc problem (this was ages back, so
> > perhaps its fixed by now).
> 
> AFAIR gcc-3.4.3 was released after this conversation take place at linux-xfs,
> maybe add something like this:
> 
> #ifdef XSCALE
>     /* We need this because some gcc versions for xscale are broken. */
>     [patched version here]
> #else
>     [original version here]
> #endif

no, just fix your compiler or let the gcc folks do it.  Did anyone of
the arm folks ever open a PR at the gcc bugzilla with a reproduced
testcase?  You're never get your compiler fixed with that attitude.

