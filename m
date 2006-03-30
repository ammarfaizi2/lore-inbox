Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWC3OZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWC3OZu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 09:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWC3OZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 09:25:50 -0500
Received: from pat.uio.no ([129.240.10.6]:63918 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932228AbWC3OZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 09:25:49 -0500
Subject: Re: NFS/Kernel Problem: getfh failed: Operation not permitted
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.64.0603300813270.18696@p34>
References: <Pine.LNX.4.64.0603300813270.18696@p34>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 09:25:20 -0500
Message-Id: <1143728720.8074.41.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.732, required 12,
	autolearn=disabled, AWL 1.08, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-30 at 08:19 -0500, Justin Piszcz wrote:
> The error is: rpc.mountd: getfh failed: Operation not permitted
> 
> In order to fix this error, someone needs to run these commands on each 
> nfs server.
> 
>     40  service nfs stop
>     41  rm -f /var/lib/nfs/etab /var/lib/nfs/rmtab /var/lib/nfs/state 
> /var/lib/xtab
>     42  touch /var/lib/nfs/etab /var/lib/nfs/rmtab /var/lib/nfs/state 
> /var/lib/xtab
>     43  chmod 644 /var/lib/nfs/etab /var/lib/nfs/rmtab /var/lib/nfs/state 
> /var/lib/xtab
>     44  service nfs start
> 
> http://www.ccs.neu.edu/home/johan/personal/linux.html
> 
> This issue seems to be more of an NFS issue than a kernel one, but I was 
> wondering what other people had to say about it.  There are a lot of 
> responses and questions concerning this error on google, but VERY few 
> people have a response or method of fixing it, much less finding a 
> permanent fix.
> 
> Has anyone found a fix or work-around that does not require restarting 
> NFS?

Very few people ought to be running RH-9 out there given that the
official support expired several years ago.

Are you still seeing this problem with 2.6 kernels with /proc/fs/nfsd
properly mounted?

Cheers,
  Trond

