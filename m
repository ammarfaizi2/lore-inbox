Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030560AbWJDNoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030560AbWJDNoL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 09:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030530AbWJDNoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 09:44:11 -0400
Received: from [198.99.130.12] ([198.99.130.12]:9889 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030531AbWJDNoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 09:44:10 -0400
Date: Wed, 4 Oct 2006 09:41:22 -0400
From: Jeff Dike <jdike@addtoit.com>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Message-ID: <20061004134122.GA3789@ccure.user-mode-linux.org>
References: <45150CD7.4010708@aknet.ru> <451E3C0C.10105@aknet.ru> <1159887682.2891.537.camel@laptopd505.fenrus.org> <45229A99.6060703@aknet.ru> <efv957$31o$2@taverner.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efv957$31o$2@taverner.cs.berkeley.edu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 03:17:59AM +0000, David Wagner wrote:
> To be honest, I still don't think you've answered Arjan's question.  Ok,
> so you say it is not a library and not a binary.  So what is it that you
> are maping in as executable, and why do you think it is reasonable to
> ask the Linux kernel to allow you to execute it, if it lives on a noexec
> partition?

He mentioned UML as being one thing affected by this.  In this case, you
can think of it as generating code in a piece of shared memory and
then executing it.  In reality, the code is read from disk rather than
being generated internally, and it's executed in a different process,
so it needs to be MAP_SHARED.

				Jeff
