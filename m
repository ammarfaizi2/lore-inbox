Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWGGJy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWGGJy7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 05:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWGGJy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 05:54:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30890 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932097AbWGGJy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 05:54:59 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060706105223.97b9a531.akpm@osdl.org> 
References: <20060706105223.97b9a531.akpm@osdl.org>  <20060706124716.7098.5752.stgit@warthog.cambridge.redhat.com> <20060706124727.7098.44363.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       bernds_cb1@t-online.de, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] FDPIC: Add coredump capability for the ELF-FDPIC binfmt [try #3] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 07 Jul 2006 10:54:36 +0100
Message-ID: <20538.1152266076@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> > +#define roundup(x, y)  ((((x) + ((y) - 1)) / (y)) * (y))
> 
> The GFS2 tree has 
> 
> ...
> +#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))

They aren't exactly equivalent.

In any case, we probably shouldn't be using divide, but should rather be using
shifts since the divisors are powers of two.  I wonder if the compiler will
make the substitution...

David
