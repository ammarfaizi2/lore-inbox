Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422999AbWBAWzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422999AbWBAWzp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 17:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423001AbWBAWzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 17:55:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:45739 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422999AbWBAWzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 17:55:44 -0500
From: Andi Kleen <ak@suse.de>
To: john.blackwood@ccur.com
Subject: Re: CONFIG_K8_NUMA x86_64 no-memory node bug
Date: Wed, 1 Feb 2006 23:55:28 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, bugsy@ccur.com
References: <43E13273.5020202@ccur.com>
In-Reply-To: <43E13273.5020202@ccur.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200602012355.28794.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 23:13, John Blackwood wrote:
> I would like to mention a bug with the x86_64 CONFIG_K8_NUMA support.
> 
> We have a 4 CPU AMD Opteron (processor 846 -- no dual core) system that
> boots up with a 2.6.15.2-based kernel with NUMA enabled if all the numa
> nodes are populated with memory modules.
> 
> If we then pull out the memory module for the 3rd CPU/node, then the
> kernel will no longer boot.
> 
> In this configuration, after the grub 'boot' command is entered, no
> output is seen, and the system appears to be hung.
> 
> While this is admittedly a 'degraded' configuration, it would be nice
> if the kernel could handle having a middle numbered node without memory.
> 
> I believe that removing the 4th CPU's memory module so that only the
> last CPU/node is without memory, then the system boots up fine.
> 
> It seems that having a middle node without memory is what causes this
> problem to occur.

Does it boot with numa=noacpi? 

If yes then I likely already fixed the bug. But send boot log of
the failure anyways.

-Andi
