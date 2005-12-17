Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbVLQPQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbVLQPQf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 10:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbVLQPQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 10:16:35 -0500
Received: from khc.piap.pl ([195.187.100.11]:1028 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932593AbVLQPQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 10:16:35 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: agpgart.ko can't be unloaded
References: <m3acf2i05d.fsf@defiant.localdomain>
	<m31x0ehz8m.fsf@defiant.localdomain>
	<1134783072.7402.2.camel@localhost.localdomain>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 17 Dec 2005 16:16:27 +0100
In-Reply-To: <1134783072.7402.2.camel@localhost.localdomain> (Rusty
 Russell's message of "Sat, 17 Dec 2005 12:31:12 +1100")
Message-ID: <m3d5jvda9g.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> writes:

> That can happen; "rmmod -w" will block until it's no longer used.  Still
> used, still waiting.
>
> Looks from these refcounts that intel_agp is being used.  Who is holding
> the refcount?

That's another story - they have deadlocked wrt refcounts, that's why
rmmod is waiting so hard.

I'd expect the rmmod to be interruptible, though. Thanks for info.
-- 
Krzysztof Halasa
