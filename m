Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVBJTQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVBJTQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 14:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVBJTPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 14:15:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42631 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261359AbVBJTPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 14:15:38 -0500
Date: Thu, 10 Feb 2005 19:15:25 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Patrick Gefre <pfg@sgi.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, matthew@wil.cx,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] Altix : ioc4 serial driver support
Message-ID: <20050210191525.GA11284@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Patrick Gefre <pfg@sgi.com>,
	linux-kernel@vger.kernel.org, matthew@wil.cx,
	B.Zolnierkiewicz@elka.pw.edu.pl
References: <20050103140938.GA20070@infradead.org> <20050207162525.GA15926@infradead.org> <4208EE3A.6010500@sgi.com> <200502101109.43455.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502101109.43455.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 11:09:43AM -0800, Jesse Barnes wrote:
> On Tuesday, February 8, 2005 8:52 am, Patrick Gefre wrote:
> > I've update the patch with changes from the comments below.
> >
> > ftp://oss.sgi.com/projects/sn2/sn2-update/033-ioc4-support
> >
> > Christoph Hellwig wrote:
> > > On Mon, Feb 07, 2005 at 09:58:33AM -0600, Patrick Gefre wrote:
> > >>Latest version with review mods:
> > >>ftp://oss.sgi.com/projects/sn2/sn2-update/033-ioc4-support
> > >
> > >  - still not __iomem annotations.
> >
> > I *think* I have this right ??
> 
> Here's the output from 'make C=1' with your driver patched in (you if you want
> to run it yourself, just copy tomahawk.engr:~jbarnes/bin/sparse to somewhere
> in your path and run 'make C=1').  I think most of these warning would be
> fixed up if the structure fields referring to registers were declared as
> __iomem, but I haven't looked carefully.

Actually the pointers to the struct need to be declared __iomem.  

