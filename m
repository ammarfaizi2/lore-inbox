Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286447AbSBGJHn>; Thu, 7 Feb 2002 04:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286462AbSBGJHf>; Thu, 7 Feb 2002 04:07:35 -0500
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:9684 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S286447AbSBGJHV>; Thu, 7 Feb 2002 04:07:21 -0500
Date: Thu, 7 Feb 2002 09:07:17 +0000
From: Anthony Campbell <ac@acampbell.org.uk>
To: linux-kernel@vger.kernel.org
Cc: sct@redhat.com
Subject: Re: Total lockups using ext3
Message-ID: <20020207090717.GB3899@debian.local>
Mail-Followup-To: Anthony Campbell <ac@acampbell.org.uk>,
	linux-kernel@vger.kernel.org, sct@redhat.com
In-Reply-To: <20020201181048.GA3104@debian.local> <20020201184123.A16610@redhat.com> <3C5AFCCA.362C4F3E@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C5AFCCA.362C4F3E@zip.com.au>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Feb 2002, Andrew Morton wrote:
> "Stephen C. Tweedie" wrote:
> > 
> > The fact that it always happens when the modem is on also suggests that
> > this is not a filesystem problem.
> 
> mm.. There are known scheduling-inside-spinlock bugs in the PPP
> driver.  Paul is working on these at present.  This will cause
> deadlocks on SMP.  Anthony seems to be running uniprocessor, but
> bad things could still happen.
> 
> It'd be interesting to enable the local-apic-on-uniprocessor
> and io-apic-on-uniprocessor options, then boot with the
> `nmi_watchdog=1' LILO option, see if you can get an NMI oops
> backtrace.
> 
> 

I discovered recently that, at least in 2.4.17, I had included SMP in
the configuration by mistake (in fact, I think it happens by default).
Eliminating it seems to have solved the lockups, or at least made them
much less frequent.

Please cc any replies to me as I'm not on the list at present.

Anthony


-- 
Anthony Campbell - running Linux GNU/Debian (Windows-free zone)
For an electronic book (The Assassins of Alamut), skeptical 
essays, and over 150 book reviews, go to: http://www.acampbell.org.uk/

Our planet is a lonely speck in the great enveloping cosmic dark. In our
obscurity, in all this vastness, there is no hint that help will come
from elsewhere to save us from ourselves. [Carl Sagan]



