Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbSJBWzS>; Wed, 2 Oct 2002 18:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262693AbSJBWzS>; Wed, 2 Oct 2002 18:55:18 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:25582 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262692AbSJBWzR>; Wed, 2 Oct 2002 18:55:17 -0400
Subject: Re: [RFC] LSM changes for 2.5.38
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Seth Arnold <sarnold@wirex.com>
Cc: linux-security-module@wirex.com, Christoph Hellwig <hch@infradead.org>,
       Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021002225542.GA12637@wirex.com>
References: <Pine.GSO.4.33.0209270743170.22771-100000@raven>
	<20020927175510.B32207@infradead.org>
	<200209271809.g8RI92e6002126@turing-police.cc.vt.edu>
	<20020927191943.A2204@infradead.org>
	<200209271854.g8RIsPe6002510@turing-police.cc.vt.edu>
	<20020927195919.A4635@infradead.org>
	<200209301419.g8UEJI6E001699@turing-police.cc.vt.edu>
	<20021001175500.A26635@infradead.org>
	<200210021755.g92HtGLw010852@turing-police.cc.vt.edu>
	<20021002193940.A16376@infradead.org>  <20021002225542.GA12637@wirex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Oct 2002 00:07:59 +0100
Message-Id: <1033600079.25475.33.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-02 at 23:55, Seth Arnold wrote:
> We've said on this list a few times that it is important for security
> module authors to understand the implications of their decisions.
> Deciding to not mediate module parameters is a valid decision. Deciding
> to mediate module parameters is a valid decision. One requires very
> little thought and sidesteps the matter entirely. The other requires
> quite a bit of thought and is difficult to get right -- but that is not
> a problem for LSM, per se; it is for the authors of security modules.

In many cases I disagree. Garbage in - garbage out. That goes for
security policy decisions as well as the revenue. The security modules
must get data that is sufficient to make the decision, locked correctly
and with a defined scope and lifespan.

For example passing an ascii path without thought is useless because you
would race name lookups against things like symlinks. The same goes for
audit stuff which is one of the reasons snare needs a lot of work yet


Alan

