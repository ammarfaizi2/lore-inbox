Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263109AbTI3Fhx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 01:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263114AbTI3Fhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 01:37:53 -0400
Received: from colin2.muc.de ([193.149.48.15]:19211 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263109AbTI3Fhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 01:37:52 -0400
Date: 30 Sep 2003 07:38:03 +0200
Date: Tue, 30 Sep 2003 07:38:03 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon Prefetch workaround for 2.6.0test6
Message-ID: <20030930053803.GA75928@colin2.muc.de>
References: <20030929125629.GA1746@averell> <20030929170323.GC21798@mail.jlokier.co.uk> <20030929174910.GA90905@colin2.muc.de> <20030929221346.GA25171@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929221346.GA25171@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 11:13:46PM +0100, Jamie Lokier wrote:
> Andi Kleen wrote:
> > I guess they should be added to the AMD64 version too. It ignores
> > all bases, but I'm not sure if the CPU catches the case where the linear
> > address computation wraps.
> 
> The linear address is _allowed_ to wrap on x86, and there are real
> DOS-era programs which take advantage of this.  It is used to create
> the illusion of access to high addresses, by making them wrap to low
> ones which can be mapped.

Only when the A20 gate is set (?), which it never is in Linux.

-Andi
