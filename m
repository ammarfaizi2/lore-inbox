Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268296AbUHXUxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268296AbUHXUxW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268316AbUHXUxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:53:21 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:62420 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S268296AbUHXUxM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:53:12 -0400
Date: Tue, 24 Aug 2004 16:53:07 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: "K.R. Foley" <kr@cybsft.com>, Ingo Molnar <mingo@elte.hu>,
       Scott Wood <scott@timesys.com>, manas.saksena@timesys.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P9
Message-ID: <20040824205307.GA11123@yoda.timesys>
References: <20040823221816.GA31671@yoda.timesys> <20040824061459.GA29630@elte.hu> <412B7E50.1030806@cybsft.com> <1093379558.817.60.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093379558.817.60.camel@krustophenia.net>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 04:32:39PM -0400, Lee Revell wrote:
> I am not sure this is solvable though.  If you fire off a bunch of
> processes that try to allocate way more memory than is physically
> available then you will have worse problems than latency.

I don't see why it would be unsolvable if you limit the expectation
of reasonable latency to processes that have mlockall()ed and
allocated all the memory they need in advance (and don't have to wait
on processes that haven't).  Obviously, the latency for actually
allocating memory isn't going to be too good in such a case (though
strict no-overcommit could decrease the latency of failure to
allocate).

-Scott
