Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265055AbUHRMug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbUHRMug (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 08:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUHRMug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 08:50:36 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:44936 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265055AbUHRMue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 08:50:34 -0400
Message-ID: <41235090.8090909@yahoo.com.au>
Date: Wed, 18 Aug 2004 22:50:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Simon Derr <Simon.Derr@bull.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: sched_setaffinity() and load balancing
References: <Pine.A41.4.53.0408181338030.20680@isabelle.frec.bull.fr>
In-Reply-To: <Pine.A41.4.53.0408181338030.20680@isabelle.frec.bull.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Derr wrote:
> Hello,
> 
> This is probably a known issue, or even maybe the expected behaviour, but
> it seems that using sched_setaffinity() can severely disturb load
> balancing on recent kernels. My tests are with 2.6.8-rc3 but I suppose
> other kernel versions behave the same way.
> 

Yep, it shouldn't be anything new.

You could justify the problem by saying that by using setaffinity, the
user has asserted that they know best and so it is OK for the balancer
to crap itself.

Ideally it would be handled nicely, but not a lot of people care at the
moment.
