Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUIANDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUIANDl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266425AbUIANDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:03:40 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38373 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266362AbUIANDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:03:39 -0400
Date: Wed, 1 Sep 2004 15:05:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5 - netdev_max_back_log is too small
Message-ID: <20040901130518.GA10060@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040830192131.GA12249@elte.hu> <4135C12B.6050208@fr.thalesgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4135C12B.6050208@fr.thalesgroup.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* P.O. Gaillard <pierre-olivier.gaillard@fr.thalesgroup.com> wrote:

> I know that you have reduced netdev_max_back_log to 8 to reduce the
> latency. But I think that you should know that I had to set it back to
> 32 to avoid ethernet frame losses on a 3GHz P4 using e1000
> (eth0/threaded=1).

could you try the -Q6 patch? That leaves netdev_max_backlog at the
default value of 300 and uses another method to break up the networking
codepaths, without any bad tradeoffs.

	Ingo
