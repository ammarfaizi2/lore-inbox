Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWJJPd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWJJPd0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 11:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbWJJPd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 11:33:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6025 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750761AbWJJPdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 11:33:25 -0400
Date: Tue, 10 Oct 2006 08:33:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Pavel Machek <pavel@ucw.cz>,
       =?ISO-8859-1?Q?Fr=E9d=E9ric_Riss?= <frederic.riss@gmail.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com
Subject: Re: 2.6.18 suspend regression on Intel Macs
In-Reply-To: <1160476889.3000.282.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0610100830370.3952@g5.osdl.org>
References: <1160417982.5142.45.camel@funkylaptop>  <20061010103910.GD31598@elf.ucw.cz>
 <1160476889.3000.282.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Oct 2006, Arjan van de Ven wrote:
> 
> "fix" for some value of the word.

The value would be every _meaningful_ value.

> The problem is that this is very much against the spec, and also quite
> likely breaks a bunch of machines...

No, it was not shown to break a single machine, and since the SCI bit was 
supposed to be on, it's a no-op on any non-broken hardware.

> If we do this we probably should at least key this of some DMI
> identification for the mac mini..

No. That would be silly.

Having _conditional_ code is not only bigger, it's orders of magnitude 
more complex and likely to break. It's much better to say: "We know at 
least one machine needs this" than it is to say "We know machine X needs 
this", because the latter has extra complexity that just doesn't buy you 
anything.

It's much better to treat everybody the same, if that works. That way, you 
don't have different code-paths.

		Linus
