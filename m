Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268851AbUJEGzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268851AbUJEGzc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 02:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268854AbUJEGzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 02:55:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42201 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268851AbUJEGzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 02:55:31 -0400
Date: Tue, 5 Oct 2004 02:54:47 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Con Kolivas <kernel@kolivas.org>
cc: =?ISO-8859-1?B?Q2hlbiw=?= Kenneth W <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: bug in sched.c:activate_task()
In-Reply-To: <cone.1096958170.135056.10082.502@pc.kolivas.org>
Message-ID: <Pine.LNX.4.58.0410050250580.4941@devserv.devel.redhat.com>
References: <200410050216.i952Gb620657@unix-os.sc.intel.com>
 <Pine.LNX.4.58.0410050229380.31508@devserv.devel.redhat.com>
 <cone.1096958170.135056.10082.502@pc.kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Oct 2004, Con Kolivas wrote:

> 	unsigned long long delta = now - next->timestamp;
> 
> 	if (next->activated == 1)
> 		delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
> 
> is in schedule() before we update the timestamp, no?

indeed ... so the patch is just random incorrect damage that happened to
distrub the scheduler fixing some balancing problem. Kenneth, what
precisely is the balancing problem you are seeing?

	Ingo
