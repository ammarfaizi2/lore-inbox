Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262755AbVD2PGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbVD2PGR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 11:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbVD2PFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 11:05:32 -0400
Received: from ns2.suse.de ([195.135.220.15]:227 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262755AbVD2PCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 11:02:50 -0400
Date: Fri, 29 Apr 2005 17:02:48 +0200
From: Andi Kleen <ak@suse.de>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: handle iret faults better
Message-ID: <20050429150248.GK21080@wotan.suse.de>
References: <Pine.LNX.4.58.0504252102180.18901@ppc970.osdl.org> <200504290345.j3T3jZZr032230@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504290345.j3T3jZZr032230@magilla.sf.frob.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch makes faults in iret produce the normal signals that would
> result from the same errors when executing some user-mode instruction.
> To accomplish this, I've extended the exception_table mechanism to support
> "special fixups".  Instead of a PC location to jump to, these have a
> function called in the trap handler context and passed the full trap details.

As written earlier I dont like this patch because it is far too complicated.
I would just fake a simple signal in the error handler, all the other
complicated infrastructure seems unnecessary.


Linus, Andrew, please dont apply this patch.

-Andi
