Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVJIUQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVJIUQf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 16:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVJIUQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 16:16:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19608 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932285AbVJIUQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 16:16:35 -0400
Date: Sun, 9 Oct 2005 13:16:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ext3 warning for unused var
In-Reply-To: <20051009195850.27237.90873.stgit@zion.home.lan>
Message-ID: <Pine.LNX.4.64.0510091314200.31407@g5.osdl.org>
References: <20051009195850.27237.90873.stgit@zion.home.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Oct 2005, Paolo 'Blaisorblade' Giarrusso wrote:
>
> Can please someone merge this? It's the 3rd time I send it.

I don't like #ifdef's in code. 

You could just have split up the quota-specific stuff into a function of 
their own: "ext3_show_quota_options()". The patch might have been larger, 
but it would actually clean up the code rather than make it uglier.

Warnings are not a reason for ugly code.

		Linus
