Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266479AbUHWSZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266479AbUHWSZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266391AbUHWSY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:24:56 -0400
Received: from zero.aec.at ([193.170.194.10]:25094 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266479AbUHWST0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:19:26 -0400
To: John Levon <levon@movementarian.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: DTrace-like analysis possible with future Linux kernels?
References: <2v3Ad-5tc-29@gated-at.bofh.it> <2v4w9-6aQ-5@gated-at.bofh.it>
	<2vxeJ-4kg-3@gated-at.bofh.it> <2vZNN-7AT-33@gated-at.bofh.it>
	<2w5q4-34M-1@gated-at.bofh.it> <2w9Dq-65C-13@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 23 Aug 2004 20:19:10 +0200
In-Reply-To: <2w9Dq-65C-13@gated-at.bofh.it> (John Levon's message of "Mon,
 23 Aug 2004 01:10:08 +0200")
Message-ID: <m3k6vphg4h.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon <levon@movementarian.org> writes:

> On Sun, Aug 22, 2004 at 08:27:38PM +0200, Tomasz K?oczko wrote:
>
>> As same as KProbe/DTrace. Can you use OProfile for something other tnan 
>> profiling ? Probably yes and this answer opens: probably it will be good 
>> prepare some common code for KProbe and Oprofile.
>
> I don't see an overlap here, except maybe the possibility of delivering
> sample events into the kprobes framework

Not sure what you mean with "delivering into the kprobes framework"
kprobes currently only uses printk which really isn't up to the 
task of any significant data delivery. The IBM people have relayfs
to solve this problem, eventually this should be probably
merged too. Without something like relayfs i don't see any way
to compete with dtrace.

-Andi

