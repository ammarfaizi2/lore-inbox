Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbUEFPZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUEFPZt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 11:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUEFPZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 11:25:48 -0400
Received: from blacksun.leftmind.net ([204.225.93.62]:47378 "HELO
	blacksun.leftmind.net") by vger.kernel.org with SMTP
	id S262580AbUEFPZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 11:25:43 -0400
Date: Thu, 6 May 2004 11:25:42 -0400
From: Anthony de Boer <linux-kernel@lists.leftmind.net>
To: linux-kernel@vger.kernel.org
Subject: Re: What does tainting actually mean?
Message-ID: <20040506112542.S15845@leftmind.net>
References: <opr65eq9ncshwjtr@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr65eq9ncshwjtr@laptop-linux.wpcb.org.au>; from ncunningham@linuxmail.org on Wed, Apr 28, 2004 at 02:00:35PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> What does tainting actually mean?

It seems to schitzophrenically try to mean two things: on the one hand,
it tries to flag GPL purity, and on the other hand it tries to indicate
whether or not the module's source code is readily available to someone
wanting to debug that kernel.

This was brought home to me awhile ago; up through at least 2.4.18,
net/ipv4/netfilter/ipchains_core.c said MODULE_LICENSE("BSD without
advertisement clause"); and tainted the kernel with code in its own
tarball.

One must ask if BSD code for which you have the source in hand is an evil
thing or not.  Or how about something that's GPL but for which you can't
readily lay hands on the source?  The GPL predates the Web, and doesn't
say you have to be able to Google for source; you might still have to pay
the author the cost of shipping you a 9-track tape.

Proposed: a MODULE_SOURCE string, containing either the path relative to
the kernel directory, or a URL at which source can be found, and you can
decline to debug a kernel if it has modules for which MODULE_SOURCE isn't
given or doesn't lead you to the code.

-- 
Anthony de Boer
