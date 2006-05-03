Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbWECFjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbWECFjO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 01:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbWECFjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 01:39:14 -0400
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:47792 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S965092AbWECFjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 01:39:13 -0400
Date: Wed, 3 May 2006 01:37:08 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.17-rc2-mm1
To: Martin Bligh <mbligh@google.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Message-ID: <200605030138_MC3-1-BEA4-2D44@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <445641EF.70601@google.com>

On Mon, 01 May 2006 10:14:23 -0700, Martin Bligh wrote:

> >>Code: e8 4c ba d8 ff 65 48 8b 34 25 00 00 00 00 4c 8b 46 08 f0 41
> >>RIP <ffffffff8047c8b8>{__sched_text_start+1856} RSP <0000000000000000>
> >>  -- 0:conmux-control -- time-stamp -- May/01/06  3:54:37 --
> > 
> > 
> > I was not able to reproduce this on the 4-way EMT64 machine.  Am a bit stuck.
> 
> OK, is there anything we could run this with that'd dump more info?
> (eg debug patches or something). There's bugger all of use that I
> can see in that stack (and why does __sched_text_start come up anyway,
> is that an x86_64-ism ?).

Look at your System.map and see if another symbol has the same address
as __sched_text_start.

I have:

ffffffff8042eb30 T io_schedule_timeout
ffffffff8042eb30 T __sched_text_start

-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"

