Return-Path: <linux-kernel-owner+w=401wt.eu-S1761798AbWLKCHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761798AbWLKCHY (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 21:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762263AbWLKCHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 21:07:24 -0500
Received: from main.gmane.org ([80.91.229.2]:52111 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761798AbWLKCHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 21:07:23 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kevin Puetz <puetzk@puetzk.org>
Subject: Re: [2.6.19-rc1][AGP] Regression -  =?utf-8?b?YW1kX2s3X2FncA==?=  no longer detected
Date: Mon, 11 Dec 2006 02:06:19 +0000 (UTC)
Message-ID: <loom.20061211T025904-121@post.gmane.org>
References: <200610060150.20415.shawn.starr@rogers.com> <20061006060803.GB3381@redhat.com> <200610060259.52742.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.208.253.240 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; rv:1.8.0.7) Gecko/20060911 Camino/1.0.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr <shawn.starr <at> rogers.com> writes:

> 
> On Friday 06 October 2006 2:08 am, Dave Jones wrote:
> > On Fri, Oct 06, 2006 at 01:50:19AM -0400, Shawn Starr wrote:
> >  > When loading amd_k7_agp nothing appears from kernel, no information
> >  > about the AGP chipset/aptreture size etc. Even putting kprints inside
> >  > the probe() function of the driver does not get called.
> >
> > Even as the first thing in agp_amdk7_probe() ?
> ... (http://thread.gmane.org/gmane.linux.kernel/453869)

I'm hitting this problem too, and as it's still present in the 2.6.19 final, I'm
assuming you never got enough information to chase it. I found the following
note in the debian BTS that seems relevant:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=363682

I can confirm that if I remove the amd76x_edac module and reload amd_k7_agp, it
detects the aperture. If I then reload radeon.ko and X, I get DRI (and AIGLX).
So hopefully that's a lead to what might have changed...

