Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbTJIPTD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 11:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbTJIPTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 11:19:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:42696 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262306AbTJIPTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 11:19:00 -0400
Date: Thu, 9 Oct 2003 08:17:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@colin2.muc.de>
cc: Andi Kleen <ak@muc.de>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <bos@serpentine.com>
Subject: Re: [PATCH] Fix mlockall for PROT_NONE mappings
In-Reply-To: <20031009151212.GA54555@colin2.muc.de>
Message-ID: <Pine.LNX.4.44.0310090816360.1694-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 9 Oct 2003, Andi Kleen wrote:
> 
> Ok. But what is with mappings that have MAY_READ not set ?
> [not 100% this cannot happen]

Well, PROT_NONE will not have MAY_READ set, and no, they won't get locked 
into memory.

But neither did they get locked in before either, so it's not like it's a 
new issue. Now we'd just ignore them nicely rather than abort the 
lockall(). Hmm?

		Linus

