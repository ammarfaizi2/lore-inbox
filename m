Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbUCSCE5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 21:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUCSCE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 21:04:57 -0500
Received: from zero.aec.at ([193.170.194.10]:37639 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261708AbUCSCE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 21:04:56 -0500
To: colpatch@us.ibm.com
cc: linux-kernel@vger.kernel.org, pj@sgi.com
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
References: <1BeOx-7ax-55@gated-at.bofh.it> <1BgGq-DU-5@gated-at.bofh.it>
	<1BgZN-Vk-1@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 19 Mar 2004 03:04:41 +0100
In-Reply-To: <1BgZN-Vk-1@gated-at.bofh.it> (Matthew Dobson's message of
 "Fri, 19 Mar 2004 02:30:07 +0100")
Message-ID: <m37jxhvbgm.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson <colpatch@us.ibm.com> writes:

>> Chris Hellwig responded to it at the time asking why I didn't provide a
>> single generic mask ADT, and make cpumask and nodemask instances of
>> that.
>
> That is a better idea, if it can be made to work.  My goal is to stop

It already exists in linux/bitmap.h. I use that in NUMA API for the node masks.

It's just a bit ugly to write because you have to always pass MAX_NUMNODES.
Some wrappers would be prettier.

-Andi

