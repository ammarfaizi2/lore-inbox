Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267353AbUG1XIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267353AbUG1XIi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266397AbUG1WwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:52:16 -0400
Received: from faui10.informatik.uni-erlangen.de ([131.188.31.10]:45457 "EHLO
	faui10.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S267168AbUG1Wg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:36:57 -0400
From: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>
Message-Id: <200407282236.AAA00859@faui1m.informatik.uni-erlangen.de>
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS
To: nickpiggin@yahoo.com.au (Nick Piggin)
Date: Thu, 29 Jul 2004 00:36:56 +0200 (CEST)
Cc: avi@exanet.com (Avi Kivity),
       weigand@i1.informatik.uni-erlangen.de (Ulrich Weigand),
       linux-kernel@vger.kernel.org
In-Reply-To: <41073A6C.1050606@yahoo.com.au> from "Nick Piggin" at Jul 28, 2004 03:32:28 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Avi Kivity wrote:
> > The kernel NFS client (which kswapd depends on) has the same issue. Has 
> > anyone ever observed kswapd deadlock due to imcoming or outgoing NFS 
> > packets being discarded due to oom?
> > 
> 
> Yes this has been observed.
> 
> alloc_skb on the client needs to somehow know that traffic coming
> from the server is "MEMALLOC" and allowed to use memory reserves.

What would be an appropriate way to solve this problem? A special
socket option?

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
