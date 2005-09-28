Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbVI1PA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbVI1PA1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 11:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbVI1PA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 11:00:27 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:20235 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1750981AbVI1PA1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 11:00:27 -0400
Date: Wed, 28 Sep 2005 10:52:50 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [uml-devel] Re: Uml showstopper bugs for 2.6.14
Message-ID: <20050928145250.GB11610@ccure.user-mode-linux.org>
References: <200509271846.51804.blaisorblade@yahoo.it> <20050927193055.GA30451@ccure.user-mode-linux.org> <200509281415.18586.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509281415.18586.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 02:15:18PM +0200, Blaisorblade wrote:
> Do you know when this was introduced, and the last working UML version?

It's always been broken, I think.  It results from the stub having to
sigreturn by hand because it has no access to the libc restorer, and thus 
needing to restore the stack pointer to where it was on entry.  I did this
by popping the requisite number of times.  Bodo fixed this for i386, and
I need to do something similar for x86_64.

				Jeff
