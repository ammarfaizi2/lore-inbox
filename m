Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752089AbWCIX4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbWCIX4o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbWCIX4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:56:44 -0500
Received: from mx.pathscale.com ([64.160.42.68]:24201 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750809AbWCIX4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:56:43 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <adazmjzdwh2.fsf@cisco.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <adazmjzdwh2.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 09 Mar 2006 15:56:42 -0800
Message-Id: <1141948602.10693.58.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 15:33 -0800, Roland Dreier wrote:
>  > +		yield();	/* don't hog the cpu */
> 
> You probably don't want to do this -- yield() means "put me at the
> tail of the runqueue."  I think cond_resched() is more likely what you
> want.

OK.  I don't think it much matters either way.

>  > +#endif
>  > +/* END_NOSHIP_TO_OPENIB */
> 
> uhh... and I don't see an #if to match that #endif.

The code got drain bamaged by the patch mangling script.  The real code
contains a mess of crap to support kernels back to 2.6.9, which gets
automatically stripped, except when it gets broken as above.

Next rev will be clean in this regard.

	<b

