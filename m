Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVBVXJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVBVXJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 18:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVBVXJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 18:09:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:56709 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261333AbVBVXJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 18:09:17 -0500
Date: Tue, 22 Feb 2005 15:08:52 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Olof Johansson <olof@austin.ibm.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, jamie@shareable.org,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
Message-ID: <20050222230852.GA10067@kroah.com>
References: <20050222190646.GA7079@austin.ibm.com> <Pine.LNX.4.58.0502221123540.2378@ppc970.osdl.org> <1109106969.5412.138.camel@gaston> <Pine.LNX.4.58.0502221330360.2378@ppc970.osdl.org> <1109108532.5411.149.camel@gaston> <Pine.LNX.4.58.0502221359420.2378@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502221359420.2378@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2005 at 02:10:58PM -0800, Linus Torvalds wrote:
> 
> Oh, well. The reason I hate the rwsem behaviour is exactly because it
> results in this very subtle class of deadlocks. This one case is certainly
> solvable several ways, but do we have other issues somewhere else? Things
> like kobject might be ripe with things like this. The mm semaphore tends
> to be pretty well-behaved - and I'm not sure the same is true of the
> kobject one.

I'm trying to get rid of the kobject (actually the subsystem) rwsem
right now, so it should be gone completly within a few kernel versions.

thanks,

greg k-h
