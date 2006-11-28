Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935892AbWK1RVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935892AbWK1RVw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 12:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758721AbWK1RVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 12:21:52 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:7801 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1758719AbWK1RVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 12:21:51 -0500
Message-ID: <456C704F.3050008@cfl.rr.com>
Date: Tue, 28 Nov 2006 12:22:23 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Entropy Pool Contents
References: <ek2nva$vgk$1@sea.gmane.org> <456B3483.4010704@cfl.rr.com> <ekfehh$kbu$1@taverner.cs.berkeley.edu> <456B4CD2.7090208@cfl.rr.com> <ekfifg$n41$1@taverner.cs.berkeley.edu> <mj+md-20061128.131233.3594.atrey@ucw.cz>
In-Reply-To: <mj+md-20061128.131233.3594.atrey@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Nov 2006 17:21:58.0664 (UTC) FILETIME=[B5AB9080:01C71311]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14840.003
X-TM-AS-Result: No--6.877000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
> More importantly, it should be possible for root to write to /dev/random
> _without_ increasing the entropy count, for example when restoring random
> pool contents after reboot. In such cases you want the pool to contain
> at least some unpredictable data before real entropy arrives, so that
> /dev/urandom cannot be guessed, but you unless you remember the entropy
> counter as well, you should not add any entropy.

After a reboot the entropy estimate starts at zero, so if you are adding 
data to the pool from the previous boot, you DO want the estimate to 
increase because you are, in fact, adding entropy.
