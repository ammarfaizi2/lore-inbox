Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVBWSuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVBWSuF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 13:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVBWSuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 13:50:05 -0500
Received: from mail.shareable.org ([81.29.64.88]:57512 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261533AbVBWSt6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 13:49:58 -0500
Date: Wed, 23 Feb 2005 18:49:46 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Olof Johansson <olof@austin.ibm.com>, Joe Korty <joe.korty@ccur.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
Message-ID: <20050223184946.GA11473@mail.shareable.org>
References: <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org> <20050222210752.GG22555@mail.shareable.org> <Pine.LNX.4.58.0502221317270.2378@ppc970.osdl.org> <20050223144940.GA880@tsunami.ccur.com> <Pine.LNX.4.58.0502230751140.2378@ppc970.osdl.org> <20050223171015.GD10256@austin.ibm.com> <20050223182203.GA10931@mail.shareable.org> <Pine.LNX.4.58.0502231033540.2378@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502231033540.2378@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> > I suggest putting it into futex.c, and make it an inline function
> > which takes "u32 __user *".
> 
> Agreed, except we've traditionally just made it "int __user *".

The type signatures in futex.c are a bit mixed up - most places say
"int __user *" but sys_futex() says "u32 __user *".  get_futex_key
uses sizeof(u32) to check the address.

-- Jamie
