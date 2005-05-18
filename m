Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbVERTxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVERTxD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 15:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVERTxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 15:53:02 -0400
Received: from unthought.net ([212.97.129.88]:54192 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262314AbVERTww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 15:52:52 -0400
Date: Wed, 18 May 2005 21:52:51 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Chris Wedgwood <cw@f00f.org>
Cc: Gregory Brauer <greg@wildbrain.com>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
Message-ID: <20050518195251.GY422@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Chris Wedgwood <cw@f00f.org>, Gregory Brauer <greg@wildbrain.com>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <428511F8.6020303@wildbrain.com> <20050514184711.GA27565@taniwha.stupidest.org> <428B7D7F.9000107@wildbrain.com> <20050518175925.GA22738@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050518175925.GA22738@taniwha.stupidest.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 10:59:25AM -0700, Chris Wedgwood wrote:
> On Wed, May 18, 2005 at 10:38:07AM -0700, Gregory Brauer wrote:
> 
> > May 18 02:59:47 violet kernel: xfs_iget_core: ambiguous vns: vp/0xf53f8ac8, invp/0xe49ccc4c
> 
> I'm pretty sure it's NFS that aggravates this --- can anyone recall
> why?

Not why no - but there where *major* problems with SMP+NFS+XFS up until
2.6.11.

I run 2.6.11(.8/9) on both SMP (dual athlon) and NUMA (64 bit kernel on
dual opteron) with NFS and XFS and haven't yet seen any problems (knock
the wood).

Seriously, any 2.6 earlier than .11 is *unusable* for file serving over
NFS (at least with XFS which at the moment is the only FS with
journalled quota so at least for me that's the only option).

-- 

 / jakob

