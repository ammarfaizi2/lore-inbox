Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWBRWL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWBRWL2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 17:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWBRWL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 17:11:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:51680 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932233AbWBRWL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 17:11:27 -0500
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops during boot of 2.6.16-rc3-git7 on AMD64
References: <43F6678C.5080001@gmx.net>
From: Andi Kleen <ak@suse.de>
Date: 18 Feb 2006 23:11:23 +0100
In-Reply-To: <43F6678C.5080001@gmx.net>
Message-ID: <p734q2w5nck.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net> writes:

> Hi,
> 
> vanilla 2.6.16-rc3-git7 gives me the following oops during boot (most
> of the time while mounting all filesystems) on my amd64 machine:
> 
> (hand-written, no serial interface available)
> Unable to handle kernel NULL pointer dereference at 00000008
> rip: run_timer_softirq+322
> process udev
> Call trace:
> __do_softirq+68



Looks like someone is corrupting the timer list. Nasty. Can you do
a binary search?

Or alternatively remove as many drivers as possible and narrow down
which one is to blame.

-Andi
