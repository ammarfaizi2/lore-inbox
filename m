Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVBZXs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVBZXs4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 18:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVBZXs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 18:48:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:30922 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261300AbVBZXsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 18:48:42 -0500
Date: Sat, 26 Feb 2005 15:49:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
cc: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] partitions/msdos.c
In-Reply-To: <20050226234053.GA14236@apps.cwi.nl>
Message-ID: <Pine.LNX.4.58.0502261546380.25732@ppc970.osdl.org>
References: <20050226213459.GA21137@apps.cwi.nl>
 <16928.62091.346922.744462@hertz.ikp.physik.tu-darmstadt.de>
 <Pine.LNX.4.58.0502261424430.25732@ppc970.osdl.org> <20050226225203.GA25217@apps.cwi.nl>
 <Pine.LNX.4.58.0502261510030.25732@ppc970.osdl.org> <20050226234053.GA14236@apps.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 27 Feb 2005, Andries Brouwer wrote:
> 
> (Concerning the "size" version: it occurred to me that there is one
> very minor objection: For extended partitions so far the size did
> not normally play a role. Only the starting sector was significant.
> If, at some moment we decide also to check the size, then a weaker
> check, namely only checking for non-extended partitions, might be
> better at first.)

Yes. I agree - checking the size is likely _more_ dangerous and likely to
break something silly than checking the ID for zero.

So your patch it is. I'll put it in immediately after doing a 2.6.11 
(no need to worry about getting into 2.6.11, since afaik the worst problem 
right now is an extra partition that isn't usable).

		Linus
