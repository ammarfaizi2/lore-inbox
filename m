Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269107AbUIRDls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269107AbUIRDls (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 23:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269109AbUIRDls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 23:41:48 -0400
Received: from lakermmtao09.cox.net ([68.230.240.30]:45779 "EHLO
	lakermmtao09.cox.net") by vger.kernel.org with ESMTP
	id S269107AbUIRDlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 23:41:46 -0400
In-Reply-To: <200409171529.52864.ryan@spitfire.gotdns.org>
References: <20040917154834.GA3180@crusoe.alcove-fr> <200409171454.02531.ryan@spitfire.gotdns.org> <20040917220039.GD15426@dualathlon.random> <200409171529.52864.ryan@spitfire.gotdns.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A9B5AE4E-0924-11D9-B8B0-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Stelian Pop <stelian@popies.net>, James R Bruce <bruce@andrew.cmu.edu>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Andrea Arcangeli <andrea@novell.com>, Andrew Morton <akpm@osdl.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Date: Fri, 17 Sep 2004 23:41:45 -0400
To: Ryan Cumming <ryan@spitfire.gotdns.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 17, 2004, at 18:29, Ryan Cumming wrote:
> Er, sorry, the last patch was had an off-by-one error (it would round 
> 4 up to
> 8).
>
> +static inline unsigned long __attribute_pure__ roundup_pow_of_two(int 
> x)

This should probably be __const__, which is a stricter class of 
__pure__.
The "__pure__" attribute means it has no side effects, whereas the
"__const__" attribute means that it also _only_ depends on its 
arguments,
not on any global memory or the data at any pointers passed to it.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


