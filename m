Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266770AbUG1CcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266770AbUG1CcI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 22:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266771AbUG1CcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 22:32:08 -0400
Received: from faui10.informatik.uni-erlangen.de ([131.188.31.10]:37613 "EHLO
	faui10.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S266770AbUG1CcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 22:32:05 -0400
From: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>
Message-Id: <200407280232.EAA14567@faui1m.informatik.uni-erlangen.de>
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS
To: avi@exanet.com
Date: Wed, 28 Jul 2004 04:32:03 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:

>In our case, all block I/O is done using 
>unbuffered I/O, and all memory is preallocated, so we don't need kswapd 
>at all, just that small bit of memory that syscalls consume.

Does your userspace process need to send/receive network packets
in order to perform a write-out?  If so, how can you make sure your
incoming packets aren't thrown away in out-of-memory situations?
(Outgoing packets can use PF_MEMALLOC memory I guess, but incoming
ones aren't associated to any process yet ...)

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
