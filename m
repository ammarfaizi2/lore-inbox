Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVCGAos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVCGAos (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 19:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVCGAor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 19:44:47 -0500
Received: from fire.osdl.org ([65.172.181.4]:29145 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261605AbVCGAoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 19:44:46 -0500
Date: Sun, 6 Mar 2005 16:46:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Jacobowitz <dan@debian.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Cagney <cagney@redhat.com>, Roland McGrath <roland@redhat.com>
Subject: Re: More trouble with i386 EFLAGS and ptrace
In-Reply-To: <20050306211426.GA4135@nevyn.them.org>
Message-ID: <Pine.LNX.4.58.0503061644590.2304@ppc970.osdl.org>
References: <20050306193840.GA26114@nevyn.them.org>
 <Pine.LNX.4.58.0503061155280.2304@ppc970.osdl.org> <20050306211426.GA4135@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Mar 2005, Daniel Jacobowitz wrote:
> 
> I bought it, but the GDB testsuite didn't.  Both copies seem to be
> necessary; there's generally no signal handler for SIGTRAP

Ahh, duh, yes. I was looking at it and saying "debug fault always 
generates a sigtrap", but you're right, it obviously doesn't - usually 
it's caught by the tracer.

Your patch looks fine.

		Linus
