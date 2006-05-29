Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWE2K6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWE2K6f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 06:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWE2K6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 06:58:35 -0400
Received: from mail.gmx.de ([213.165.64.20]:60549 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750843AbWE2K6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 06:58:34 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.17-rc4-mm3 cfq oops->panic w. fs damage
From: Mike Galbraith <efault@gmx.de>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
In-Reply-To: <1148804675.7755.2.camel@homer>
References: <1148793123.7572.22.camel@homer>
	 <20060528052514.GQ27946@ftp.linux.org.uk> <1148796018.11873.11.camel@homer>
	 <1148802491.8083.7.camel@homer>  <1148803384.8757.7.camel@homer>
	 <1148804675.7755.2.camel@homer>
Content-Type: text/plain
Date: Mon, 29 May 2006 13:00:40 +0200
Message-Id: <1148900440.9817.46.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-28 at 10:24 +0200, Mike Galbraith wrote: 
> On Sun, 2006-05-28 at 10:03 +0200, Mike Galbraith wrote:
> 
> > Yup, mm3 makes reliable kaboom.
> > 
> > I suppose the first thing to do is see if it's cfq, and then maybe toss
> > a dart at the patch list.
> 
> That was too easy.  It's git-cfq.patch.

Too easy indeed.

After staring at these changes, and not having anything poke me in the
eye that looked like it might cause list corruption, I decided to try
them in a different kernel.  I put them into 2.6.16-rt25, and there they
work peachy.  A diff of 2.6.16-rt25+git-cfq.patch->2.6.17-rc4-mm3 shows
what I was expecting (locking changes), but it's embedded in ~1000 lines
of diff, and doesn't look particularly trivial.

Hi Jens <punt> :)

	-Mike

