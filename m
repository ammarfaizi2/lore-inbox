Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269390AbUICI2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269390AbUICI2D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 04:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269363AbUICIXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 04:23:14 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:27141 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269394AbUICITc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:19:32 -0400
Date: Fri, 3 Sep 2004 09:19:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Amit Gud <amitgud@gmail.com>
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org, gud@eth.net
Subject: Re: Using filesystem blocks
Message-ID: <20040903091926.B2288@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Amit Gud <amitgud@gmail.com>, Chris Wedgwood <cw@f00f.org>,
	linux-kernel@vger.kernel.org, gud@eth.net
References: <2c6b3ab004090212293b394b41@mail.gmail.com> <20040902200743.GB6875@taniwha.stupidest.org> <2c6b3ab0040902215656704680@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <2c6b3ab0040902215656704680@mail.gmail.com>; from amitgud@gmail.com on Fri, Sep 03, 2004 at 10:26:23AM +0530
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 10:26:23AM +0530, Amit Gud wrote:
> > 
> > > Is it wise enough to abstract away the usage of blocks for storing
> > > extended attributes?
> > 
> > No.  Some fs' will store xattr data in the inodes if it fits.
> > 
> 
> First up, why is mbcache code is written at VFS layer than being
> filesystem specific? Neccessarily to take away the coding overheads of
> maintaining block cache that any filesystem uses, even though given
> that only ext2 and ext3 uses it. It facilitates code reuse.

It is not written at the VFS level.  It's a library ontop of the buffercache
than can be reused by filesystems.
