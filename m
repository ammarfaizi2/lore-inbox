Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751870AbWCNGi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbWCNGi7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 01:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbWCNGi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 01:38:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:42656 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751870AbWCNGi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 01:38:58 -0500
X-Authenticated: #14349625
Subject: Re: [PATCH] mm: Implement swap prefetching tweaks
From: Mike Galbraith <efault@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <1142139283.25358.68.camel@mindpipe>
References: <200603102054.20077.kernel@kolivas.org>
	 <200603111650.23727.kernel@kolivas.org> <1142056851.7819.54.camel@homer>
	 <200603111824.06274.kernel@kolivas.org>  <1142063500.7605.13.camel@homer>
	 <1142139283.25358.68.camel@mindpipe>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 07:40:03 +0100
Message-Id: <1142318403.4583.14.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-11 at 23:54 -0500, Lee Revell wrote:
> On Sat, 2006-03-11 at 08:51 +0100, Mike Galbraith wrote:
> > There used to be a pages in flight 'restrictor plate' in there that
> > would have probably helped this situation at least a little.  But in
> > any case, it sounds like you'll have to find a way to submit the IO in
> > itty bitty synchronous pieces. 
> 
> echo 64 > /sys/block/hd*/queue/max_sectors_kb
> 
> There is basically a straight linear relation between whatever you set
> this to and the maximum scheduling latency you see.  It was developed to
> solve the exact problem you are describing.

<head-scratching>

Is it possible that you mean pci latency?  I'm unable to measure any
scheduling latency > 5ms while pushing IO for all my little Barracuda
disk is worth.  I _can_ generate mp3 player audio dropout though,
despite mp3 files living on a separate drive/controller.

	-Mike

