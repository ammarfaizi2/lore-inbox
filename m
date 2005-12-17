Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbVLQBbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbVLQBbT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 20:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbVLQBbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 20:31:19 -0500
Received: from ozlabs.org ([203.10.76.45]:8098 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751352AbVLQBbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 20:31:19 -0500
Subject: Re: agpgart.ko can't be unloaded
From: Rusty Russell <rusty@rustcorp.com.au>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <m31x0ehz8m.fsf@defiant.localdomain>
References: <m3acf2i05d.fsf@defiant.localdomain>
	 <m31x0ehz8m.fsf@defiant.localdomain>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 12:31:12 +1100
Message-Id: <1134783072.7402.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 21:38 +0100, Krzysztof Halasa wrote:
> > I recently noticed that agpgart.ko (and corresponding hardware driver)
> > can't be unloaded:
> >
> > Module                  Size  Used by
> > intel_agp              19228  1 
> > agpgart                27592  1 intel_agp
> 
> BTW: "rmmod -w agpgart intel_agp" hangs in uninterruptible sleep state
> ("D") forever.

That can happen; "rmmod -w" will block until it's no longer used.  Still
used, still waiting.

Looks from these refcounts that intel_agp is being used.  Who is holding
the refcount?

Cheers,
Rusty.
-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol

