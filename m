Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUDLFYd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 01:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbUDLFYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 01:24:33 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:33677 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262585AbUDLFYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 01:24:32 -0400
Date: Sun, 11 Apr 2004 22:24:21 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
Message-ID: <12040000.1081747461@[10.10.2.4]>
In-Reply-To: <Pine.GSO.4.58.0404120028200.11877@azure.engin.umich.edu>
References: <Pine.LNX.4.44.0404111650410.2008-100000@localhost.localdomain><7220000.1081704484@[10.10.2.4]> <Pine.GSO.4.58.0404120028200.11877@azure.engin.umich.edu>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch is an attempt at reducing the contention on i_shared_sem
> by introducing a new semaphore i_mmap_sem. The i_shared_sem covers
> i_mmap_shared tree and i_mmap_nonlinear list now, whereas i_mmap_sem
> covers i_mmap tree. This may help to reduce the contention on
> i_shared_sem if a file is mapped both private and shared. Kernel
> compile time with and without this patch did not change much, though.
> 
> This patch is on top of 2.6.5-mjb1+anobjrmap9_prio. Compiled and
> tested.
> 
> Martin! Are you interested in testing SDET with this patch ?

Runs exactly the same as prio ... thanks for having a crack at it though.
I guess that sharing combination isn't that common ;-(

M.

