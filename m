Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265950AbUFOUl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265950AbUFOUl6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUFOUld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:41:33 -0400
Received: from zero.aec.at ([193.170.194.10]:41733 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265946AbUFOUlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:41:07 -0400
To: Dean Nelson <dcn@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: calling kthread_create() from interrupt thread
References: <27qex-5LX-17@gated-at.bofh.it> <27qoT-5Uy-15@gated-at.bofh.it>
	<27qxQ-67a-27@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 15 Jun 2004 22:41:04 +0200
In-Reply-To: <27qxQ-67a-27@gated-at.bofh.it> (Dean Nelson's message of "Tue,
 15 Jun 2004 20:10:10 +0200")
Message-ID: <m38yeolfkv.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dean Nelson <dcn@sgi.com> writes:
>
> As mentioned above, it is possible for this "simple" function to sleep/block
> for an indefinite period of time. I was under the impression that one
> couldn't block a work queue thread for an indefinite period of time. Am
> I mistaken?

You could create your own work queue upfront. Blocking an generic workqueue 
for a long time is indeed nasty.

-Andi

