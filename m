Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVBVVbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVBVVbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 16:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVBVVbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 16:31:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:23483 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261255AbVBVVbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 16:31:08 -0500
Date: Tue, 22 Feb 2005 13:31:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Olof Johansson <olof@austin.ibm.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, jamie@shareable.org,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
In-Reply-To: <1109106969.5412.138.camel@gaston>
Message-ID: <Pine.LNX.4.58.0502221330360.2378@ppc970.osdl.org>
References: <20050222190646.GA7079@austin.ibm.com> 
 <Pine.LNX.4.58.0502221123540.2378@ppc970.osdl.org> <1109106969.5412.138.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Feb 2005, Benjamin Herrenschmidt wrote:
> 
> Isn't Olof scheme racy ? Can't the stuff get swapped out between the
> first get_user() and the "real" one ?

Yes. But see my suggested modification (which I still think is "the thing 
that Olof does", except it's more efficient and avoids the race).

If rwsems acted like rwlocks, we wouldn't have this issue at all.

		Linus
