Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbTAIBn0>; Wed, 8 Jan 2003 20:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbTAIBn0>; Wed, 8 Jan 2003 20:43:26 -0500
Received: from ftp.tpi.com ([198.107.51.136]:30225 "EHLO mailgate.tpi.com")
	by vger.kernel.org with ESMTP id <S261295AbTAIBnZ> convert rfc822-to-8bit;
	Wed, 8 Jan 2003 20:43:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tim Gardner <timg@tpi.com> (by way of Tim Gardner <timg@tpi.com>)
Reply-To: timg@tpi.com
Organization: TriplePoint, Inc
Subject: 2.4.19 ICMP redirects erroneously ignored
Date: Wed, 8 Jan 2003 18:52:05 -0700
User-Agent: KMail/1.4.3
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301081852.05547.rtg@tim.rtg.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting pounded by ICMP redirects from my Nortel router. The
setup is a SuSE 8.1 (2.4.19) standard client with fixed IP and netmask.
The client is configured with a default route. However, there are
several routers on the subnet that the default router knows about.
Hence, the reason that the Nortel router emits ICMP redirects
which my client steadfastly ignores.

I've RTFM, read the kernel source, and checked the relevant settings 
(/proc/sys/net/ipv4/conf/all/*). I find in /proc/net/rt_cache that there are 
2 entries, one of which is marked RTCF_REDIRECTED.

Why isn't this redirected route being used? 

This seems like a problem that ought to be common to anyone that
has multiple routers on the same subnet. What am I missing?

rtg
