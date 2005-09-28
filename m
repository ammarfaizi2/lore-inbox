Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVI1U4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVI1U4n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVI1U4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:56:43 -0400
Received: from pimout5-ext.prodigy.net ([207.115.63.73]:28047 "EHLO
	pimout5-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S1750772AbVI1U4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:56:42 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=sAJ2TmhGb9OLhFZrtQdCle+pW5dvxIH8wOp986V0oY7vNVM8t9MNoBaDGyZw/1byK
	jbOk+tJcYJH2PQo6YKNFQ==
Date: Wed, 28 Sep 2005 13:56:09 -0700
From: David Brownell <david-b@pacbell.net>
To: rjw@sisk.pl
Subject: Re: [linux-usb-devel] Re: 2.6.13-mm2
Cc: torvalds@osdl.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, hugh@veritas.com, daniel.ritz@gmx.ch,
       akpm@osdl.org
References: <20050908053042.6e05882f.akpm@osdl.org>
 <200509282205.49316.daniel.ritz@gmx.ch>
 <20050928202314.54672E3723@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
 <200509282237.12750.rjw@sisk.pl>
In-Reply-To: <200509282237.12750.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050928205609.77623E371B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wednesday, 28 of September 2005 22:23, David Brownell wrote:
> > > > > > BTW, please have a look at:
> > > > > > http://bugzilla.kernel.org/show_bug.cgi?id=4416#c36
> > > > > > and
> > > > > > http://bugzilla.kernel.org/show_bug.cgi?id=4416#c37
> > 
> > What's with the bogus dates in those reports ... claiming some of you
> > were testing 2.6.13-rc2-mm2 more than two months ago, mid-July ?????
>
> Nothing. :-)  2.6.13-rc2-mm2 was out exactly on July 12, and that's when
> I tested it ...

OK, sorry; pardon me!  Then the right question to ask is more like
"So does this still happen in **2.6.14-rc2** ??".  2.6.13-rc is
marginally more recent than 2.4.20, but it still feels old. :)


My other point still stands though.  The IRQ for all HCDs _are_ freed
on suspend, and re-requested on resume ... so lack of such free/request
calls can't possibly be an issue.

The old rule of thumb with USB does still apply though:  be sure to
test with BIOS support for it disabled.

- Dave


