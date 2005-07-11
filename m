Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVGKS27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVGKS27 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 14:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVGKPTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:19:08 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:15837 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261982AbVGKPSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:18:30 -0400
Message-ID: <42D28D7E.3050401@jp.fujitsu.com>
Date: Tue, 12 Jul 2005 00:17:18 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] i386: Per node IDT
References: <Pine.LNX.4.61.0507101617240.16055@montezuma.fsmlabs.com.suse.lists.linux.kernel>  <p73eka614t7.fsf@verdi.suse.de> <1121054565.3177.2.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0507110804210.16055@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0507110804210.16055@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Agreed, the first version was a per cpu one simply so that i could test it 
> on a normal SMP system. Andi seems to be of the same opinion, what do you 
> think of the hotplug cpu case (explained in previous email)?

I think we need to migrate interrupts to the other CPU
in the hotplug CPU case. Even when we use per node approach,
we need to consider interrupt migration between nodes
because all CPUs on the node could be hot-removed.

Thanks,
Kenji Kaneshige
