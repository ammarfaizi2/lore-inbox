Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315484AbSECAJo>; Thu, 2 May 2002 20:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSECAJn>; Thu, 2 May 2002 20:09:43 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:14020 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315484AbSECAJl>; Thu, 2 May 2002 20:09:41 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: O(1) scheduler gives big boost to tbench 192 
In-Reply-To: Your message of Fri, 03 May 2002 01:14:19 BST.
             <E173QiK-0005Bd-00@the-village.bc.nu> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3050.1020388134.1@us.ibm.com>
Date: Thu, 02 May 2002 18:08:54 -0700
Message-Id: <E173RZ9-0000nF-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E173QiK-0005Bd-00@the-village.bc.nu>, > : Alan Cox writes:
> 
> > Rumor is that on some workloads MQ it outperforms O(1), but it
> > may be that the latest (post K3?) O(1) is catching up?
> 
> I'd be interested to know what workloads ?
 
AIM on large CPU count machines was the most significant I had heard
about.  Haven't measured recently on database load - we made a cut to
O(1) some time back for simplicity.  Supposedly volanomark was doing
better for a while but again we haven't cut back to MQ in quite a while;
trying instead to refine O(1).  Volanomark is something of a scheduling
anomaly though - sender/receiver timing on loopback affects scheduling
decisions and overall throughput in ways that may or may not be consistent
with real workloads.  AIM is probably a better workload for "real life"
random scheduling testing.

gerrit
