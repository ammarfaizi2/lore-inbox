Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266897AbUHOU6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266897AbUHOU6x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 16:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266899AbUHOU6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 16:58:53 -0400
Received: from zero.aec.at ([193.170.194.10]:40197 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266897AbUHOU6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 16:58:52 -0400
To: Danny van Dyk <kugelfang@gentoo.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Microcode Update Driver for AMD K8 CPUs
References: <2tvqK-3rv-7@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sun, 15 Aug 2004 22:58:48 +0200
In-Reply-To: <2tvqK-3rv-7@gated-at.bofh.it> (Danny van Dyk's message of
 "Sun, 15 Aug 2004 17:50:06 +0200")
Message-ID: <m3n00wktiv.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny van Dyk <kugelfang@gentoo.org> writes:

> I recently found some piece of code [1] to perform a microcode update
> on AMD's K8 CPUs. It included some update blocks hardcoded into the
> module.

Several people found this code (including me). But I don't think
it's a good idea right now to merge because it is better to leave
these things to the BIOS. It's unlikely that AMD will regularly
release "open" microcode updates anyways, and moving them
between BIOSes seems a bit dangerous to me (often you likely
need to change some magic MSRs too or you could have some 
side effects). Overall it seems to be too dangerous to 
do in a standard kernel. 

Also I suspect the driver won't work very well on SMP. 

-Andi

