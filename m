Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWH2JGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWH2JGf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 05:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWH2JGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 05:06:35 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:54974 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751333AbWH2JGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 05:06:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VMdUZjIB9XM42bl00yY6kOPymqlr0yQib+zRF0gCJI3psjHpDa0S9kZ7AJlCNe5b0yzZOPbL/yBjyLWB9TVFjVSW4WmymBwj77KC94IDDIB0YHmCUnLewazJGatq8f2V6lE0yuGtPFKkz9gISER2LKRfOoWYNq/rlvwuOlSEFN8=
Message-ID: <a44ae5cd0608290206l6d0235abu41a09240da31b204@mail.gmail.com>
Date: Tue, 29 Aug 2006 02:06:33 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Takashi Iwai" <tiwai@suse.de>
Subject: Re: 2.6.18-rc4-mm3 -- intel8x0 audio busted
Cc: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <s5hy7t76hjn.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0608262355q51279259lc6480f229e520fd5@mail.gmail.com>
	 <s5hac5o7v47.wl%tiwai@suse.de> <20060828114939.90341479.akpm@osdl.org>
	 <s5hlkp87ks2.wl%tiwai@suse.de>
	 <a44ae5cd0608290157s346e8371j1ee73baf14f7ba62@mail.gmail.com>
	 <s5hy7t76hjn.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/06, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 29 Aug 2006 01:57:11 -0700,
> Miles Lane wrote:
> >
> > On 8/28/06, Takashi Iwai <tiwai@suse.de> wrote:
> > > At Mon, 28 Aug 2006 11:49:39 -0700,
> > > Andrew Morton wrote:
> > > >
> > > > On Mon, 28 Aug 2006 17:11:52 +0200
> > > > Takashi Iwai <tiwai@suse.de> wrote:
> > > >
> > > > > At Sat, 26 Aug 2006 23:55:32 -0700,
> > > > > Miles Lane wrote:
> > > > > >
> > > > > > I haven't had working audio in 2.6.18-rc4-mm series (1,2,3).
> > > > > > I haven't been able to track down the cause yet.  The modules
> > > > > > all load, and there seems to be the expected enties in /proc,
> > > > > > but my sound preferences panel shows no available audio card.
> > > > > (snip)
> > > > > > Aug 26 23:16:56 localhost kernel: warning: process `alsactl' used the
> > > > > > obsolete sysctl system call
> > > > > > Aug 26 23:16:56 localhost kernel: warning: process `ls' used the
> > > > > > obsolete sysctl system call
> > > > > > Aug 26 23:16:56 localhost kernel: warning: process `alsactl' used the
> > > > > > obsolete sysctl system call
> > > > > > Aug 26 23:16:56 localhost kernel: warning: process `amixer' used the
> > > > > > obsolete sysctl system call
> > > > > > Aug 26 23:16:56 localhost kernel: warning: process `amixer' used the
> > > > > > obsolete sysctl system call
> > > > >
> > > > > Are these messages relavant?  Even "ls" fails there...
> > > > >
> > > >
> > > > No, they're just a little warning we put in there to find out how
> > > > removeable sys_sysctl() is.  (Answer: not very.  I'll drop that patch).
> > > >
> > > > It isn't relevant to this problem.
> > >
> > > OK.
> > >
> > > Then it must be something in the driver communication.
> > > Miles, do you have proper /dev/snd/* entries?
> >
> > Hello,
> >
> > I have no /dev/snd directory.
>
> That's odd.  Any udev errors?
> Do you have /sys/class/sound/* directories?

I don't know how to track down udev errors, unfortunately.
I now suspect that the problems I am having with network
device names getting messed up and this problem with
the sound drivers spring from the same cause (some
failure in device setup in udev).

Any suggestions on how to track down udev issues are
most appreciated!  I am curious to know whether this
is a bug in udev or in the kernel code.

Thanks,
        Miles
