Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264761AbUE0P0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264761AbUE0P0N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 11:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264790AbUE0P0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 11:26:13 -0400
Received: from zero.aec.at ([193.170.194.10]:13062 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264761AbUE0P0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 11:26:08 -0400
To: Arthur Perry <kernel@linuxfarms.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: GART error 11 (fwd)
References: <20uGg-17i-23@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 27 May 2004 17:26:05 +0200
In-Reply-To: <20uGg-17i-23@gated-at.bofh.it> (Arthur Perry's message of
 "Thu, 27 May 2004 17:10:12 +0200")
Message-ID: <m3d64pvqlu.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arthur Perry <kernel@linuxfarms.com> writes:

> Here is a posting that I dropped off in RedHat's amd64-list.
> It is a kernel related issue, so if anybody has any insight or opinion of
> proper implementation here, please jump in!

Machine Check Exceptions are in front of all hardware issues, not kernel 
issues. It is your CPU trying to tell you that something is wrong in the
hardware.

The 2.4 MCE code tends to label unrelated MCEs as "GART error" because
of bugs in the MCE decoding functions. There is a full fix for that 
in the works.

In some early 2.4 kernels it also managed to trigger a CPU bug
by writing directly nb registers.  This should be fixed in later
2.4 kernels and also in SuSE SLES8-SP3.

Best alternative is to use 2.6 which has much improved MCE handling.

-Andi

