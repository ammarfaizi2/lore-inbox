Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWAQBHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWAQBHM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 20:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWAQBHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 20:07:11 -0500
Received: from lucidpixels.com ([66.45.37.187]:33211 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751319AbWAQBHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 20:07:09 -0500
Date: Mon, 16 Jan 2006 20:07:02 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
cc: apiszcz@lucidpixels.com
Subject: Kernel 2.6.15.1 + NFS is 4 times slower than FTP!?
Message-ID: <Pine.LNX.4.64.0601161957300.16829@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that I have 74GB raptors in both of my Linux boxes, I thought I would 
compare throughput between FTP and NFS over a gigabit network.

I am using the same kernel versions and same motherboard on both machines 
and even the same raptor hdd model.

Here are my results:

NFS, COPY 700MB FILE FROM 1 RAPTOR TO ANOTHER RAPTOR VIA GIGABIT ETHERNET:

$ cp file /remote/dst
0.02user 1.86system 0:38.07elapsed 4%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+196minor)pagefaults 0swaps

FTP, SAME

lftp> put file
733045488 bytes transferred in 10 seconds (67.38M/s)

What is wrong with NFS?

NFS options used: rw,bg,hard,intr,nfsvers=3
Is it doing some kind of weird caching?
I am using NFSv3 & XFS as the filesystem, any ideas?

I suppose I should try NFS with TCP, yes?

Thanks!

Justin.
