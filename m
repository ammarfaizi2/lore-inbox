Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUHVCLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUHVCLw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 22:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbUHVCLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 22:11:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:1688 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265230AbUHVCLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 22:11:41 -0400
Subject: Re: [PATCH] ppc32 use simplified mmenonics
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vincent Hanquez <tab@snarc.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040821222318.GA32229@snarc.org>
References: <20040821222318.GA32229@snarc.org>
Content-Type: text/plain
Message-Id: <1093140048.10506.277.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 22 Aug 2004 12:00:49 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-22 at 08:23, Vincent Hanquez wrote:
> 	Hi LKML and Benjamin,
> 
> This patch substitutes complex rlwinm instruction to the simplied
> instruction clrrwi when possible.
> 
> This has the same meaning as the ppc knows only about rlwinm; clrrwi
> is just a language simplification.
> 
> basicly it's a : s/rlwinm R1,R2,0,0,31-N/clrrwi R1,R2,N/

Oh well.. I've got quite used to tweaking rlwinm directly but I suppose
it's more clear for others to go to clrrwi. I see no obvious problem
though I haven't double checked the bit counts, I suppose you got the
substraction right everywhere but you know... it's always on the trivial
things that we make the nasty mistakes ;)

I'll look again when I'm back (I'm away for the week-end)

Ben.


