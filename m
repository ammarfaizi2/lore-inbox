Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266071AbUAFGHZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 01:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266072AbUAFGHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 01:07:25 -0500
Received: from unthought.net ([212.97.129.88]:8415 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S266071AbUAFGHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 01:07:24 -0500
Date: Tue, 6 Jan 2004 07:07:22 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Pentium M config option for 2.6
Message-ID: <20040106060722.GA27889@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Tomas Szepe <szepe@pinerecords.com>,
	Mikael Pettersson <mikpe@csd.uu.se>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <200401041227.i04CReNI004912@harpo.it.uu.se> <20040104123358.GB24913@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040104123358.GB24913@louise.pinerecords.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 01:33:58PM +0100, Tomas Szepe wrote:
> On Jan-04 2004, Sun, 13:27 +0100
> Mikael Pettersson <mikpe@csd.uu.se> wrote:
> 
> > IOW, don't lie to the compiler and pretend P-M == P4
> > with that -march=pentium4.
> 
> What do you recommend to use as march then?  There is
> no pentiumm subarch support in gcc yet;  I was convinced
> p4 was the closest match.

Use the same as for P-III.

The P-M has the same instruction decoder (and execution unit) setup as
the P-III, which is *very* different from P-IV (which has one decoder
only, and then a trace cache for the decoded uops).  This is an
important difference from a code generator point of view.

>From reading Intel's optimization guides, it seems to me like the P-M is
pretty much just a slightly enhanced P-III (more cache AFAIR) which
happens to get shipped with a good mobile chipset - and that package
together is called Centrino.

That would also explain why Centrino leaves the P-IV based laptops in
the dust ;)

Cheers,

 / jakob

