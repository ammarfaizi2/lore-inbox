Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267561AbUHTFJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbUHTFJi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 01:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267556AbUHTFJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 01:09:38 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:62936 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267561AbUHTFJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 01:09:09 -0400
Subject: Re: [PATCH] [1/4] /dev/random: Fix latency in rekeying sequence
	number
From: Lee Revell <rlrevell@joe-job.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <E1By1Sh-0001TJ-1U@thunk.org>
References: <E1By1Sh-0001TJ-1U@thunk.org>
Content-Type: text/plain
Message-Id: <1092978626.10063.15.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 01:10:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 00:57, Theodore Ts'o wrote:
> Based on reports from Ingo's Latency Tracer that the TCP sequence number
> rekey code is causing latency problems, I've moved the sequence number
> rekey to be done out of a workqueue.
> 

This patch does not actually fix the problem, as 3-700usecs is still
spent in the spinlocked region, this just causes it to be done out of a
workqueue.  It reduces the incidence of problems, but for latency
sensitive applications the worst-case is the important one.

Lee

