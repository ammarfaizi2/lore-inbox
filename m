Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965155AbWEOTKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbWEOTKy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbWEOTKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:10:54 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:34825 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965155AbWEOTKw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:10:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IhrpvRqw+GvSnmrFHDPfxj3aQ0bAYMFx4VS38+PyQK7zLPPghRCJlcnQX55XPRxz8fmf9EWmTyZgt9FR1laT1BrJicHmo8bufRseQ/iyE+Q32xTgofEEAoJ2HPSeDQeudRUzLITvnSlOlGChN+Q7rrC8VG9qp3bt9smraa3P9KI=
Message-ID: <6bffcb0e0605151210x21eb0d24g96366ce9c121c26c@mail.gmail.com>
Date: Mon, 15 May 2006 21:10:51 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc4-mm1
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
In-Reply-To: <20060515115302.5abe7e7e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060515005637.00b54560.akpm@osdl.org>
	 <6bffcb0e0605151137v25496700k39b15a40fa02a375@mail.gmail.com>
	 <20060515115302.5abe7e7e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/06, Andrew Morton <akpm@osdl.org> wrote:
> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
> >
> > Hi,
> >
> > On 15/05/06, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm1/
> > >
> >
> > When I try to "modprobe -r i2c_i801" modprobe hangs
> >
> > [michal@ltg01-fedora ~]$ ps aux | grep mod
> > root      5943  0.0  0.0   1648   432 tty1     D+   20:15   0:00
> > modprobe -r i2c_i801
> > michal   15499  0.0  0.0   1836   496 pts/4    S+   20:33   0:00 grep mod
> >
> > Here is strace log
> > http://www.stardust.webpages.pl/files/mm/2.6.17-rc4-mm1/strace.txt
> > Here is config http://www.stardust.webpages.pl/files/mm/2.6.17-rc4-mm1/mm-config
> >
> > 2.6.17-rc3-mm1 was fine. I don't see nothing abnormal in dmesg.
> >
>
> Are you able to get a sysrq-P and/or sysrq-T trace out of it?
>

Something like
echo "t" > /proc/sysrq-trigger
modprobe -r i2c_i801
echo "t" > /proc/sysrq-trigger
?
http://www.stardust.webpages.pl/files/mm/2.6.17-rc4-mm1/mm-dmesg2

I'm not sure why when I do "echo "p" > /proc/sysrq-trigger" I get only this
[root@ltg01-fedora ~]# echo "p" > /proc/sysrq-trigger
SysRq : Show Regs

selinux?

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
