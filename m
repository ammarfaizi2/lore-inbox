Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbVHYE7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVHYE7A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 00:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbVHYE7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 00:59:00 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:53397 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S964800AbVHYE67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 00:58:59 -0400
Date: Thu, 25 Aug 2005 13:54:20 +0900 (JST)
Message-Id: <20050825.135420.640917643.hyoshiok@miraclelinux.com>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org, hyoshiok@miraclelinux.com
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <p73ll2rfgv7.fsf@verdi.suse.de>
References: <20050823.081246.846946371.hyoshiok@miraclelinux.com.suse.lists.linux.kernel>
	<20050824.231156.278740508.hyoshiok@miraclelinux.com.suse.lists.linux.kernel>
	<p73ll2rfgv7.fsf@verdi.suse.de>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
> > Hi,
> > 
> > The following patch does not use MMX regsiters so that we don't have
> > to worry about save/restore the FPU/MMX states.
> > 
> > What do you think?
> 
> Performance will probably be bad on K7 Athlons - those have a microcoded
> movnti which is quite slow.
> 
> Also BTW I don't see any code anywhere that tests the CPUID bits,
> so your code will fail spectacularly on a PII that didn't do SSE
> (intel user copy used to be enabled on those) 
> 
> One way to solve this might be to use different code using
> alternative()
> 
> -Andi

Thanks for your comments. I'll consider it.

Regards,
  Hiro
