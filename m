Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbVI2Hid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVI2Hid (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 03:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVI2Hid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 03:38:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5794 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932132AbVI2Hid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 03:38:33 -0400
Date: Thu, 29 Sep 2005 08:38:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, bbpetkov@yahoo.de,
       linux-kernel@vger.kernel.org, R.E.Wolff@BitWizard.nl
Subject: Re: [PATCH] remove check_region in drivers-char-specialix.c
Message-ID: <20050929073830.GD9669@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
	bbpetkov@yahoo.de, linux-kernel@vger.kernel.org,
	R.E.Wolff@BitWizard.nl
References: <20050928083737.GA29498@gollum.tnic> <20050928175244.GY7992@ftp.linux.org.uk> <20050928222822.GA14949@gollum.tnic> <20050929011026.GO7992@ftp.linux.org.uk> <20050928184106.49e9db11.akpm@osdl.org> <20050929020510.GR7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929020510.GR7992@ftp.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 03:05:10AM +0100, Al Viro wrote:
> On Wed, Sep 28, 2005 at 06:41:06PM -0700, Andrew Morton wrote:
>  
> > http://www.spinics.net/lists/kernel/msg399680.html
> 
> Ewww...  A lot of chunks consisting only of whitespace removals - great
> way to make patch less readable...
> 
> And yes, that second call of sx_request_io_range() must die.  BTW,
> what's wrong with use of mdelay() instead of that sx_long_delay()
> junk?  Replacing both calls of sx_long_delay() with mdelay(50) would do it...

There's a proper check_region removal for specialix.c patch from me queued
up in the kernel-janitors tree.  Including removal of the silly wrappers.

