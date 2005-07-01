Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263419AbVGARlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263419AbVGARlL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 13:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263417AbVGARlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 13:41:06 -0400
Received: from postel.suug.ch ([195.134.158.23]:30955 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S263415AbVGARk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 13:40:56 -0400
Date: Fri, 1 Jul 2005 19:41:17 +0200
From: Thomas Graf <tgraf@suug.ch>
To: Patrick McHardy <kaber@trash.net>
Cc: Patrick Jenkins <patjenk@wam.umd.edu>, linux-kernel@vger.kernel.org,
       Maillist netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] multipath routing algorithm, better patch
Message-ID: <20050701174117.GW16076@postel.suug.ch>
References: <Pine.GSO.4.61.0506302014160.7400@rac1.wam.umd.edu> <42C4919A.5000009@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C4919A.5000009@trash.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Patrick McHardy <42C4919A.5000009@trash.net> 2005-07-01 02:43
> Multiple algorithms can be compiled in at once, so this patch is wrong.
> mp_alg is supplied by userspace:
> 
>         if (rta->rta_mp_alg) {
>                 mp_alg = *rta->rta_mp_alg;
> 
>                 if (mp_alg < IP_MP_ALG_NONE ||
>                     mp_alg > IP_MP_ALG_MAX)
>                         goto err_inval;
>         }
> 
> If it isn't set correctly its an iproute problem. Did you actually
> experience any problems?

Well, my patch for iproute2 to enable multipath algorithm selection
is currently being merged to Stephen together with the ematch bits.
We had to work out a dependency on GNU flex first (the berkley
version uses the same executable names) so the inclusion was
delayed a bit.
