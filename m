Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWCNUAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWCNUAT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 15:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWCNUAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 15:00:19 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:37277 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750936AbWCNUAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 15:00:18 -0500
Date: Tue, 14 Mar 2006 15:00:55 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: What is ptrace flag PT_TRACESYSGOOD for?
Message-ID: <20060314200055.GA22286@ccure.user-mode-linux.org>
References: <200603140531_MC3-1-BAA0-B3C3@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603140531_MC3-1-BAA0-B3C3@compuserve.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 05:26:52AM -0500, Chuck Ebbert wrote:
> I am trying to document PTRACE_SETOPTIONS and I can't figure out what
> the option PTRACE_O_TRACESYSGOOD is used for.

It makes it easier to distinguish between the child receiving a
SIGTRAP and making a system call.  On x86, without TRACESYSGOOD, you
can see if orig_eax == -1 to check for a real SIGTRAP.  I'm not sure
about the other arches, but it's nice to have an arch-independent way
of doing it, even if there are equivalents in every arch.

				Jeff
