Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268767AbUILShd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268767AbUILShd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 14:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268776AbUILShd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 14:37:33 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:1704 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S268767AbUILShb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 14:37:31 -0400
Date: Sun, 12 Sep 2004 20:37:30 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Dawson Engler <engler@csl.stanford.edu>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Dawson Engler <engler@coverity.dreamhost.com>,
       linux-kernel@vger.kernel.org, developers@coverity.com
Subject: Re: [CHECKER] possible reiserfs deadlock in 2.6.8.1
Message-ID: <20040912183729.GA22865@MAIL.13thfloor.at>
Mail-Followup-To: Dawson Engler <engler@csl.stanford.edu>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Dawson Engler <engler@coverity.dreamhost.com>,
	linux-kernel@vger.kernel.org, developers@coverity.com
References: <20040908033628.GV23987@parcelfarce.linux.theplanet.co.uk> <200409080510.i885ANcX025884@csl.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409080510.i885ANcX025884@csl.stanford.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 10:10:23PM -0700, Dawson Engler wrote:
> > On Tue, Sep 07, 2004 at 08:16:53PM -0700, Dawson Engler wrote:
> > > Hi All,

Hey Dawson!

> > > below is a possible deadlock in the linux-2.6.8.1 reiserfs code found by
> > > a static deadlock checker I'm writing.  Let me know if it looks valid

is this tool somewhere available? via CVS or similar?

I would be interested in analyzing some kernel patches
with it. if it isn't available, maybe you could check
some patches with it, and send/publish the results?

TIA,
Herbert

> > > and/or whether the output is too cryptic.    Note, one of the locks is
> > > through a struct pointer, so the deadlock depends on both acquisitions
> > > being to the same struct.
> > 
> > Not valid, for the same reason as the above.  BKL and down() do not form
> > a mutual deadlock.
> 
> You know, I actually know this, and the tool "does" take care of this.
> I think a bit mask got screwed up somewhere.  Along with my brain...
> 
> Sorry about the noise.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
