Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268074AbUH1VrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268074AbUH1VrK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 17:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268052AbUH1VrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 17:47:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26519 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268108AbUH1Vns
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 17:43:48 -0400
Date: Sat, 28 Aug 2004 22:43:44 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm Kconfig fixes
Message-ID: <20040828214344.GM21964@parcelfarce.linux.theplanet.co.uk>
References: <200408280309.i7S39PPv000756@hera.kernel.org> <20040828210533.GD6301@redhat.com> <20040828221345.A11901@infradead.org> <20040828211717.GF6301@redhat.com> <20040828222206.A11969@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828222206.A11969@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 10:22:06PM +0100, Christoph Hellwig wrote:
> > Bah, I *knew* I'd miss one. I even read the Kconfig twice after missing IA64.
> > I suck. I still stand by my claim that it would look better though.
> 
> Completely agreed on that one.  Negative depencies are a bad idea in general.

ACK.

How about adding HAS_AGP into platform Kconfig and making that animal
dependent on it?

BTW, AFAICS a legitimate form of negative dependency is && (!FOO || BROKEN)
and it's common enough to consider adding a separate
	broken if <expression>
to config language.  It would be interpreted as && (!<expr> || BROKEN) added
to dependencies, but would document the situation better.
