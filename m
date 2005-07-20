Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVGTPD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVGTPD7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 11:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVGTPD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 11:03:59 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:4528 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261357AbVGTPCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 11:02:44 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.93,304,1114984800"; 
   d="scan'208"; a="12868361:sNHT31551564"
Message-ID: <42DE6791.2030305@fujitsu-siemens.com>
Date: Wed, 20 Jul 2005 17:02:41 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Alexander Nyberg <alexn@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: files_lock deadlock?
References: <42DD2E37.3080204@fujitsu-siemens.com> <1121870871.1103.14.camel@localhost.localdomain>
In-Reply-To: <1121870871.1103.14.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg wrote:

> spin_lock_irqsave is only needed when a lock is taken both in normal
> context and in interrupt context. Clearly this lock is not intended to
> be taken in interrupt context. 

According to Rusty's unreliable guide
(http://www.kernel.org/pub/linux/kernel/people/rusty/kernel-locking/c214.html)
if some code can be called from user context as well as in a softirq, at 
least spin_lock_bh() is necessary. I am not sure whether that may be 
true for the code that modifies files_lock.

> I'll take a look, that spinlock debugging information unfortunately
> doesn't give too much info :|

Thanks!

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
