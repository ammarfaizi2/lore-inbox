Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSHAOnk>; Thu, 1 Aug 2002 10:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314584AbSHAOnk>; Thu, 1 Aug 2002 10:43:40 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:51958 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S314529AbSHAOnk>; Thu, 1 Aug 2002 10:43:40 -0400
Date: Thu, 1 Aug 2002 10:47:07 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Pavel Machek <pavel@elf.ucw.cz>
Cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)
Message-ID: <20020801104707.B21032@redhat.com>
References: <20020730054111.GA1159@dualathlon.random> <20020730084939.A8978@redhat.com> <20020730214116.GN1181@dualathlon.random> <20020730175421.J10315@redhat.com> <20020731004451.GI1181@dualathlon.random> <20020801103011.GB159@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020801103011.GB159@elf.ucw.cz>; from pavel@elf.ucw.cz on Thu, Aug 01, 2002 at 12:30:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 12:30:11PM +0200, Pavel Machek wrote:
> I believe Linus actually explained why "when" looks way better to him
> than "timeout". [It does not skew, for example.]

After thinking about it further, there is one problem with when that is 
avoided with timeout: if the system time is changed between the timeout 
calculation and the time the kernel calculates the jiffies offset, the 
process could be delayed much longer than desired (and fixing this case 
is hard enough that it should be avoided in typical code).  Tradeoffs...

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
