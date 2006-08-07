Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWHGGUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWHGGUU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 02:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWHGGUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 02:20:20 -0400
Received: from mx1.suse.de ([195.135.220.2]:32174 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751098AbWHGGUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 02:20:18 -0400
From: Andi Kleen <ak@muc.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 3/4] x86 paravirt_ops: implementation of paravirt_ops
Date: Mon, 7 Aug 2006 08:20:09 +0200
User-Agent: KMail/1.9.3
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
References: <1154925835.21647.29.camel@localhost.localdomain> <200608070739.33428.ak@muc.de> <1154931222.7642.21.camel@localhost.localdomain>
In-Reply-To: <1154931222.7642.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608070820.09059.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I think I would prefer to patch always. Is there a particular
> > reason you can't do that?
> 
> We could patch all the indirect calls into direct calls, but I don't
> think it's worth bothering: most simply don't matter.

I still think it would be better to patch always.

> Each backend wants a different patch, so alternative() doesn't cut it.
> We could look at generalizing alternative() I guess, but it works fine
> so I didn't want to touch it.

You could at least use a common function (with the replacement passed
in as argument) for lock prefixes and your stuff

-Andi
