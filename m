Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262338AbSITMK0>; Fri, 20 Sep 2002 08:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262372AbSITMK0>; Fri, 20 Sep 2002 08:10:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39951 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262338AbSITMKZ>; Fri, 20 Sep 2002 08:10:25 -0400
Date: Fri, 20 Sep 2002 13:15:25 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Oleg Drokin <green@namesys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] generic-pidhash-2.5.36-D4, BK-curr
Message-ID: <20020920131525.A26646@flint.arm.linux.org.uk>
References: <20020920122716.A2297@namesys.com> <Pine.LNX.4.44.0209201139290.1261-100000@localhost.localdomain> <20020920154347.A12399@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020920154347.A12399@namesys.com>; from green@namesys.com on Fri, Sep 20, 2002 at 03:43:47PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 03:43:47PM +0400, Oleg Drokin wrote:
> On Fri, Sep 20, 2002 at 11:40:16AM +0200, Ingo Molnar wrote:
> > we need a cmpxchg() function in the generic library, using a spinlock.  
> 
> But this is not safe for arches that provides SMP but does not provide
> cmpxchg in hadware, right?
> I mean it is only safe to use such spinlock-based function if
> all other places read and write this value via special functions that are
> also taking this spinlock.

Correct.

> Do you think we can count on this?

I don't think so.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

