Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWIBIeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWIBIeP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 04:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWIBIeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 04:34:15 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:63122 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750824AbWIBIeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 04:34:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BF2/27FmD/BZrkUB3rQjYhzT/jZ37MD4qdRJn2dllW8mvj/EhDT7K5ltZq/sK1ho7UMEMuL8PHydsstmXn7kwi66hTnmSiJpy9gEpG31Jm119PExZzny1bhKAA/wDqGXIiq78nAzc6Mb/pqf2JhufE4zzBPqeqC+u2AdrhtR80s=
Message-ID: <a44ae5cd0609020134y5ca2da7ap82403aa0e5c9b53f@mail.gmail.com>
Date: Sat, 2 Sep 2006 01:34:13 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Takashi Iwai" <tiwai@suse.de>
Subject: Re: 2.6.18-rc4-mm3 -- intel8x0 audio busted
Cc: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <a44ae5cd0608290206l6d0235abu41a09240da31b204@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0608262355q51279259lc6480f229e520fd5@mail.gmail.com>
	 <s5hac5o7v47.wl%tiwai@suse.de> <20060828114939.90341479.akpm@osdl.org>
	 <s5hlkp87ks2.wl%tiwai@suse.de>
	 <a44ae5cd0608290157s346e8371j1ee73baf14f7ba62@mail.gmail.com>
	 <s5hy7t76hjn.wl%tiwai@suse.de>
	 <a44ae5cd0608290206l6d0235abu41a09240da31b204@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/06, Miles Lane <miles.lane@gmail.com> wrote:
> On 8/29/06, Takashi Iwai <tiwai@suse.de> wrote:
> > At Tue, 29 Aug 2006 01:57:11 -0700,
> > Miles Lane wrote:
> > >
> > > On 8/28/06, Takashi Iwai <tiwai@suse.de> wrote:
> > > > At Mon, 28 Aug 2006 11:49:39 -0700,
> > > > Andrew Morton wrote:
> > > > >
> > > > > On Mon, 28 Aug 2006 17:11:52 +0200
> > > > > Takashi Iwai <tiwai@suse.de> wrote:
> > > > >
> > > > > > At Sat, 26 Aug 2006 23:55:32 -0700,
> > > > > > Miles Lane wrote:
> > > > > > >
> > > > > > > I haven't had working audio in 2.6.18-rc4-mm series (1,2,3).
> > > > > > > I haven't been able to track down the cause yet.  The modules
> > > > > > > all load, and there seems to be the expected enties in /proc,
> > > > > > > but my sound preferences panel shows no available audio card.
> > > > > > (snip)
> > > > > > > Aug 26 23:16:56 localhost kernel: warning: process `alsactl' used the
> > > > > > > obsolete sysctl system call
> > > > > > > Aug 26 23:16:56 localhost kernel: warning: process `ls' used the
> > > > > > > obsolete sysctl system call
> > > > > > > Aug 26 23:16:56 localhost kernel: warning: process `alsactl' used the
> > > > > > > obsolete sysctl system call
> > > > > > > Aug 26 23:16:56 localhost kernel: warning: process `amixer' used the
> > > > > > > obsolete sysctl system call
> > > > > > > Aug 26 23:16:56 localhost kernel: warning: process `amixer' used the
> > > > > > > obsolete sysctl system call
> > > > > >
> > > > > > Are these messages relavant?  Even "ls" fails there...
> > > > > >
> > > > >
> > > > > No, they're just a little warning we put in there to find out how
> > > > > removeable sys_sysctl() is.  (Answer: not very.  I'll drop that patch).
> > > > >
> > > > > It isn't relevant to this problem.
> > > >
> > > > OK.
> > > >
> > > > Then it must be something in the driver communication.
> > > > Miles, do you have proper /dev/snd/* entries?
> > >
> > > Hello,
> > >
> > > I have no /dev/snd directory.
> >
> > That's odd.  Any udev errors?
> > Do you have /sys/class/sound/* directories?

I didn't figure out how to get Ubuntu's udev installation working
(it's version 079), but I tried replacing Ubuntu's udev with 098 built
from source off of kernel.org.  It worked.  It would be nice to know
why the other version is failing with the current MM tree, but it
appears that it'll all get sorted out when Ubuntu rolls out an
up-to-date udev package.

Thanks,
        Miles

-- 
VGER BF report: H 0.435924
