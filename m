Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264519AbUEaCod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbUEaCod (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 22:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbUEaCod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 22:44:33 -0400
Received: from main.gmane.org ([80.91.224.249]:54742 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264519AbUEaCoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 22:44:32 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Calvin Spealman <calvin@ironfroggy.com>
Subject: Re: How to use floating point in a module?
Date: Sun, 30 May 2004 22:39:02 +0000
Message-ID: <1525857.l1LCNaafU7@ironfroggy.com>
References: <200405310152.i4V1qNk03732@mailout.despammed.com> <yw1xbrk5baq3.fsf@kth.se>
Reply-To: calvin@ironfroggy.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-069-132-046-251.carolina.rr.com
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> Floating point is forbidden in kernel code since the floating point
> registers (and other floating point context) is not saved/restored
> during system calls, for efficiency.  I'm speculating here, but it
> might be possible to manually save the floating point context while
> doing some floating point operations.  The problem arises if this code
> is interrupted midway.  Using a preemptive 2.6 kernel would easily
> break here.

What about adding some functions such as enable_fpreg_syscalls() and
disable_fpreg_syscalls() that could be called before and after any floating
point operations? They could set a flag somewhere that would cause the
float registers to be saved/restored. Forgive me if this is somehow stupid.
I'm very much a kernel newbie.

