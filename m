Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264983AbUEYRPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264983AbUEYRPY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 13:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264986AbUEYRPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 13:15:23 -0400
Received: from zero.aec.at ([193.170.194.10]:50693 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264980AbUEYROi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 13:14:38 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI Express patches for 2.4.27-pre3
References: <1ZuS0-1b4-15@gated-at.bofh.it> <1ZE52-8sy-15@gated-at.bofh.it>
	<1ZFaF-10N-13@gated-at.bofh.it> <1ZIrV-3xS-7@gated-at.bofh.it>
	<1ZJHt-4At-33@gated-at.bofh.it> <1ZLpV-5YK-37@gated-at.bofh.it>
	<1ZNBb-7QA-1@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 25 May 2004 19:14:34 +0200
In-Reply-To: <1ZNBb-7QA-1@gated-at.bofh.it> (Marcelo Tosatti's message of
 "Tue, 25 May 2004 19:10:05 +0200")
Message-ID: <m3smdo1lad.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:
>
> Yeap, I would prefer not to apply them at this time. For one, Arjan told
> me privately it can break XFree86 which accesses the PCI config space directly.
> Right?

Erm,no. In fact it could even fix XFree86 for that, because the way
they do it currently in user space is racy and the kernel doing it 
differently would fix that race. But I would still recommend to 
not apply it, since it is somewhat risky e.g. for triggering 
new hardware bugs and it is not really needed and would dilute the
message of freeze %) XFree86 should be fixed in user space to use the proper
access methods provided by the kernel (/proc/sys etc.) 

-Andi

