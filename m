Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWGKUGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWGKUGm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWGKUGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:06:42 -0400
Received: from mx1.suse.de ([195.135.220.2]:31159 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751140AbWGKUGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:06:41 -0400
Date: Tue, 11 Jul 2006 22:06:40 +0200
From: Olaf Hering <olh@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jeff Garzik <jeff@garzik.org>, Michael Tokarev <mjt@tls.msk.ru>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060711200640.GA17653@suse.de>
References: <20060711044834.GA11694@suse.de> <44B37D9D.8000505@tls.msk.ru> <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com> <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org> <20060711171624.GA16554@suse.de> <44B3E7D5.8070100@zytor.com> <20060711181552.GD16869@suse.de> <44B3EC5A.1010100@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44B3EC5A.1010100@zytor.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jul 11, H. Peter Anvin wrote:

> Olaf Hering wrote:
> >"It would be nice if ..." someone can build a list of things that
> >changed over time. Say from 2.0.0 to 2.6.18. Just struct layouts and 
> >defines.
> >
> >I havent tried it, but one would hope that the /bin/ls from SuSE 5.3 still
> >works today.  Guess its time for me to actually try that the next days.
> 
> You know how much code there is in glibc to make your /bin/ls still work?

I heard about that, but did never inspect that code.

My point is:
I see all day that people use some fixed distro for kernel development,
thats their stable base. In my case, 2.4.19 based SLES8 for 2.6
development. 2.6.5 based SLES9 for todays kernel. In a few weeks, they
will move on to 2.6.16 based SLES10. Same thing with other distros.

This means their tools continue to work, eventually they have to upgrade
a few things to test newly added features. Thats what everyone on this
list does all day. It means also that regression testing is possible.
One can even boot a 2.4 kernel in SLES9 to try things out, despite the
fact that many boot scripts rely on sysfs. So I dont see why a kinit
that knows about a range of kernels should not be possible. No idea how
hairy device-mapper, lvm or evms support is, the "standard" tools
appearently cope with interface changes.
If you decide to drop support for 2.6.16 in 3 years, thats ok. But not
in 3 months please.

And to give a negative example for great regression test opportunities:
You guessed it, SLES10 has a udev that cant handle kernels before 2.6.15.
Great job. I could slap them all day...
