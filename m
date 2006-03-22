Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWCVUwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWCVUwz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 15:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbWCVUwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 15:52:55 -0500
Received: from xenotime.net ([66.160.160.81]:27009 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932265AbWCVUwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 15:52:54 -0500
Date: Wed, 22 Mar 2006 12:55:03 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, clemens@ladisch.de
Subject: Re: [PATCH] hpet header sanitization
Message-Id: <20060322125503.4281238e.rdunlap@xenotime.net>
In-Reply-To: <1143058082.2955.68.camel@laptopd505.fenrus.org>
References: <20060321144607.153d1943.rdunlap@xenotime.net>
	<20060321161303.53c2895f.akpm@osdl.org>
	<20060321162630.d995c63c.rdunlap@xenotime.net>
	<1143018140.2955.45.camel@laptopd505.fenrus.org>
	<20060322092649.d967c47a.rdunlap@xenotime.net>
	<1143058082.2955.68.camel@laptopd505.fenrus.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2006 21:08:02 +0100 Arjan van de Ven wrote:

> On Wed, 2006-03-22 at 09:26 -0800, Randy.Dunlap wrote:
> > On Wed, 22 Mar 2006 10:02:19 +0100 Arjan van de Ven wrote:
> > 
> > > On Tue, 2006-03-21 at 16:26 -0800, Randy.Dunlap wrote:
> > > > On Tue, 21 Mar 2006 16:13:03 -0800 Andrew Morton wrote:
> > > > 
> > > > > "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> > > > > >
> > > > > > From: Randy Dunlap <rdunlap@xenotime.net>
> > > > > > 
> > > > > > Add __KERNEL__ block.
> > > > > > Use __KERNEL__ to allow ioctl interface to be usable.
> > > > > 
> > > > > hm, why?
> > > > 
> > > > because there is a test/example source file in (inside)
> > > > Documentation/hpet.txt that won't build otherwise.
> > > > And because hpet.h contains _userspace_ ioctl interface struct
> > > > and macros...
> > > 
> > > 
> > > then please split the header in 2 parts; one for the kernel
> > > and one for userspace
> > 
> > so would you tell me what the purpose (use) of __KERNEL__
> > is meant to be, please?
> 
> for legacy headers.. the same ;)

"the same" as what?  I'm not understanding these partial sentences.

> Thats no reason to fix up new cases... things should get better not just
> get a small rubber bandaid...

Yes, I'm not disagreeing with the no-bandaids part.  I just haven't
read that __KERNEL__ is legacy only.


---
~Randy
