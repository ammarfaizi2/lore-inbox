Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267158AbSLQV1A>; Tue, 17 Dec 2002 16:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267159AbSLQV1A>; Tue, 17 Dec 2002 16:27:00 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:9969 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S267158AbSLQV07>; Tue, 17 Dec 2002 16:26:59 -0500
Date: Tue, 17 Dec 2002 16:34:58 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ulrich Drepper <drepper@redhat.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021217163458.B10781@redhat.com>
References: <1040153030.20804.8.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0212171046550.1095-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0212171046550.1095-100000@home.transmeta.com>; from torvalds@transmeta.com on Tue, Dec 17, 2002 at 10:49:31AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 10:49:31AM -0800, Linus Torvalds wrote:
> There is only a "call relative" or "call indirect-absolute". So you either
> have to indirect through memory or a register, or you have to fix up the
> call at link-time.
> 
> Yeah, I know it sounds strange, but it makes sense. Absolute calls are
> actually very unusual, and using relative calls is _usually_ the right
> thing to do. It's only in cases like this that we really want to call a
> specific address.

The stubs I used for the vsyscall bits just did an absolute jump to 
the vsyscall page, which would then do a ret to the original calling 
userspace code (since that provided library symbols for the user to 
bind against).

		-ben
-- 
"Do you seek knowledge in time travel?"
