Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266214AbUBDAHk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 19:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUBDAHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 19:07:40 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:59918 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266214AbUBDAHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 19:07:38 -0500
Date: Wed, 4 Feb 2004 00:07:35 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
       Miquel van Smoorenburg <miquels@cistron.nl>,
       Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-ID: <20040204000735.A12232@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miquel van Smoorenburg <miquels@cistron.nl>,
	Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <bv8qr7$m2v$1@news.cistron.nl> <20040129063009.GD2474@frodo> <bv8qr7$m2v$1@news.cistron.nl> <20040128222521.75a7d74f.akpm@osdl.org> <20040129063009.GD2474@frodo> <20040129232033.GA10541@cistron.nl> <20040204000315.A12127@infradead.org> <20040204000623.GI15492@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040204000623.GI15492@khan.acc.umu.se>; from tao@acc.umu.se on Wed, Feb 04, 2004 at 01:06:23AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 01:06:23AM +0100, David Weinehall wrote:
> > -	va.va_mask = XFS_AT_NLINK|XFS_AT_SIZE|XFS_AT_NBLOCKS;
> > +	va.va_mask = XFS_AT_NLINK|XFS_AT_SIZE|XFS_AT_NBLOCKS|XFS_AT_SIZE;
> 
> Huh? XFS_AT_SIZE twice?!

Ah thanks.  Stupid braino but fortunately harmless..

