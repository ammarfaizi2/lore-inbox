Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVCLDrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVCLDrc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 22:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVCLDrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 22:47:32 -0500
Received: from fire.osdl.org ([65.172.181.4]:4514 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261836AbVCLDra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 22:47:30 -0500
Date: Fri, 11 Mar 2005 19:43:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Prefaulting
Message-Id: <20050311194349.1e546d8c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503111913560.24817@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503110444220.19419@schroedinger.engr.sgi.com>
	<20050311172228.773cf03d.akpm@osdl.org>
	<Pine.LNX.4.58.0503111913560.24817@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> There is even a slight performance win in the
>  uniprocessor case:
> 
>  w/o any patch:
> 
>   Mb Rep Thr CLine  User      System   Wall  flt/cpu/s fault/wsec
>  200  3    1   1    0.01s      0.15s   0.01s846860.493 848882.424
>  200  3    1   1    0.01s      0.16s   0.01s827724.160 830841.482
>  200  3    1   1    0.00s      0.16s   0.01s827724.160 827364.176
> 
>  w/prefault patch
> 
>  200 MB allocation
> 
>   Mb Rep Thr CLine  User      System   Wall  flt/cpu/s fault/wsec
>  200  3    1   1    0.02s      0.48s   0.05s860119.275 859918.989
>  200  3    1   1    0.02s      0.46s   0.04s886129.730 886551.621
>  200  3    1   1    0.01s      0.47s   0.04s887920.166 886855.775

But the system time went through the roof.  Would that be accounting
inaccuracy?

