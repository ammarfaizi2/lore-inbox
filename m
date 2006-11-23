Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934191AbWKWWZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934191AbWKWWZT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 17:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934182AbWKWWZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 17:25:19 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:5535 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S934191AbWKWWZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 17:25:17 -0500
Date: Thu, 23 Nov 2006 23:24:13 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch 00/21] Highres / dynticks drop in replacement for
 2.6.19-rc5-mm1
In-Reply-To: <20061109233030.915859000@cruncher.tec.linutronix.de>
Message-ID: <Pine.LNX.4.64.0611120138460.6242@scrub.home>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 9 Nov 2006, Thomas Gleixner wrote:

> Andrew,
> 
> this is a drop in replacement for the following patches in 2.6.19-rc5-mm1:
> 
> hrtimers-state-tracking.patch
> up to
> acpi-verify-lapic-timer-fix.patch

There is still the gtod-exponential-update_wall_time patch before that, I 
explained previously why it's wrong and how to fix this properly. Andrew, 
please drop this one.

http://www.ussg.iu.edu/hypermail/linux/kernel/0609.3/1320.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0609.3/1303.html

Something I also wanted to mention about the OLS paper: It's an 
interesting read and answers a few question, but not all. It concentrates 
very much on the past (previous and current implementations), what I'm 
missing are more details on how it can be used in the future. IMO it's 
very important information regarding merging, i.e. how can this be applied 
to our various architectures. This is were have my doubts and more 
questions about it later.

The paper stresses the point that it provides a generic infrastructure, 
but as such it also brings some amazing complexities. Dedicated 
implementations often have the advantage to be simpler and faster (I'm not 
saying that current ones are). How does your implementation keep the 
source and runtime complexities under control? Such generic frameworks 
have the tendency to grow - new requirements have to be met and thus 
complexity further increases.

bye, Roman
