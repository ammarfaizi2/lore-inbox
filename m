Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280233AbRKFTSi>; Tue, 6 Nov 2001 14:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280210AbRKFTS2>; Tue, 6 Nov 2001 14:18:28 -0500
Received: from air-1.osdl.org ([65.201.151.5]:12553 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S280233AbRKFTSW>;
	Tue, 6 Nov 2001 14:18:22 -0500
Message-ID: <3BE835BE.DF4A98FA@osdl.org>
Date: Tue, 06 Nov 2001 11:10:54 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederman@lnxi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14-pre8 Alt-SysRq-[TM] failure during lockup...
In-Reply-To: <m3wv15n5c9.fsf@DLT.linuxnetworx.com> <3BE6DC56.5A0984A4@osdl.org> <m3pu6waae5.fsf@DLT.linuxnetworx.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> "Randy.Dunlap" <rddunlap@osdl.org> writes:
> 
> > "Eric W. Biederman" wrote:
> > >
> > > Summary:  I triggered a condition in 2.4.14-pre8 where SysRq triggered
> > > but would not print reports.  I managed to unstick the condition but
> > > had played to much to determine the root cause.  My guess is that
> > > somehow my default loglevel was messed up.  Full information is
> > > provided just case I did not muddy the waters too much.
> >
> > Do you know what the console loglevel was when you tried
> > to use Alt-SysRq-M (show_mem) or Alt-SysRq-T (show tasks ==
> > show_state)?  (first value listed in /proc/sys/kernel/printk file)
> 
> I was in single user mode so it shouldn't have been changed
> from it's default value.  But it might have been.

Eric,

I have seen some distro(s) in which either syslogd or klogd (I'm
guessing) uses the syslog syscall to change the console loglevel
value in the kernel.
This could still happen in single user mode, couldn't it?

It bugged me because I often use the "debug" boot parameter
to set console_loglevel to 10, but all of a sudden it had been
set back to 6 IIRC!  And right now on one of my test
systems it is set to 0 according to /proc/sys/kernel/printk,
although _I_ didn't ask for it to be changed to 0, and
I haven't been able to find what's changing it to 0, since
it was 10 during init/main.c.

~Randy
