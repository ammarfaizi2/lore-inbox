Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVB0WFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVB0WFI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 17:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVB0WFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 17:05:08 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:36270 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261321AbVB0WFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 17:05:05 -0500
Message-ID: <42224409.8010809@yahoo.com.au>
Date: Mon, 28 Feb 2005 09:04:57 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Giovanni Tusa <gtusa@inwind.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: sched_yield behavior
References: <00e901c51cbb$45b3cac0$65071897@gtusa>
In-Reply-To: <00e901c51cbb$45b3cac0$65071897@gtusa>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giovanni Tusa wrote:

> If  I am not wrong, the scheduler will choose it again (it will be still the
> higher priority task, and the only of its priority list).
> I have to add an explicit sleep to effectively relinquish the CPU for some
> time, or the scheduler can deal with such a
> situation in another way?

Yes, the scheduler will choose it again. This behaviour is also
specified in the relevant standards.

Your alternatives may be to use other methods of userspace
synchronisation (eg. pipes, semaphores), or to use timers.

