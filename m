Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVLTCww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVLTCww (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 21:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVLTCww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 21:52:52 -0500
Received: from rtr.ca ([64.26.128.89]:13038 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750759AbVLTCww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 21:52:52 -0500
Message-ID: <43A77205.2040306@rtr.ca>
Date: Mon, 19 Dec 2005 21:52:53 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
Cc: "Linux-Kernel, " <linux-kernel@vger.kernel.org>, nel@vger.kernel.org
Subject: Re: About 4k kernel stack size....
References: <20051218231401.6ded8de2@werewolf.auna.net>
In-Reply-To: <20051218231401.6ded8de2@werewolf.auna.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> Hi...
> 
> I'm following the intense thread about stack size, and I see only one
> solution.
> 
> Ship the nest stable, development, -mm, everything release of everything
> with a maximum kernel/interrupt stack usage meter. The ask a poll for
> everyone to send  /proc/sys/stack_usage_max to a mailing list.

That won't do it.

The mainline code paths are undoubtedly fine with 4K stacks.
It's the *error paths* that are most likely to go deeper on the stack,
and those are rarely exercised by anyone.  And those are the paths
that we *really* need to be reliable.

Cheers
