Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262880AbVG2WYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbVG2WYV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 18:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVG2WVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 18:21:48 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:42392 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262902AbVG2WU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 18:20:57 -0400
Date: Fri, 29 Jul 2005 15:20:49 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] String conversions for memory policy
Message-Id: <20050729152049.4b172d78.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
References: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm ... my previous reaction to this conversion code, when you posted
an ancestor of this patch on linux-mm, got buried in the crypically
terse term 'complex API', and that thread went on to discuss matters
of greater substance, such as whether one thread could or should
manipulate the memory policies of another.

I guess it's time I dealt directly with this code ...

My first suspicion on reading it is that it might partially duplicate
some string conversion code and syntax that is already present in
the kernel for other purposes.  For example the nodelists might
replicate the lists of numbers supported by bitmap_scnlistprintf
and bitmap_parselist.

However, since no documentation is presented to describe this new
micro-micro-language for describing memory policies, it is difficult to
know what the syntax is, without reverse engineering it from the code.

So ... how about documenting this string format, then we can discuss
both the syntax and its implementation.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
