Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267597AbUIMOhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267597AbUIMOhX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267615AbUIMOeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:34:15 -0400
Received: from zero.aec.at ([193.170.194.10]:50437 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266833AbUIMObX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:31:23 -0400
To: Constantine Gavrilov <constg@qlusters.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Calling syscalls from x86-64 kernel results in a crash on
 Opteron  machines
References: <2DZQy-7TB-7@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 13 Sep 2004 16:31:20 +0200
In-Reply-To: <2DZQy-7TB-7@gated-at.bofh.it> (Constantine Gavrilov's message
 of "Mon, 13 Sep 2004 16:20:06 +0200")
Message-ID: <m3r7p6gs07.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Constantine Gavrilov <constg@qlusters.com> writes:

> Can someone explain the reason for the crash? Can you think of a

syscall/sysret don't support recursive calls. That's the price for
being fast.

> workaround? Comments and ideas are very welcome (except of the kind

Just call the appropiate sys_* function directly instead.

-Andi

