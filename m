Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbULOLnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbULOLnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 06:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbULOLnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 06:43:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:17810 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262333AbULOLnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 06:43:00 -0500
Date: Wed, 15 Dec 2004 03:42:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3-mm1
Message-Id: <20041215034239.2d2f9d9d.akpm@osdl.org>
In-Reply-To: <20041215113515.GJ771@holomorphy.com>
References: <20041213020319.661b1ad9.akpm@osdl.org>
	<20041215113515.GJ771@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Mon, Dec 13, 2004 at 02:03:19AM -0800, Andrew Morton wrote:
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc3/2.6.10-rc3-mm1/
>  > - Lots of new patches, lots of little fixes all over the place.
>  > - Probably the major change is the readahead rework, which may have
>  >   significant performance impacts on some workloads.  Not necessarily good,
>  >   either...
>  > - See below for the list of 31 patches which I have pending for 2.6.10.  If
>  >   there are other patches here which should go in, please let me know.
> 
>  This appears to have trouble on em64t; not only does the following happen,
>  but some odd userspace programs (e.g. ssh) appear to be failing.
> 
>  Shutting down powersaved                                                       cut here ] --------- [please bite here ] ---------
>  KDdoneernel BUG at pageattr:156

I can't say I'm surprised, really, although it booted and did stuff OK on my
box.

There's a mangled-up mess of ioremap/pageattr patches from Andrea and Andi
in there.  I'll drop a few things.  We need to go through those changes a
little more carefully.

