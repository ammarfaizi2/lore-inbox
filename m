Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752067AbWISUnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbWISUnq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 16:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbWISUnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 16:43:45 -0400
Received: from ns2.suse.de ([195.135.220.15]:32180 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752067AbWISUno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 16:43:44 -0400
From: Andi Kleen <ak@suse.de>
To: Thomas Graf <tgraf@suug.ch>
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Date: Tue, 19 Sep 2006 22:43:27 +0200
User-Agent: KMail/1.9.3
Cc: David Miller <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
       master@sectorb.msk.ru, hawk@diku.dk, harry@atmos.washington.edu,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060918162847.GA4863@ms2.inr.ac.ru> <20060918.142247.14844785.davem@davemloft.net> <20060919203105.GF18349@postel.suug.ch>
In-Reply-To: <20060919203105.GF18349@postel.suug.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609192243.27511.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It seems only natural to me that the real problem is the slow
> clock source which needs to be resolved regardless of the
> outcome of this discussion. I believe that updating the stamp
> at socket enqueue time is the right thing to do but it shouldn't
> be considered as a solution to the performance problem.

While I agree it would be nice to fix that particular issue 
(it's unfortunately hard) slow clock sources in general won't go
away. They are also in lots of other platforms.

And even if you have a fast clock source not using it when you
don't need to is better. For example some x86s can be quite
slow even reading TSCs. It's much better than pmtmr
it's still is a expensive operations that is best avoided.

-Andi

