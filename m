Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbUJZJi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbUJZJi1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 05:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbUJZJi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 05:38:27 -0400
Received: from verein.lst.de ([213.95.11.210]:16093 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262198AbUJZJhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 05:37:01 -0400
Date: Tue, 26 Oct 2004 11:36:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "David S. Miller" <davem@davemloft.net>,
       Werner Almesberger <wa@almesberger.net>, hch@lst.de, davem@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove dead tcp exports
Message-ID: <20041026093653.GA22059@lst.de>
References: <20041024134309.GB20267@lst.de> <20041026000710.D3841@almesberger.net> <20041025204147.667ee2b1.davem@davemloft.net> <1098765665.9404.5.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098765665.9404.5.camel@krustophenia.net>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 12:41:05AM -0400, Lee Revell wrote:
> On Mon, 2004-10-25 at 20:41 -0700, David S. Miller wrote:
> > On Tue, 26 Oct 2004 00:07:10 -0300
> > Werner Almesberger <wa@almesberger.net> wrote:
> > 
> > > Wheee, you had me scared for a moment. But indeed, not even tcpcp
> > > (tcpcp.sf.net) uses any of these. But I kind of wonder how you
> > > determine they're "dead" ?
> > 
> > There are scripts which build everything as possible as modules
> > then greps the symbol tables of the object files to see which
> > symbols exported by the kernel are actually used.
> 
> Is this really a compelling reason to remove them?  For example ALSA
> provides an API for driver writers, just because a certain function
> happens not to be used by any does not mean is never will be or that it
> should not.

I've excluded functions where I thoug hthe API makes sense.  Of course
I don't know all code in the kernel nor do I always make the right
decision, so I ask the maintainers for their opinion.

