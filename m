Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266387AbUFZULC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266387AbUFZULC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 16:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266395AbUFZULC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 16:11:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:36017 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266387AbUFZUKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 16:10:52 -0400
Date: Sat, 26 Jun 2004 13:09:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: Re: Inclusion of UML in 2.6.8
Message-Id: <20040626130945.190fb199.akpm@osdl.org>
In-Reply-To: <200406261905.22710.blaisorblade_spam@yahoo.it>
References: <200406261905.22710.blaisorblade_spam@yahoo.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:
>
> Andrew, what are the requisite for stable inclusion of the UML update inside 
>  2.6-mm

I have no problem plopping it into -mm, as long as it doesn't cause me too
much pain.  It did cause patch management pain last time, but probably
whatever is was interacting with has now been merged up so it'll be OK.

But for a merge into mainline we do need to get down and do some work on it
- reintroducing ghash.h would not be welcome (I though Jeff was going to
eliminate that?) and last time we looked the patch had some blockdev
drivers in it which were doing antiquated 2.4 things.

Generally, UML in 2.6 seems to have fallen behind fairly seriously and at
some stage we need to go through the exercise of splitting the patch up,
reviewing and fixing all the bits and feeding it in.
