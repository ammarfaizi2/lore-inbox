Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271153AbTHCLbU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 07:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271158AbTHCLbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 07:31:20 -0400
Received: from mx1.elte.hu ([157.181.1.137]:55444 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S271153AbTHCLbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 07:31:16 -0400
Date: Sun, 3 Aug 2003 13:25:53 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O12.2int for interactivity
In-Reply-To: <200308032014.00986.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.44.0308031307070.5475-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 3 Aug 2003, Con Kolivas wrote:

> Reverted Ingo's EXPIRED_STARVING definition; it was making interactive
> tasks expire faster as cpu load increased.

hm, that bit was needed for fairness, otherwise 'interactive' tasks can
monopolize the CPU. [ Have you tried lots of copies of thud.c (and
Davide's irman2 with the most evil settings), do they still produce no
starvation with this bit restored to the original logic? ]

	Ingo

