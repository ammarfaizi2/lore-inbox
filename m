Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbWARAnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbWARAnf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWARAnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:43:35 -0500
Received: from pat.uio.no ([129.240.130.16]:13274 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965011AbWARAnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:43:33 -0500
Subject: Re: Kernel 2.6.15.1 + NFS is 4 times slower than FTP!?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Phil Oester <kernel@linuxace.com>, linux-kernel@vger.kernel.org,
       apiszcz@lucidpixels.com
In-Reply-To: <1137541179.3587.10.camel@mindpipe>
References: <Pine.LNX.4.64.0601161957300.16829@p34>
	 <20060117012319.GA22161@linuxace.com>
	 <Pine.LNX.4.64.0601162031220.2501@p34>
	 <Pine.BSO.4.63.0601171846570.15077@rudy.mif.pg.gda.pl>
	 <1137521483.14135.59.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0601171324010.25508@p34>
	 <1137523035.7855.91.camel@lade.trondhjem.org>
	 <Pine.LNX.4.64.0601171338040.25508@p34>
	 <1137523991.7855.103.camel@lade.trondhjem.org>
	 <Pine.LNX.4.64.0601171354510.25508@p34>
	 <1137524502.7855.107.camel@lade.trondhjem.org>
	 <Pine.LNX.4.61.0601172139230.30708@yvahk01.tjqt.qr>
	 <Pine.LNX.4.64.0601171545310.19112@p34>
	 <Pine.LNX.4.61.0601172307030.7756@yvahk01.tjqt.qr>
	 <1137536034.19678.43.camel@mindpipe>
	 <Pine.LNX.4.64.0601171819370.30825@p34> <1137541179.3587.10.camel@mindpipe>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 19:43:14 -0500
Message-Id: <1137544994.7855.234.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.629, required 12,
	autolearn=disabled, AWL 1.33, FORGED_RCVD_HELO 0.05,
	PLING_QUERY 0.86, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 18:39 -0500, Lee Revell wrote:
> On Tue, 2006-01-17 at 18:19 -0500, Justin Piszcz wrote:
> > man mount
> > 
> 
> async is the default for most filesystems but the NFS standard requires
> writes to be synchronous.

On the server side, note. Not the client side. Justin appears to be
looking at the client, whereas you are referring to an export option on
the server.

The client only guarantees that writes must have been committed to disk
on the server when either fsync() or close() have been called.

Cheers,
  Trond

