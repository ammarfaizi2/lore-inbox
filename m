Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbUCPDAR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 22:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUCPC7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 21:59:13 -0500
Received: from zero.aec.at ([193.170.194.10]:3847 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263163AbUCPCsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 21:48:23 -0500
To: Peter Williams <peterw@aurema.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: finding out the value of HZ from userspace
References: <1zkOe-Uc-17@gated-at.bofh.it> <1zl7M-1eJ-43@gated-at.bofh.it>
	<1zn9p-3mW-5@gated-at.bofh.it> <1znj5-3wM-15@gated-at.bofh.it>
	<1AaWr-655-7@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 16 Mar 2004 03:27:03 +0100
In-Reply-To: <1AaWr-655-7@gated-at.bofh.it> (Peter Williams's message of
 "Tue, 16 Mar 2004 01:50:07 +0100")
Message-ID: <m3fzc9o7bc.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <peterw@aurema.com> writes:

> This horrible hack of converting all tick values to 100 (from 1000)
> for export to user space because a large number of user space programs
> assume that HZ is 100 would NOT be necessary if there was a mechanism
> whereby user space programs could find out how many ticks there are in
> a second instead of having to make assumptions.

Already exists for a long time - AT_CLKTCK. glibc has a nice wrapper
for it too (sysconf)

-Andi

