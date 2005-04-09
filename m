Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVDIQV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVDIQV1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 12:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVDIQV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 12:21:27 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:445 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261350AbVDIQVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 12:21:24 -0400
Date: Sat, 9 Apr 2005 09:20:11 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: vrajesh@umich.edu, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
Message-Id: <20050409092011.55f341f4.pj@engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0504081613180.28951@ppc970.osdl.org>
References: <4257055A.7010908@umich.edu>
	<Pine.LNX.4.58.0504081613180.28951@ppc970.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> If you want to have spaces
>  and newlines in your pathname, go wild.

So long as there is only one pathname in a record, you don't need
nul-terminators to be allow spaces in the name.  The rest of the record
is well known, so the pathname is just whatever is left after chomping
off the rest of the record.

It's only the support for embedded newlines that forces you to use
nul-terminators.

Not worth it - in my view.  Rather, do just enough hackery that
such a pathname doesn't break you, even if it means not giving
full service to such names.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
