Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265787AbUEZUgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265787AbUEZUgA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 16:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265791AbUEZUgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 16:36:00 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:41130 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265787AbUEZUf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 16:35:57 -0400
Date: Wed, 26 May 2004 13:34:38 -0700
From: Paul Jackson <pj@sgi.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akiyama.nobuyuk@jp.fujitsu.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI trigger switch support for debugging
Message-Id: <20040526133438.196ca930.pj@sgi.com>
In-Reply-To: <16564.26285.431229.665902@alkaid.it.uu.se>
References: <40B1BEAC.30500@jp.fujitsu.com>
	<20040524023453.7cf5ebc2.akpm@osdl.org>
	<40B3F484.4030405@jp.fujitsu.com>
	<20040525184148.613b3d6e.akpm@osdl.org>
	<40B400D1.1080602@jp.fujitsu.com>
	<16564.26285.431229.665902@alkaid.it.uu.se>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson, replying to AKIYAMA Nobuyuki:
>  > +	if (!old_state == !unknown_nmi_panic)
>  > +		return 0;
> 
> This conditional looks terribly obscure.

Would the following variant seem clearer:

	if (!!unknown_nmi_panic == !!old_state)
		return 0;

Odd, I know.  For those of us familiar with the '!!' idiom, which
converts any value to its binary logical equivalent 0 (if zero) or
1 (otherwise), this reads as:

	if (the logical value of unknown_nmi_panic is unchanged)
		return 0;

However, I could easily imagine others finding this variant even
more bizarre.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
