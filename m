Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVA0WcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVA0WcE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 17:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVA0WcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 17:32:04 -0500
Received: from twin.jikos.cz ([213.151.79.26]:15290 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S261248AbVA0WcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 17:32:01 -0500
Date: Thu, 27 Jan 2005 23:31:50 +0100 (CET)
From: Jirka Kosina <jikos@jikos.cz>
To: John Richard Moser <nigelenki@comcast.net>
cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
In-Reply-To: <41F92721.1030903@comcast.net>
Message-ID: <Pine.LNX.4.58.0501272323150.9190@twin.jikos.cz>
References: <20050127101117.GA9760@infradead.org> <20050127101322.GE9760@infradead.org>
 <41F92721.1030903@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005, John Richard Moser wrote:

> Your patch 5/6 for mmap rand is also small.  1M is trivial, though I'd
> imagine mmap() rand would pose a bit more confusion in some cases at
> least, even for small ranges.
> Still, this is a joke, like OpenBSD's stackgap.

Also, besides security implications of stack randomization, there is one 
more aspect that should not be forgotten - stack randomization (even for 
quite small range) could be useful to distribute a pressure on cache 
(which may not be fully associative in all cases), so if everyone runs 
with stack on the same address, it could impose quite noticeable stress on 
some cachelines (those representing stack addresses), while other will 
be idling unused.

I thought that this was the original purpose of the "stack randomization" 
which is shipped for example by RedHat kernels, as the randomization is 
quite small and easy to bruteforce, so it can't serve too much as a buffer 
overflow protection.

-- 
JiKos.
