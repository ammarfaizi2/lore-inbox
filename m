Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbUKVFlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbUKVFlU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 00:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUKVFlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 00:41:20 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:10249 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261921AbUKVFlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 00:41:18 -0500
Date: Mon, 22 Nov 2004 05:41:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Peter T. Breuer" <ptb@lab.it.uc3m.es>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: can kfree sleep?
Message-ID: <20041122054112.GA15773@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Peter T. Breuer" <ptb@lab.it.uc3m.es>,
	linux-kernel@vger.kernel.org
References: <20041121211451.GA12826@infradead.org> <200411212230.iALMUcC17182@inv.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411212230.iALMUcC17182@inv.it.uc3m.es>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 11:30:38PM +0100, Peter T. Breuer wrote:
> In article <20041121211451.GA12826@infradead.org> you wrote:
> > On Sun, Nov 21, 2004 at 01:10:38PM -0800, Andrew Morton wrote:
> > > Nope.  All memory freeing codepaths are atomic and may be called from any
> > > context except NMI handlers.
> > 
> > Not true for vfree()
> 
> My interest at the moment is in what can sleep and what cannot sleep.
> Are you saying that vfree can sleep or that vfree cannot be called from
> at least one other context in addition to the NMI handler context (from
> which it cannot be called ...)?

vfree can't sleep, but it can't be called from every context.

