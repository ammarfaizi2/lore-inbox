Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266460AbUHBMtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266460AbUHBMtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 08:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266472AbUHBMtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 08:49:21 -0400
Received: from zero.aec.at ([193.170.194.10]:58892 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266460AbUHBMtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 08:49:20 -0400
To: Tony Lindgren <tony@atomide.com>
cc: linuxkernellist@wonderclown.com, linux-kernel@vger.kernel.org
Subject: Re: MSI K8N Neo + powernow-k8: ACPI info is worse than BIOS PST
References: <2o2IK-8gu-7@gated-at.bofh.it> <2oI5h-3A8-7@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 02 Aug 2004 14:49:13 +0200
In-Reply-To: <2oI5h-3A8-7@gated-at.bofh.it> (Tony Lindgren's message of
 "Mon, 02 Aug 2004 12:20:07 +0200")
Message-ID: <m3n01dso1i.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:
>
> Just to clarify a bit, my patch only uses the 800MHz hardcoded, which
> should work on all AMD64 processors. The max value used is the current
> running value.

No, it won't. It will fail on the new/upcomming CPUs with 1Ghz HyperTransport. 
The minimum frequency cannot be lower than the HyperTransport speed.

And for others sometimes laptop batteries are not designed to support
more than 800Mhz.

Overall hardcoding such tables is imho a bad idea, unless you
*really* know what you're doing.

-Andi

