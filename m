Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbVAUHMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVAUHMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 02:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVAUHMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 02:12:14 -0500
Received: from news.suse.de ([195.135.220.2]:27530 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262305AbVAUHLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 02:11:48 -0500
Date: Fri, 21 Jan 2005 08:11:44 +0100
From: Andi Kleen <ak@suse.de>
To: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
Cc: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
       linux-kernel@vger.kernel.org, Chris Bruner <cryst@golden.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: COMMAND_LINE_SIZE increasing in 2.6.11-rc1-bk6
Message-ID: <20050121071144.GB657@wotan.suse.de>
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org> <20050120162807.GA3174@stusta.de> <20050120164829.GG450@wotan.suse.de> <Pine.LNX.4.61.0501210857170.17260@webhosting.rdsbv.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501210857170.17260@webhosting.rdsbv.ro>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I really suggest to push this limit to 4k. My reason is that under UML I 
> need to put a lot of stuff in command line and uml crash if I not extend 
> this limit. Can we make it depend on arhitecture?

It's dependent on the architecture already. I would like to enable
it on i386/x86-64 because the kernel command line is often used
to pass parameters to installers, and having a small limit there
can be awkward.

But first need to figure out what went wrong with EDD. 

Matt D., do you have thoughts on this?

-Andi
