Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWCGUJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWCGUJa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 15:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWCGUJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 15:09:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3791 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932338AbWCGUJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 15:09:28 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1141756825.31814.75.camel@localhost.localdomain> 
References: <1141756825.31814.75.camel@localhost.localdomain>  <31492.1141753245@warthog.cambridge.redhat.com> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Tue, 07 Mar 2006 20:09:07 +0000
Message-ID: <9551.1141762147@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Better meaningful example would be barriers versus an IRQ handler. Which
> leads nicely onto section 2

Yes, except that I can't think of one that's feasible that doesn't have to do
with I/O - which isn't a problem if you are using the proper accessor
functions.

Such an example has to involve more than one CPU, because you don't tend to
get memory/memory ordering problems on UP.

The obvious one might be circular buffers, except there's no problem there
provided you have a memory barrier between accessing the buffer and updating
your pointer into it.

David
