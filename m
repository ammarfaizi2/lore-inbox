Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751778AbWBMN4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbWBMN4l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 08:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbWBMN4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 08:56:41 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:12933 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751778AbWBMN4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 08:56:40 -0500
Date: Mon, 13 Feb 2006 14:54:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] hrtimer: remove data field
Message-ID: <20060213135456.GC12923@elte.hu>
References: <Pine.LNX.4.61.0602130211060.23839@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602130211060.23839@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> The nanosleep cleanup allows to remove the data field of hrtimer. The 
> callback function can use container_of() to get it's own data. Since 
> the hrtimer structure is usually embedded in other structures, the 
> code also becomes a bit simpler.

i addressed this when you first raised this issue (back in the ktimers 
flamewars), and generally the feeling of people i asked was that doing 
the container_of() approach is less readable than an explicit 'data' 
field. It also deviates from struct timer_list, which we wanted to stay 
close to. Furthermore, for standalone hrtimers this creates the need to 
generate a wrapper structure. So i dont really like this change - but no 
strong feelings either way.

	Ingo
