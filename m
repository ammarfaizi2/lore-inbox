Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbVINRz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbVINRz0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbVINRzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:55:24 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:27900 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030297AbVINRzX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:55:23 -0400
Subject: Re: [RFC][PATCH] NTP shift_right cleanup (v. A1)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: yoshfuji@linux-ipv6.org, Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       George Anzinger <george@mvista.com>, joe-lkml@rameria.de
In-Reply-To: <1126720091.3455.56.camel@cog.beaverton.ibm.com>
References: <1126720091.3455.56.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 10:53:14 -0700
Message-Id: <1126720398.3455.58.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 10:48 -0700, john stultz wrote:
> +/* Required to safely shift negative values */
> +#define shift_right(x, s) ({	\
> +	__typeof__(x) __x = x;	\
> +	__typeof__(s) __s = s;	\
> +	(__x < 0) ? (-((-__x) >> (__s))) : ((__x) >> (__s));	\
> +})
> +

Ah, crud. Scratch that. I forgot to check in the paren change suggested
by Roman. A new patch will follow shortly.

thanks
-john


