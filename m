Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWCPQaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWCPQaI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWCPQaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:30:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62911 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932406AbWCPQaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:30:06 -0500
Date: Thu, 16 Mar 2006 16:30:01 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
Message-ID: <20060316163001.GA7222@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net> <20060316160129.GB6407@infradead.org> <20060316082951.58592fdc.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316082951.58592fdc.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 08:29:51AM -0800, Randy.Dunlap wrote:
> On Thu, 16 Mar 2006 16:01:30 +0000 Christoph Hellwig wrote:
> 
> > > The patch implements TRUE and FALSE in include/linux/kernel.h and removes all
> > > the private versions.
> > > 
> > > The patch also kills off a few private implementations of NULL.
> > 
> > NACK.  Just kill them all and use 0/1
> 
> nah, the only place that using symbolic names for true and false
> is a problem is when someone #defines or enums them bassackwards.

it makes the code longer and harder to read.  there's a reason the core
code doesn't use it, and the periphal code should do the same.

