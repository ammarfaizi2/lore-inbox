Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263458AbTFTREh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 13:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTFTREb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 13:04:31 -0400
Received: from air-2.osdl.org ([65.172.181.6]:26825 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263535AbTFTRDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 13:03:05 -0400
Date: Fri, 20 Jun 2003 10:18:56 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Steven Dake <sdake@mvista.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Werner Almesberger <wa@almesberger.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
In-Reply-To: <3EF33E4A.9040608@mvista.com>
Message-ID: <Pine.LNX.4.44.0306201016500.955-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> A class number is an excellent idea, and could have potential 
> performance gains.  I thought of making such a patch, but expected it 
> would be rejected since it is necessarily required and would require 
> changes to significant sections of the kernel (to add the class to each 
> object type).
> 
> Have any better ideas for an implementation that doesn't touch so many 
> sections of the kernel?

It should be trivial - we can use the subsystem name that the kobject 
belongs to for the class ID. And, struct subsystem can gain a sequence 
number, instead of having a global one in lib/kobject.c.


	-pat

