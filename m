Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbULHASV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbULHASV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 19:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbULHASV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 19:18:21 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:5341 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261891AbULHASS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 19:18:18 -0500
Date: Wed, 8 Dec 2004 11:15:18 +1100
From: Nathan Scott <nathans@sgi.com>
To: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>
Cc: Stefan Schmidt <zaphodb@zaphods.net>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041208001518.GB1611@frodo>
References: <20041116170527.GA3525@mail.muni.cz> <20041121014350.GJ4999@zaphods.net> <20041121024226.GK4999@zaphods.net> <20041202195422.GA20771@mail.muni.cz> <20041202122546.59ff814f.akpm@osdl.org> <20041202210348.GD20771@mail.muni.cz> <20041202223146.GA31508@zaphods.net> <20041202145610.49e27b49.akpm@osdl.org> <20041203061835.GF1228@frodo> <20041207111736.GA10872@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207111736.GA10872@mail.muni.cz>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2004 at 12:17:36PM +0100, Lukas Hejtmanek wrote:
> On Fri, Dec 03, 2004 at 05:18:35PM +1100, Nathan Scott wrote:
> > Does this patch improve things for your workload, Stefan?
> 
> This change leads to:
> 
> Filesystem "sda1": XFS internal error xfs_da_do_buf(1) at line 2176 of file fs/x
> fs/xfs_da_btree.c.  Caller 0xc0200641
>  [<c02003da>] xfs_da_do_buf+0x72a/0x8df

Hmmm, thats not healthy -- the patch might be making some other
lurking problem more likely to hit; what workload are you using
to hit this?  (is it reproducible?)  I haven't come across this
in the testing I've done so far, so I'm keen to try your case.

thanks.

-- 
Nathan
