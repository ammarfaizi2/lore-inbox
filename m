Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVBVVnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVBVVnz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 16:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVBVVny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 16:43:54 -0500
Received: from gate.crashing.org ([63.228.1.57]:35551 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261282AbVBVVnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 16:43:12 -0500
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Olof Johansson <olof@austin.ibm.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, jamie@shareable.org,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0502221330360.2378@ppc970.osdl.org>
References: <20050222190646.GA7079@austin.ibm.com>
	 <Pine.LNX.4.58.0502221123540.2378@ppc970.osdl.org>
	 <1109106969.5412.138.camel@gaston>
	 <Pine.LNX.4.58.0502221330360.2378@ppc970.osdl.org>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 08:42:12 +1100
Message-Id: <1109108532.5411.149.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-22 at 13:31 -0800, Linus Torvalds wrote:
> 
> On Wed, 23 Feb 2005, Benjamin Herrenschmidt wrote:
> > 
> > Isn't Olof scheme racy ? Can't the stuff get swapped out between the
> > first get_user() and the "real" one ?
> 
> Yes. But see my suggested modification (which I still think is "the thing 
> that Olof does", except it's more efficient and avoids the race).
> 
> If rwsems acted like rwlocks, we wouldn't have this issue at all.

Yours is probably the most efficient too. Note sure what is best for
rwsems tho, there seem to be some interest preventing readers from
starving writers for ever, this has been debated endlessly iirc,
though I have no personal opinion there.

Ben.


