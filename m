Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVGaBpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVGaBpV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 21:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVGaBpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 21:45:21 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:20622 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261466AbVGaBpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 21:45:18 -0400
Date: Sat, 30 Jul 2005 18:45:11 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] String conversions for memory policy
Message-Id: <20050730184511.2af8bb8a.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.62.0507300844010.24809@graphe.net>
References: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
	<20050729152049.4b172d78.pj@sgi.com>
	<Pine.LNX.4.62.0507291746000.8663@graphe.net>
	<20050729225432.63b3dfb0.pj@sgi.com>
	<Pine.LNX.4.62.0507300844010.24809@graphe.net>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> this could be construet as a single string

I said "single token."  I meant as in a single word, not a string of
multiple tokens having its own internal syntax.  Heck - if by 'string'
you just mean a sequence of bytes, then I could construe any data
representation as a 'string'.

I don't know if it is a good idea in this case, but each time we add
another pseudo file system interface to the kernel, we should make
an effort to keep the contents of each such pseudo file to a number,
a list of comparable numbers, or a single word.

I'm pretty sure this convention (single number or word per file,
or at most a list of numbers) has been encouraged elsewhere, though
I don't see where offhand.

I do think it is a good idea to be reluctant to introduce new magic
syntax, such as seen in "bind={3/normal 1/high 0/dma}" in kernel-user
interfaces.  Though, as I noted in my previous post a few minutes ago,
I sure hope we don't need zones here anyway - just nodes.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
