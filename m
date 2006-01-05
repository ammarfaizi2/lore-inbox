Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWAEL03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWAEL03 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 06:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWAEL03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 06:26:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49639 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932130AbWAEL02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 06:26:28 -0500
Date: Thu, 5 Jan 2006 06:26:11 -0500
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: mm/rmap.c negative page map count BUG.
Message-ID: <20060105112611.GM20809@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
	linux-kernel@vger.kernel.org
References: <20060103082609.GB11738@redhat.com> <43BA630F.1020805@yahoo.com.au> <20060103135312.GB18060@redhat.com> <20060104155326.351a9c01.akpm@osdl.org> <20060105074718.GF20809@redhat.com> <1136448712.2920.4.camel@laptopd505.fenrus.org> <20060105111520.GL20809@redhat.com> <1136459923.2920.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136459923.2920.17.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 12:18:43PM +0100, Arjan van de Ven wrote:
 > On Thu, 2006-01-05 at 06:15 -0500, Dave Jones wrote:
 > > On Thu, Jan 05, 2006 at 09:11:51AM +0100, Arjan van de Ven wrote:
 > >  > 
 > >  > > Quite a few Fedora users have hit it over the last year,
 > >  > > but what I find fascinating is that there's not a single
 > >  > > occurance of "BUG at mm/rmap.c" in our 2.6.9 based RHEL4 bug reports.
 > >  > 
 > >  > could mean it's caused by consumer hardware code...
 > > 
 > > Yeah. People buying enterprise distros do tend to buy branded RAM
 > > with goodies like ECC from big name suppliers instead of a cheap $20
 > > noname DIMM from "Joe's computers".
 > > 
 > > So it *could* be a lot of these are crappy hardware, especially
 > > as some of the reports do indicate that the problem went away
 > > when they upgraded their RAM.  Some of the others though, I'm
 > > not so sure.
 > 
 > it could also be some consumer-mostly device, or driver thereof. say
 > video capture or weird usb gizmo

except looking at the oopses, there's no obvious pattern amongst
the modules loaded.  Though they could all have a commonality as
a built-in driver, it's a long-shot.

even looking at the Fedora ones alone, which have no built-in
drivers, there's nothing that immediately jumps out like
"ooh, radeon again".  I'll look through them again tomorrow,
but first, sleep.

		Dave

