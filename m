Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWCaMXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWCaMXK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 07:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWCaMXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 07:23:10 -0500
Received: from pat.uio.no ([129.240.10.6]:57328 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751352AbWCaMXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 07:23:09 -0500
Subject: Re: NFS client (10x) performance regression 2.6.14.7 -> 2.6.15
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060331094850.GF9811@unthought.net>
References: <20060331094850.GF9811@unthought.net>
Content-Type: text/plain
Date: Fri, 31 Mar 2006 07:22:50 -0500
Message-Id: <1143807770.8096.4.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.696, required 12,
	autolearn=disabled, AWL 1.12, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-31 at 11:48 +0200, Jakob Oestergaard wrote:
> Hi guys,
> 
> I just found out... Installed 2.6.16.1 (32-bit) on a spanking new dual
> opteron 275 (dual-core) machine, and saw that my link jobs were taking
> ages.
> 
> I narrowed it down a bit - these are the kernels I have tested:
> 2.6.13.5:  Good
> 2.6.14.7:  Good
> 2.6.15:    Poor
> 2.6.15.7:  Poor
> 2.6.16.1:  Poor
> 
> Sequential NFS I/O is good on all kernels. Only "ld" shows the problem.
> 
> On 2.6.14.7, I can run a large link job creating a 60 MB executable in
> 15.6 seconds wall-clock time.
> 
> On 2.6.15, the same link job takes 2 minutes 28 seconds.
> 
> This is almost 10 *times* longer.
> 
> Testing with tiobench, I can see no notable difference between the
> kernels (!)   It seems that this is very specific to ld.  I am using GNU
> ld version 2.15.
> 
> The NFS client mounts the working directory using NFS v3 over UDP with
> default (32k) rsize/wsize.
> 
> Since this machine is not in production yet, I can experiment with
> kernel patches on it - I would like to try and narrow this down even
> further - any suggestions as to which patches to exclude/include will be
> greatly appreciated.

Some nfsstat output comparing the good and bad cases would help.

Cheers,
  Trond

