Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbUEQPWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUEQPWt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 11:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUEQPWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 11:22:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:56791 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261631AbUEQPWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 11:22:41 -0400
Date: Mon, 17 May 2004 08:22:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Wayne Scott <wscott@bitmover.com>, akpm@osdl.org, elenstev@mesatop.com,
       lm@bitmover.com, wli@holomorphy.com, hugh@veritas.com, adi@bitmover.com,
       scole@lanl.gov, support@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page?
In-Reply-To: <20040517151738.GA4730@thunk.org>
Message-ID: <Pine.LNX.4.58.0405170820560.25502@ppc970.osdl.org>
References: <200405162136.24441.elenstev@mesatop.com>
 <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org> <20040516231120.405a0d14.akpm@osdl.org>
 <20040517.085640.30175416.wscott@bitmover.com> <20040517151738.GA4730@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 May 2004, Theodore Ts'o wrote:
> 
> Note though that the stdio library uses a writeable mmap to implement
> fwrite.

It does? Whee. Then I'll have to agree with Andrew - if there is a path 
that is more likely to have bugs, it's trying to do writes with mmap and 
ftruncate.

Who came up with that braindead idea? Is it some crazed Mach developer 
that infiltrated the glibc development group?

		Linus
