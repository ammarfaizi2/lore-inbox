Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbSKNBa0>; Wed, 13 Nov 2002 20:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbSKNBa0>; Wed, 13 Nov 2002 20:30:26 -0500
Received: from dp.samba.org ([66.70.73.150]:61573 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261322AbSKNBaZ>;
	Wed, 13 Nov 2002 20:30:25 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Remove BUG in cpu_up 
In-reply-to: Your message of "Wed, 13 Nov 2002 08:17:54 CDT."
             <Pine.LNX.4.44.0211130804380.24523-100000@montezuma.mastecende.com> 
Date: Thu, 14 Nov 2002 12:56:53 +1100
Message-Id: <20021114013718.0FA082C243@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0211130804380.24523-100000@montezuma.mastecende.com> 
you write:
> On Wed, 13 Nov 2002, Rusty Russell wrote:
> 
> > Err, no.  If __cpu_up(cpu) succeeded, that means the cpu should bloody
> > well be online!
> 
> smp startup looks rather convoluted to me right now, but if i see it 
> correctly, __cpu_up should eventually be doing a wakeup_secondary_via_INIT 
> on vanilla i386 correct? In that case, the processor accepting the IPI 
> doesn't necessarily mean it will have managed to initialise (if at all) itsel
f by 

It is bloody convoluted.  Hmm, the arch needs to wait before returning
"success" on __cpu_up.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
