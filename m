Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWAQShf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWAQShf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWAQShe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:37:34 -0500
Received: from pat.uio.no ([129.240.130.16]:4796 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932326AbWAQShe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:37:34 -0500
Subject: Re: Kernel 2.6.15.1 + NFS is 4 times slower than FTP!?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Phil Oester <kernel@linuxace.com>, linux-kernel@vger.kernel.org,
       apiszcz@lucidpixels.com
In-Reply-To: <Pine.LNX.4.64.0601171324010.25508@p34>
References: <Pine.LNX.4.64.0601161957300.16829@p34>
	 <20060117012319.GA22161@linuxace.com>
	 <Pine.LNX.4.64.0601162031220.2501@p34>
	 <Pine.BSO.4.63.0601171846570.15077@rudy.mif.pg.gda.pl>
	 <1137521483.14135.59.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0601171324010.25508@p34>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 13:37:14 -0500
Message-Id: <1137523035.7855.91.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.336, required 12,
	autolearn=disabled, AWL 0.62, FORGED_RCVD_HELO 0.05,
	PLING_QUERY 0.86, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 13:24 -0500, Justin Piszcz wrote:
> Alan, is it normal for FTP to be 2x as fast as NFS?
> With 100mbps, I never seemed to have any issues, but with GIGABIT I 
> definitely see all sorts of weird issues.

Reading or writing?

The readahead algorithm has been borken in 2.6.x for at least the past 6
months. It leads to NFS collapsing down to 4k reads on the wire instead
of doing 32k or 64k.
An effort was made to look at fixing this, but it turns out that nobody
really understands the current messy implementation, and so progress has
been slow.

Cheers,
  Trond

