Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbUAISBJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 13:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbUAISBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 13:01:09 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:55974 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S262164AbUAISBG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 13:01:06 -0500
Date: Fri, 9 Jan 2004 10:00:54 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Sam Vilain <sam@hydro.gen.nz>
Subject: Re: 2.6.0 NFS-server low to 0 performance
Message-ID: <20040109180054.GV1882@matchmail.com>
Mail-Followup-To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-kernel@vger.kernel.org, Sam Vilain <sam@hydro.gen.nz>
References: <Pine.LNX.4.44.0401071947270.2922-100000@poirot.grange> <Pine.LNX.4.44.0401091031010.18195-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401091031010.18195-100000@poirot.grange>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 11:08:29AM +0100, Guennadi Liakhovetski wrote:
> On Wed, 7 Jan 2004, Mike Fedyk wrote:
> 
> > Just post a few samples of the lines that differ.  Any files should be sent
> > off-list.
> 
> Ok, This is the problem:
> 
> 10:38:30.867306 0:40:f4:23:ac:91 0:50:bf:a4:59:71 ip 590: tuxscreen.grange > poirot.grange: icmp: ip reassembly time exceeded [tos 0xc0]
> 
> A similar effect was reported in 1999 with kernel 2.3.13, also between 2
> 100mbps cards. It also was occurring with UDP NFS:
> 
> http://www.ussg.iu.edu/hypermail/linux/net/9908.2/0039.html
> 
> But there were no answers, so, I am CC-ing Sam, hoping to hear, if he's
> found the reason and a cure for his problem. Apart from this message I
> didn't find any other relevant hits with Google.
> 
> Is it some physical network problem, which somehow only becomes visible
> under 2.6 now, with UDP (NFS) with 100mbps?

Find out how many packets are being dropped on your two hosts with 2.4 and
2.6.

If they're not dropping packets, maybe the ordering with a large backlog has
chagned between 2.4 and 2.6 that would keep some of the fragments from being
sent in time...
