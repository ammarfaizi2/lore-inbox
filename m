Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTFQGpf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 02:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbTFQGpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 02:45:35 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:19979 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261265AbTFQGpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 02:45:34 -0400
Subject: Re: [BUG] 2.4.21: NFS copy produces I/O errors
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Ole Marggraf <marggraf@astro.uni-bonn.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0306170001320.3565@aibn99.astro.uni-bonn.de>
References: <Pine.LNX.4.55.0306162047140.6775@aibn99.astro.uni-bonn.de>
	 <1055800323.586.0.camel@teapot.felipe-alfaro.com>
	 <Pine.LNX.4.55.0306162353560.3503@aibn99.astro.uni-bonn.de>
	 <Pine.LNX.4.55.0306170001320.3565@aibn99.astro.uni-bonn.de>
Content-Type: text/plain
Message-Id: <1055833159.587.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 17 Jun 2003 08:59:19 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-17 at 00:04, Ole Marggraf wrote:
> > > By the way, are you using the "soft" option to mount the NFS volumes
> >
> > Yes, forgot to mention... But its quite clear from the error message.
> >
> > Mount options are rw,soft,bw,rsize=8192,wsize=8192.
> 
> Ok, correction. (I should go home and get some sleep...)
> rsize=8192,wsize=8192 were not set in the original testing setup, I had
> the defaults there (1024 both). The amount of bytes written till the I/O
> error gets up does scale with that option.

Please, don't use the "soft" option. Instead, use "hard" as there are
problems with the former. I had the same problems with I/O errors. Trond
told me to stick with "hard" at the moment.

