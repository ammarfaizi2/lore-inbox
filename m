Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271364AbTHDDBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 23:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271365AbTHDDBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 23:01:09 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:55692
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271364AbTHDDBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 23:01:07 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] O12.2int for interactivity
Date: Mon, 4 Aug 2003 13:06:06 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <Pine.LNX.4.44.0308031307070.5475-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0308031307070.5475-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308041306.06067.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Aug 2003 21:25, Ingo Molnar wrote:
> On Sun, 3 Aug 2003, Con Kolivas wrote:
> > Reverted Ingo's EXPIRED_STARVING definition; it was making interactive
> > tasks expire faster as cpu load increased.
>
> hm, that bit was needed for fairness, otherwise 'interactive' tasks can
> monopolize the CPU. [ Have you tried lots of copies of thud.c (and
> Davide's irman2 with the most evil settings), do they still produce no
> starvation with this bit restored to the original logic? ]

I tried them aggressively; irman2 and thud don't hurt here. The idle detection 
limits both of them from gaining too much sleep_avg while waiting around and 
they dont get better dynamic priority than 17.

Con

