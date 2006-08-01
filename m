Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161345AbWHALnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161345AbWHALnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932673AbWHALnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:43:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40910 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932672AbWHALnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:43:23 -0400
Date: Tue, 1 Aug 2006 12:43:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Denis Vlasenko <vda.linux@googlemail.com>, reiser@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: reiser4: maybe just fix bugs?
Message-ID: <20060801114312.GA19120@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Denis Vlasenko <vda.linux@googlemail.com>, reiser@namesys.com,
	linux-kernel@vger.kernel.org
References: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com> <20060801013104.f7557fb1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801013104.f7557fb1.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 01:31:04AM -0700, Andrew Morton wrote:
> On Mon, 31 Jul 2006 10:26:55 +0100
> "Denis Vlasenko" <vda.linux@googlemail.com> wrote:
> 
> > The reiser4 thread seem to be longer than usual.
> I'd say that resier4's major problem is the lack of xattrs, acls and
> direct-io.

I though the namesys folks finally switched to the generic read/write
code?  With that implementing direct I/O should become rather simple -
they need a get_block routines that deals with these writes aswell as the
reads mostly.

> The plugins appear to be wildly misnamed - they're just an internal
> abstraction layer which permits later feature additions to be added in a
> clean and safe manner.  Certainly not worth all this fuss.

That because the real plugins are long gone.  It's just that neither the
complainers nor the fanboys in this thread ever read the code or generally
had any clue of their own.
