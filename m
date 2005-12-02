Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbVLBSDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbVLBSDk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 13:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbVLBSDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 13:03:40 -0500
Received: from solarneutrino.net ([66.199.224.43]:14853 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1750877AbVLBSDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 13:03:39 -0500
Date: Fri, 2 Dec 2005 13:03:26 -0500
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>, Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       ryan@tau.solarneutrino.net
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20051202180326.GB7634@tau.solarneutrino.net>
References: <20051129092432.0f5742f0.akpm@osdl.org> <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local> <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org> <20051201195657.GB7236@tau.solarneutrino.net> <Pine.LNX.4.61.0512012008420.28450@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512012008420.28450@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 08:21:57PM +0000, Hugh Dickins wrote:
> If the problem were easily reproducible, it'd be great if you could
> try this patch; but I think you've said it's not :-(
> 
> Hugh
> 
> --- 2.6.14/drivers/scsi/st.c	2005-10-28 01:02:08.000000000 +0100
> +++ linux/drivers/scsi/st.c	2005-12-01 20:06:02.000000000 +0000
> @@ -4511,6 +4511,7 @@ static int sgl_map_user_pages(struct sca
>  	if (res > 0) {
>  		for (j=0; j < res; j++)
>  			page_cache_release(pages[j]);
> +		res = 0;
>  	}
>  	kfree(pages);
>  	return res;

I can throw this in and test it for sure.  I'll run the backups every
day for a while to speed up the testing also.

Could someone please tell me exactly which patches I should include in
the kernel I will boot tomorrow?  I haven't played with -rc for ages, so
I'm no longer sure which kernel I should start with (2.6.14 or
2.6.14.3?).  Are the MPT-fusion performance fix patches in -rc4, or if
not will they still apply?

Thanks,
-ryan
