Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTEQJ5V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 05:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbTEQJ5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 05:57:21 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27008 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261352AbTEQJ5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 05:57:21 -0400
Subject: Re: time interpolation hooks
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: Andrew Morton <akpm@digeo.com>, Andi Kleen <ak@muc.de>,
       Arjan van de Ven <arjanv@redhat.com>, john stultz <johnstul@us.ibm.com>,
       linux-kernel@vger.kernel.org,
       David Mosberger <davidm@napali.hpl.hp.com>
In-Reply-To: <16069.24454.349874.198470@napali.hpl.hp.com>
References: <20030516142311.3844ee97.akpm@digeo.com>
	 <16069.24454.349874.198470@napali.hpl.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053139080.7308.6.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 May 2003 19:38:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-16 at 15:00, David Mosberger wrote:
>   Andrew> (Those function pointers should go away in favour of
>   Andrew> optionally-stubbed-out static calls.  Minor point).
> 
> Really?  On ia64, we want to use cycle-based interpolation by default,
> but if firmware indicates that the cycle-counters may drift, we want
> to switch to one of several possible external counters (which counter
> gets used depends on hardware/drivers are is present).

I think Andrew is really suggesting to declare these two things
in an arch header, so if one needs it to be a function pointer one
can make it so.

-- 
David S. Miller <davem@redhat.com>
