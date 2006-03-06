Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752460AbWCFWy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbWCFWy6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752462AbWCFWy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:54:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33474 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752460AbWCFWy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:54:56 -0500
Date: Mon, 6 Mar 2006 14:54:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Jens Axboe <axboe@suse.de>, Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
In-Reply-To: <Pine.LNX.4.64.0603061423160.13139@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0603061445350.13139@g5.osdl.org>
References: <200603060117.16484.jesper.juhl@gmail.com> 
 <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>  <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
  <200603062136.17098.jesper.juhl@gmail.com> 
 <9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com> 
 <9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com> 
 <Pine.LNX.4.64.0603061306300.13139@g5.osdl.org>
 <9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com>
 <Pine.LNX.4.64.0603061402410.13139@g5.osdl.org> <Pine.LNX.4.64.0603061423160.13139@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Mar 2006, Linus Torvalds wrote:
> 
> Either revert it, or try this (TOTALLY UNTESTED!!!) patch..

Don't even bother with the untested patch.

> +	for (gfporder = 0 ; gfporder < MAX_GFP_ORDER; gfporder++) {

At a minimum, this "<" needs to be "<=".

After that, it might even work. Not that I can convince me that the test 
for "offslab_limit" ever even triggers, so..

		Linus
