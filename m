Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUBLHKt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 02:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266239AbUBLHKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 02:10:48 -0500
Received: from ns.suse.de ([195.135.220.2]:54195 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266218AbUBLHKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 02:10:47 -0500
Date: Thu, 12 Feb 2004 09:43:23 +0100
From: Andi Kleen <ak@suse.de>
To: Alex Pankratov <ap@swapped.cc>
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] [1/2] hlist: replace explicit checks of hlist
 fields w/ func calls
Message-Id: <20040212094323.291f032f.ak@suse.de>
In-Reply-To: <402B0697.7010109@swapped.cc>
References: <4029CB7B.3090409@swapped.cc>
	<20040213231407.208204c4.ak@suse.de>
	<4029D267.40307@swapped.cc>
	<20040214012805.52e4af60.ak@suse.de>
	<402B0697.7010109@swapped.cc>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Feb 2004 20:52:39 -0800
Alex Pankratov <ap@swapped.cc> wrote:


> A quick note about standard lists then - circular double-linked
> lists are normally described in textbooks as a clever trick
> allowing to avoid if's in insert() and delete(). Given what you
> have noted about CMP speed above, I wonder if simple 0-terminated
> lists would be something to consider for lower-end i386.

That is what hlists are.
Some of the existing users of list_heads could be converted to hlists yes.
Basically all that don't need to access the end of the list in constant time.

-Andi
