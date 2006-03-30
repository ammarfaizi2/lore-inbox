Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWC3QZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWC3QZG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWC3QZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:25:06 -0500
Received: from [212.76.84.251] ([212.76.84.251]:24590 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932216AbWC3QZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:25:04 -0500
From: Al Boldi <a1426z@gawab.com>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [rfc][patch] improved interactive starvation patch against
Date: Thu, 30 Mar 2006 19:12:54 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@w.ods.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200603301912.54765.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 12:19:57PM +0200, Mike Galbraith wrote:
> The patch below alone makes virgin 2.6.16 usable in the busy apache
> server scenario, and should help quite a bit with other situations as
> well.

Thanks again!

> For the one or two folks on the planet testing my anti-starvation
> patches, I've attached an incremental to my 2.6.16 test release.

After playing some more w/ sched.c tunables, which really should be exported 
through procfs, I adjusted these to yield near hardRT performance on a 
400MHz PII.

	MIN_TIMESLICE=1
	DEF_TIMESLICE=1
	PRIO_BONUS_RATIO=15
	INTERACTIVE_DELTA=20

Could you try them on vanilla 2.6.16?

Thanks!

--
Al

