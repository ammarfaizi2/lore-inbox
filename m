Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268256AbTGLSZD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 14:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268257AbTGLSZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 14:25:03 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:65171 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S268256AbTGLSZA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 14:25:00 -0400
Date: Sat, 12 Jul 2003 19:39:29 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 'what to expect'
Message-ID: <20030712183929.GA10450@mail.jlokier.co.uk>
References: <20030711140219.GB16433@suse.de> <20030712152406.GA9521@mail.jlokier.co.uk> <3F103018.6020008@pobox.com> <20030712112722.55f80b60.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030712112722.55f80b60.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> > One problem is O_DIRECT should return an error on open(2) or fcntl(2), 
> >  not write(2).
> 
> That is the 2.5 behaviour.

What do you mean?

The problem with db4 is that operations on O_DIRECT handles now return
EINVAL if the address isn't suitable aligned, and db4 is not expecting
that - it aborts.  That was true for 2.5.74, at least.

-- Jamie
