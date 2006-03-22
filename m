Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWCVJCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWCVJCa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 04:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWCVJC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 04:02:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40598 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751133AbWCVJC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 04:02:28 -0500
Subject: Re: [PATCH] hpet header sanitization
From: Arjan van de Ven <arjan@infradead.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       clemens@ladisch.de
In-Reply-To: <20060321162630.d995c63c.rdunlap@xenotime.net>
References: <20060321144607.153d1943.rdunlap@xenotime.net>
	 <20060321161303.53c2895f.akpm@osdl.org>
	 <20060321162630.d995c63c.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 10:02:19 +0100
Message-Id: <1143018140.2955.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 16:26 -0800, Randy.Dunlap wrote:
> On Tue, 21 Mar 2006 16:13:03 -0800 Andrew Morton wrote:
> 
> > "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> > >
> > > From: Randy Dunlap <rdunlap@xenotime.net>
> > > 
> > > Add __KERNEL__ block.
> > > Use __KERNEL__ to allow ioctl interface to be usable.
> > 
> > hm, why?
> 
> because there is a test/example source file in (inside)
> Documentation/hpet.txt that won't build otherwise.
> And because hpet.h contains _userspace_ ioctl interface struct
> and macros...


then please split the header in 2 parts; one for the kernel
and one for userspace


either put both here, or move the kernel one to the directory where the
source code is


