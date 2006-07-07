Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWGGKVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWGGKVP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 06:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWGGKVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 06:21:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55696 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932116AbWGGKVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 06:21:13 -0400
Date: Fri, 7 Jul 2006 03:20:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, torvalds@osdl.org, bernds_cb1@t-online.de,
       sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] FDPIC: Add coredump capability for the ELF-FDPIC
 binfmt [try #3]
Message-Id: <20060707032038.efb71d9d.akpm@osdl.org>
In-Reply-To: <20538.1152266076@warthog.cambridge.redhat.com>
References: <20060706105223.97b9a531.akpm@osdl.org>
	<20060706124716.7098.5752.stgit@warthog.cambridge.redhat.com>
	<20060706124727.7098.44363.stgit@warthog.cambridge.redhat.com>
	<20538.1152266076@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jul 2006 10:54:36 +0100
David Howells <dhowells@redhat.com> wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> 
> > > +#define roundup(x, y)  ((((x) + ((y) - 1)) / (y)) * (y))
> > 
> > The GFS2 tree has 
> > 
> > ...
> > +#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
> 
> They aren't exactly equivalent.

OK.

I count 45 different implementations of this in the tree.  Ho hum.

> In any case, we probably shouldn't be using divide, but should rather be using
> shifts since the divisors are powers of two.  I wonder if the compiler will
> make the substitution...
> 

It usually manages to.  iirc, less successfully if signed quantities are
used.
