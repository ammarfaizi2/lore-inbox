Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWAQSxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWAQSxj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWAQSxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:53:38 -0500
Received: from pat.uio.no ([129.240.130.16]:16592 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932404AbWAQSxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:53:37 -0500
Subject: Re: Kernel 2.6.15.1 + NFS is 4 times slower than FTP!?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Phil Oester <kernel@linuxace.com>, linux-kernel@vger.kernel.org,
       apiszcz@lucidpixels.com
In-Reply-To: <Pine.LNX.4.64.0601171338040.25508@p34>
References: <Pine.LNX.4.64.0601161957300.16829@p34>
	 <20060117012319.GA22161@linuxace.com>
	 <Pine.LNX.4.64.0601162031220.2501@p34>
	 <Pine.BSO.4.63.0601171846570.15077@rudy.mif.pg.gda.pl>
	 <1137521483.14135.59.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0601171324010.25508@p34>
	 <1137523035.7855.91.camel@lade.trondhjem.org>
	 <Pine.LNX.4.64.0601171338040.25508@p34>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 13:53:11 -0500
Message-Id: <1137523991.7855.103.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.076, required 12,
	autolearn=disabled, AWL 0.88, FORGED_RCVD_HELO 0.05,
	PLING_QUERY 0.86, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 13:38 -0500, Justin Piszcz wrote:
> Writing from SRC(A) -> DST(B).
> I have not tested reading, but as I recall there were similar speed issues 
> going the other way too, although I have not tested it recently.

How were you testing it? I'm not sure that ftp will actually sync your
file to disk (whereas that is pretty much mandatory for an NFS server),
so unless you are transferring very large files, you would expect to see
a speed difference due to caching of writes by the server.

Cheers,
  Trond

