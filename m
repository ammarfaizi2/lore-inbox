Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbVHKTPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVHKTPx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 15:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVHKTPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 15:15:53 -0400
Received: from pat.uio.no ([129.240.130.16]:26846 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932384AbVHKTPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 15:15:52 -0400
Subject: Re: fcntl(F_GETLEASE) semantics??
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Heikki Orsila <shd@modeemi.cs.tut.fi>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Chubb <peterc@gelato.unsw.edu.au>
In-Reply-To: <20050811190252.GF31158@jolt.modeemi.cs.tut.fi>
References: <20050811184144.GE31158@jolt.modeemi.cs.tut.fi>
	 <1123786619.7095.47.camel@lade.trondhjem.org>
	 <20050811190252.GF31158@jolt.modeemi.cs.tut.fi>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 15:15:45 -0400
Message-Id: <1123787745.7095.53.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.922, required 12,
	autolearn=disabled, AWL 1.08, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 11.08.2005 Klokka 22:02 (+0300) skreiv Heikki Orsila:
> On Thu, Aug 11, 2005 at 02:56:59PM -0400, Trond Myklebust wrote:
> > inotify does not give you synchronous notification. It just tells you
> > something has happened after the fact. Not the same thing at all.
> 
> Then what could be done for inotify to fit the purpose? SETLEASE is 
> still a bad interface for userspace programs because it relies on 
> signals and thus can't be conveniently put into shared libraries..

What applications other than the very specialised case of filesystem
servers do you expect will ever want to use it?

The difference between inotify and leases is, as I said, that leases
notify the lease holder synchronously. This allows the notified process
to flush all the cached information _before_ the operation that
triggered the lease notification is executed.

Cheers,
  Trond

