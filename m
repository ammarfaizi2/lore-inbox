Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTHJNHz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 09:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbTHJNHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 09:07:55 -0400
Received: from mail.suse.de ([213.95.15.193]:18697 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263997AbTHJNHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 09:07:54 -0400
Date: Sun, 10 Aug 2003 15:07:52 +0200
From: Andi Kleen <ak@suse.de>
To: kwijibo@zianet.com
Cc: Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>,
       richard.brunner@amd.com, linux-kernel@vger.kernel.org
Subject: Re: Machine check expection panic
Message-ID: <20030810130752.GB586@wotan.suse.de>
References: <3F3182B5.3040301@zianet.com.suse.lists.linux.kernel> <20030807002722.GA3579@suse.de.suse.lists.linux.kernel> <p73ekzynuxt.fsf@oldwotan.suse.de> <3F35FE5B.7060003@zianet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F35FE5B.7060003@zianet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The CPU's aren't overclocked and have worked fine for
> me under much heavier loads than booting a kernel for

It could be corrected ECC errors in the cache. If that
happens I would consider it a hardware problem

(now hidden with the disabled bank).

> at least a year. Using the 2.4 kernel that is. Once
> I remove the exception code from the kernel it boots
> fine and runs fine under any load I put it under.

I maintain that such a magic hack needs at least a big fat comment.

I still find the change very suspicious, there isn't any errata that 
says that bank 0 is bad on Athlon.

Also disabling a whole bank just for some buggy CPUs is quite a sledgehammer,
it would be probably better to identify the bank 0 sub unit that causes it
and only turn that off.

-Andi

