Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266246AbSL1RyL>; Sat, 28 Dec 2002 12:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266250AbSL1RyL>; Sat, 28 Dec 2002 12:54:11 -0500
Received: from ns.netrox.net ([64.118.231.130]:46287 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S266246AbSL1RyK>;
	Sat, 28 Dec 2002 12:54:10 -0500
Subject: Re: [PATCH] deprecated function attribute
From: Robert Love <rml@tech9.net>
To: Alexander Kellett <lypanov@kde.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, william stinson <wstinson@wanadoo.fr>,
       trivial@rustcorp.com.au
In-Reply-To: <1041097877.1066.9.camel@icbm>
References: <20021228035319.903502C04B@lists.samba.org>
	 <20021228153009.GA29614@groucho.verza.com>  <1041097877.1066.9.camel@icbm>
Content-Type: text/plain
Organization: 
Message-Id: <1041098631.1066.13.camel@icbm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 28 Dec 2002 13:03:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-28 at 12:51, Robert Love wrote:

> +#if __GNUC__ == 3
> +#define deprecated	__attribute__((deprecated))
> +#else
> +#define deprecated
> +#endif

Before someone points it out: I grepped the tree and did not see any
uses of "deprecated" as a token on first glance.  So the above is safe.

If we want to be preemptive, we can rename the above to "__deprecated__"
but I think plain "deprecated" is much better looking.

	Robert Love

