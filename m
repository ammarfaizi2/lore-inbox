Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267436AbTAQIsa>; Fri, 17 Jan 2003 03:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267435AbTAQIsa>; Fri, 17 Jan 2003 03:48:30 -0500
Received: from dp.samba.org ([66.70.73.150]:41604 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267434AbTAQIs3>;
	Fri, 17 Jan 2003 03:48:29 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       davem@vger.kernel.org
Subject: Re: [module-init-tools] fix weak symbol handling 
In-reply-to: Your message of "Fri, 17 Jan 2003 07:34:14 -0000."
             <30299.1042788854@passion.cambridge.redhat.com> 
Date: Fri, 17 Jan 2003 19:56:58 +1100
Message-Id: <20030117085728.1C0FF2C186@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <30299.1042788854@passion.cambridge.redhat.com> you write:
> 
> rth@twiddle.net said:
> > Well, that depends on whether A defines S or not.  If A does define S,
> > then I don't care.  I'd say "no", A does not depend on B.  If A does
> > not define S, then most definitely "yes", as with any other
> > definition.
> 
> As long as doing so doesn't make modprobe fail to load A when B isn't 
> present or refuses to load. Otherwise what was the point in making it weak?

If A depends on B, then modprobe will give a warning if "modprobe A"
fails to load B for some reason.  If B doesn't exist, then modprobe
wouldn't know anything about it (presumably).

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
