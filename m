Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268454AbVBFAwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268454AbVBFAwD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 19:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268344AbVBFAuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 19:50:19 -0500
Received: from av3-2-sn3.vrr.skanova.net ([81.228.9.110]:49044 "EHLO
	av3-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S267794AbVBFAnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 19:43:04 -0500
To: Laurent Riffard <laurent.riffard@free.fr>, Andrew Morton <akpm@osdl.org>
Cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc3-mm1 : mount UDF CDRW stuck in D state
References: <4204F91B.5040302@free.fr>
From: Peter Osterlund <petero2@telia.com>
Date: 06 Feb 2005 01:43:00 +0100
In-Reply-To: <4204F91B.5040302@free.fr>
Message-ID: <m3vf96r017.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Riffard <laurent.riffard@free.fr> writes:

> This is kernel 2.6.11-rc3-mm1. I can't mount an UDF-formatted cdrw
> in packet-writing mode. Mount process gets stuck in D state.
> 
> Mounting and writing this media in packet-writing mode works fine
> with kernel 2.6.11-rc2-mm2.

I tried to repeat the problem, but I didn't get far, because I get a
kernel panic right after init is started:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
...
PREEMPT
...
EIP is a strncpy_from_user+0x33/0x47
...
Call Trace:
 getname+0x69/0xa5
 sys_open+0x12/0xc6
 sysenter_past_esp+0x52/0x75
...
Kernel panic - not syncing: Attempted to kill init!

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
