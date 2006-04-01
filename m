Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWDACoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWDACoS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 21:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWDACoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 21:44:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:45547 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751477AbWDACoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 21:44:17 -0500
From: Andi Kleen <ak@suse.de>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Subject: Re: [patch] avoid unaligned access when accessing poll stack
Date: Sat, 1 Apr 2006 04:44:09 +0200
User-Agent: KMail/1.9.1
Cc: Jes Sorensen <jes@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
References: <yq0sloytyj5.fsf@jaguar.mkp.net> <yq0odzmtwni.fsf@jaguar.mkp.net> <20060401023538.GB3157@gaz.sfgoth.com>
In-Reply-To: <20060401023538.GB3157@gaz.sfgoth.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604010444.09747.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 April 2006 04:35, Mitchell Blank Jr wrote:

>   * I also changed "size" to be unsigned since that makes more sense and
>     is less prone to overflow bugs.  I'm also a little scared by the
>     "kmalloc(6 * size)" since that type of call is a classic multiply-overflow
>     security hole (hence libc's calloc() API).  However "size" is constrained
>     by fdt->max_fdset so I think it isn't exploitable.  The kernel doesn't
>     have an overflow-safe API for kmalloc'ing arrays, does it?

kcalloc. But it's slow since it memsets.

-Andi

