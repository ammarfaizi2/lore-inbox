Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVBVVUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVBVVUU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 16:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVBVVUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 16:20:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:10975 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261250AbVBVVUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 16:20:14 -0500
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Olof Johansson <olof@austin.ibm.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, jamie@shareable.org,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Howells <dhowells@redhat.com>
In-Reply-To: <1109106969.5412.138.camel@gaston>
References: <20050222190646.GA7079@austin.ibm.com>
	 <Pine.LNX.4.58.0502221123540.2378@ppc970.osdl.org>
	 <1109106969.5412.138.camel@gaston>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 08:19:20 +1100
Message-Id: <1109107160.5326.140.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-23 at 08:16 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2005-02-22 at 11:36 -0800, Linus Torvalds wrote:
> 
> > DavidH - what's the word on nested read-semaphores like this? Are they 
> > supposed to work (like nested read-spinlocks), or do we need to do the 
> > things Olof does?
> 
> Isn't Olof scheme racy ? Can't the stuff get swapped out between the
> first get_user() and the "real" one ?

Forget it, I missed the check_user_page_readable() guy within the
semaphore protection. I didn't know that function ;)

Ben.


