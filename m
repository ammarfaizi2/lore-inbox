Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262704AbTCJDlD>; Sun, 9 Mar 2003 22:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262705AbTCJDlD>; Sun, 9 Mar 2003 22:41:03 -0500
Received: from smtp1.euronet.nl ([194.134.35.133]:14012 "EHLO smtp1.euronet.nl")
	by vger.kernel.org with ESMTP id <S262704AbTCJDlC>;
	Sun, 9 Mar 2003 22:41:02 -0500
Message-ID: <3E6C0B93.5040205@koffie.nl>
Date: Mon, 10 Mar 2003 04:50:43 +0100
From: Segher Boessenkool <segher@koffie.nl>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       oprofile-list@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org,
       o.oppitz@web.de, afleming@motorola.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] oprofile for ppc
References: <200303070929.h279TGTu031828@saturn.cs.uml.edu>	 <1047032003.12206.5.camel@zion.wanadoo.fr>  <1047061862.1900.67.camel@cube> <1047136206.12202.85.camel@zion.wanadoo.fr>
In-Reply-To: <1047136206.12202.85.camel@zion.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> Beware though that some G4s have a nasty bug that prevents
> using the performance counter interrupt (and the thermal interrupt
> as well).

MPC7400 version 1.2 and lower have this problem.

 > The problem is that if any of those fall at the same
> time as the DEC interrupt, the CPU messes up it's internal
> state and you lose SRR0/SRR1, which means you can't recover
> from the exception.

But the worst that happens is that you lose that process, isn't
it?  Not all that big a problem, esp. since the window in which
this can happen is very small.


Segher

