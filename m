Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266526AbUGKIky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266526AbUGKIky (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 04:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266524AbUGKIkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 04:40:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46011 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266521AbUGKIkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 04:40:43 -0400
Date: Sun, 11 Jul 2004 04:38:03 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: davidm@hpl.hp.com
cc: suresh.b.siddha@intel.com, jun.nakajima@intel.com,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: serious performance regression due to NX patch
In-Reply-To: <200407100528.i6A5SF8h020094@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com>
References: <200407100528.i6A5SF8h020094@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Jul 2004, David Mosberger wrote:

> The "No eXecute patch for x86" causes a serious exec() performance
> degradation on ia64 since it ends up incorrectly turning on the execute
> protection on all segments (since most ia64 binaries don't have a
> gnu_stack program-header).
> 
> The patch below fixes the problem by turning on VM_EXEC and VM_MAYEXEC
> only if VM_DATA_DEFAULT_FLAGS mentions them.  Note that on ia64, the
> value of VM_DATA_DEFAULT_FLAGS depends on the personality (to support
> x86 binaries) and hence I had to move the setting of "def_flags" down a
> bit to a point after SET_PERSONALITY() has been done.
> 
> Please apply.

ok, agreed. I'll check that it still does the right thing on x86.

	Ingo
