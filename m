Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267170AbUI0SoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267170AbUI0SoX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 14:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266895AbUI0SoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 14:44:22 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:10515 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267170AbUI0Sn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 14:43:58 -0400
Date: Mon, 27 Sep 2004 19:43:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Antony Suter <suterant@users.sourceforge.net>
Cc: Christoph Hellwig <hch@infradead.org>,
       List LKML <linux-kernel@vger.kernel.org>, torvalds@osdl.org
Subject: Re: [PATCH] __VMALLOC_RESERVE export
Message-ID: <20040927194353.A26669@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Antony Suter <suterant@users.sourceforge.net>,
	List LKML <linux-kernel@vger.kernel.org>, torvalds@osdl.org
References: <1096304623.9430.8.camel@hikaru.lan> <20040927181229.A25704@infradead.org> <1096309603.9430.17.camel@hikaru.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1096309603.9430.17.camel@hikaru.lan>; from suterant@users.sourceforge.net on Tue, Sep 28, 2004 at 04:26:43AM +1000
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 04:26:43AM +1000, Antony Suter wrote:
> On Tue, 2004-09-28 at 03:12, Christoph Hellwig wrote:
> > On Tue, Sep 28, 2004 at 03:03:43AM +1000, Antony Suter wrote:
> > > __VMALLOC_RESERVE itself is not exported but is used by something that
> > > is. This patch is against 2.6.9-rc2-bk11
> > > 
> > > This is required by the nvidia binary driver 1.0.6111
> > 
> > And the driver does absolutely nasty things it shouldn't do.  This is an
> > implementation detail that absolutely should not be exported.
> 
> However __VMALLOC_RESERVE, specific to arch-i386 is now used by the
> macro MAXMEM. MAXMEM is _not_ specific to arch-i386. The nvidia driver
> has a kernel module that uses the macro MAXMEM. Is it wrong for a kernel
> module to use MAXMEM?

Yes.

