Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVATUEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVATUEq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 15:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVATUBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 15:01:19 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40602 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261922AbVATT7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:59:14 -0500
Date: Thu, 20 Jan 2005 15:43:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] /proc/<pid>/rlimit
Message-ID: <20050120144358.GI476@openzaurus.ucw.cz>
References: <20050118204457.GA7824@ti64.telemetry-investments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118204457.GA7824@ti64.telemetry-investments.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch against 2.6.11-rc1-bk6 adds /proc/<pid>/rlimit to export
> per-process resource limit settings.  It was written to help analyze
> daemon core dump size settings, but may be more generally useful.
> Tested on 2.6.10. Sample output:
> 
> 	root@tiny ~ # cat /proc/__/rlimit
> 	cpu unlimited unlimited
> 	fsize unlimited unlimited
> 	data unlimited unlimited
> 	stack 8388608 unlimited
> 	core 0 unlimited
> 	rss unlimited unlimited
> 	nproc 111 111
> 	nofile 1024 1024
> 	memlock 32768 32768
> 	as unlimited unlimited
> 	locks unlimited unlimited
> 	sigpending 1024 1024
> 	msgqueue 819200 819200
> 
> Feedback welcome.

It would be nice if you could make it "value-per-file". That way,
it could become writable in future. If "max nice level" ever becomes rlimit,
this would be very usefull.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

