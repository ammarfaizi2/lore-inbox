Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268734AbUJECdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268734AbUJECdy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 22:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268739AbUJECdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 22:33:54 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:28873 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268734AbUJECdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 22:33:52 -0400
From: Jesse Barnes <jbarnes@sgi.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: [PATCH] I/O space write barrier
Date: Mon, 4 Oct 2004 19:33:25 -0700
User-Agent: KMail/1.7
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       benh@kernel.crashing.org
References: <1096922369.2666.177.camel@cube> <200410041420.01266.jbarnes@engr.sgi.com> <1096936344.2674.198.camel@cube>
In-Reply-To: <1096936344.2674.198.camel@cube>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410041933.25522.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 04, 2004 5:32 pm, Albert Cahalan wrote:
> Ideally, it would be eieio, and the eieio in each
> of the IO operations would be removed. Finding and
> fixing all the drivers that break looks impossible
> though; most driver developers will be on x86 boxes.

Well, I won't pretend to understand how the PPC ordering rules work, so I'll 
defer to benh on that one.

> In that case: wmmiob
>
> (or something longer, like mmio_write_fence maybe)
>
> As a name, "wmb" sucks almost as much as "cli" and "sti" do.
> It dates back to the Alpha port, where it's an opcode.

The other option I briefly considered was wwjd(), but I don't think He has an 
official position on posted write ordering.

Jesse
