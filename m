Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWB0OSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWB0OSq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 09:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWB0OSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 09:18:46 -0500
Received: from cantor.suse.de ([195.135.220.2]:56722 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751240AbWB0OSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 09:18:45 -0500
To: nagar@watson.ibm.com
Cc: lse-tech <lse-tech@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 5/7]  synchronous block I/O delays
References: <1141026996.5785.38.camel@elinux04.optonline.net>
	<1141028448.5785.64.camel@elinux04.optonline.net>
From: Andi Kleen <ak@suse.de>
Date: 27 Feb 2006 15:18:40 +0100
In-Reply-To: <1141028448.5785.64.camel@elinux04.optonline.net>
Message-ID: <p73fym428cf.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar <nagar@watson.ibm.com> writes:

> delayacct-blkio.patch
> 
> Record time spent by a task waiting for completion of 
> userspace initiated synchronous block I/O. This can help
> determine the right I/O priority for the task.

I think it's a good idea to have such a statistic by default.

Can you add a counter that is summed up in task_struct and reports
in /proc/*/stat so that it could be displayed by top? 

This way it would be useful even with "normal" user space.

-Andi
