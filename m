Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267256AbTGRH3Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 03:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267978AbTGRH3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 03:29:25 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:58381 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267256AbTGRH3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 03:29:24 -0400
Date: Fri, 18 Jul 2003 08:44:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Christoph Hellwig <hch@infradead.org>, Ro0tSiEgE LKML <lkml@ro0tsiege.org>,
       KML <linux-kernel@vger.kernel.org>
Subject: Re: devfsd
Message-ID: <20030718084417.B14336@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schlemmer <azarah@gentoo.org>,
	Ro0tSiEgE LKML <lkml@ro0tsiege.org>,
	KML <linux-kernel@vger.kernel.org>
References: <20030715214610.GA21238@core.citynetwireless.net> <20030717165603.A8369@infradead.org> <1058507844.13515.1579.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1058507844.13515.1579.camel@workshop.saharacpt.lan>; from azarah@gentoo.org on Fri, Jul 18, 2003 at 07:57:24AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 07:57:24AM +0200, Martin Schlemmer wrote:
> Apart from obvious/known inefficiencies, it works fine over here :P
> 
> Any way, if you are serious, what make you consider it broken (no,
> not talking about personal preferences/phobias 8)

There's unsolvable design issues in the way devfsd communication works
(with the last two patches the holes are closed as much as possible)
and it's fundamentally flawed by putting device name policy into
the kernel.   And then there's of course certain implementation quality
issues...

We have udev now which solves what devfs tried to solve without that
issues so people should switch to that ASAP.  That doesn't mean we
can simply rip it out because people started to rely on the non-standard
device names, but it's use is pretty much discouraged in 2.6.

