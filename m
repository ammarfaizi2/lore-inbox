Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWAXSaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWAXSaP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 13:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWAXSaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 13:30:15 -0500
Received: from users.ccur.com ([66.10.65.2]:27833 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S932478AbWAXSaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 13:30:13 -0500
Date: Tue, 24 Jan 2006 13:29:42 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Christoph Hellwig <hch@infradead.org>, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Define __raw_read_lock etc for uniprocessor builds
Message-ID: <20060124182942.GA16241@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20060124180954.GA14506@tsunami.ccur.com> <20060124181712.GA13277@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124181712.GA13277@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 06:17:12PM +0000, Christoph Hellwig wrote:
> On Tue, Jan 24, 2006 at 01:09:54PM -0500, Joe Korty wrote:
> > 
> > Make NOPed versions of __raw_read_lock and family available
> > under uniprocessor kernels.
> > 
> > Discovered when compiling a uniprocessor kernel with the
> > fusyn patch applied.
> > 
> > The standard kernel does not use __raw_read_lock etc
> > outside of spinlock.c, which may account for this bug
> > being undiscovered until now.
> 
> No one should call these directly.   Please fix your odd patch instead.

Actually the patch calls the _raw version which is #defined to the __raw
version.  So it is doing the correct thing.

Joe
