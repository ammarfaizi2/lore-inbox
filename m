Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267165AbSLQVmg>; Tue, 17 Dec 2002 16:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267164AbSLQVmg>; Tue, 17 Dec 2002 16:42:36 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:17907 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S267165AbSLQVmf>; Tue, 17 Dec 2002 16:42:35 -0500
Date: Tue, 17 Dec 2002 16:50:33 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ulrich Drepper <drepper@redhat.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021217165033.E10781@redhat.com>
References: <1040153030.20804.8.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0212171046550.1095-100000@home.transmeta.com> <20021217163458.B10781@redhat.com> <3DFF98F5.60706@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DFF98F5.60706@transmeta.com>; from hpa@transmeta.com on Tue, Dec 17, 2002 at 01:36:53PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 01:36:53PM -0800, H. Peter Anvin wrote:
> Benjamin LaHaise wrote:
> >
> > The stubs I used for the vsyscall bits just did an absolute jump to 
> > the vsyscall page, which would then do a ret to the original calling 
> > userspace code (since that provided library symbols for the user to 
> > bind against).
> > 
> 
> What kind of "absolute jumps" were this?

It was a far jump (ljmp $__USER_CS,<address>).

		-ben
-- 
"Do you seek knowledge in time travel?"
