Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263691AbTKFQ27 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 11:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbTKFQ26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 11:28:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:34740 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263691AbTKFQ26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 11:28:58 -0500
Date: Thu, 6 Nov 2003 08:28:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Kara <jack@suse.cz>
cc: Herbert Xu <herbert@gondor.apana.org.au>, <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [QUOTA] Drop spin lock when calling request_module
In-Reply-To: <20031106161823.GC25830@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.44.0311060827070.1842-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Nov 2003, Jan Kara wrote:
>  			actqf = NULL;
>  			goto out;

Mind changing this to just a "return NULL" instead and just remove the
label entirely, now that it doesn't actually need to play with any
spinlocks?

I don't mind goto's if there is a _point_ to them, but this one doesn't 
seem to fall under that heading.

		Linus


