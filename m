Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVASQ3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVASQ3N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 11:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVASQ3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 11:29:13 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:46242 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261769AbVASQ3L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 11:29:11 -0500
Date: Wed, 19 Jan 2005 08:29:02 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: Make pipe data structure be a circular list of pages, rather than
Message-ID: <20050119162902.GA20656@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Larry McVoy <lm@bitmover.com>
References: <200501070313.j073DCaQ009641@hera.kernel.org> <20050107034145.GI9636@holomorphy.com> <Pine.LNX.4.58.0501062222500.2272@ppc970.osdl.org> <Pine.LNX.4.58.0501062236060.2272@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501062236060.2272@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think you are going to regret making splice() a system call, it shouldn't
be, you'll find cases where it won't work.  Make it a library call built
out of pull() and push(), see my original postings on this and you'll
follow the logic.  Making splice a system call is like putting ftp 
into the kernel, not a good idea.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
