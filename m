Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266737AbUBGJxh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 04:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266757AbUBGJxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 04:53:37 -0500
Received: from dp.samba.org ([66.70.73.150]:52139 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266737AbUBGJxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 04:53:04 -0500
Date: Sat, 7 Feb 2004 20:50:57 +1100
From: Anton Blanchard <anton@samba.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Rick Lindsley <ricklind@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
Message-ID: <20040207095057.GS19011@krispykreme>
References: <200402062311.i16NBdF14365@owlet.beaverton.ibm.com> <40242152.5030606@cyberone.com.au> <231480000.1076110387@flay> <4024261E.5070702@cyberone.com.au> <232690000.1076111266@flay> <40242D14.6070908@cyberone.com.au> <242810000.1076113505@flay> <402431C5.3030205@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402431C5.3030205@cyberone.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> OK, use the revision of Rick's patch I posted, and don't use
> CONFIG_SCHED_SMT because I think there is a problem with it.

Missed this email :) I gave your last patch a spin and im seeing similar
behaviour.

Its got to be an overly enthuiastic active balance, the migration threads 
have used about 10 minutes of cpu time and a single cpu bound process
will never sleep (assuming there is nothing else to run) and so cannot be
moved by normal means.

Anton
