Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbUKWJDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbUKWJDe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 04:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbUKWJDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 04:03:33 -0500
Received: from [213.146.154.40] ([213.146.154.40]:3009 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262345AbUKWJD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 04:03:29 -0500
Date: Tue, 23 Nov 2004 09:03:25 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Guillaume Thouvenin <Guillaume.Thouvenin@Bull.net>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.9] fork: add a hook in do_fork()
Message-ID: <20041123090325.GA22114@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Guillaume Thouvenin <Guillaume.Thouvenin@Bull.net>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <1101189797.6210.53.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101189797.6210.53.camel@frecb000711.frec.bull.fr>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 07:03:17AM +0100, Guillaume Thouvenin wrote:
> Hello,
> 
>    For a module, I need to execute a function when a fork occurs. My
> solution is to add a pointer to a function (called fork_hook) in the
> do_fork() and if this pointer isn't NULL, I call the function. To update
> the pointer to the function I export a symbol (called trace_fork) that
> defines another function with two parameters (the hook and an
> identifier). This function provides a simple mechanism to manage access
> to the fork_hook variable.
> 
>    I don't know if this solution is good but it's easy to implement and
> it just does the trick. I made some tests and it doesn't impact the
> performance of the Linux kernel. 
> 
>    I'd like to have your comment about this patch. Is it useful and is
> it needed by someone else than me? 

Use SGI's PAGG patches if you want such hooks.  Also this is clearly
a _GPL export.

