Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbVJNSd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbVJNSd2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 14:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbVJNSd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 14:33:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10147 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750832AbVJNSd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 14:33:28 -0400
Date: Fri, 14 Oct 2005 11:32:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org, ak@suse.de,
       torvalds@osdl.org, mingo@elte.hu
Subject: Re: [patch 2.6.14-rc4] i386: spinlock optimization
Message-Id: <20051014113247.153cc5cc.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0510141409040.4395@chaos.analogic.com>
References: <200510141350_MC3-1-ACA0-C8C9@compuserve.com>
	<Pine.LNX.4.61.0510141409040.4395@chaos.analogic.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> wrote:
>
>  Somehow, these spin-locks got all screwed up.
> 
>  Given: nobody has the lock. The lock variable is 0.

Unlocked locks have .raw_lock.slock = 1, not 0.
