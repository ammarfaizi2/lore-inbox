Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288932AbSANTLC>; Mon, 14 Jan 2002 14:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288959AbSANTJt>; Mon, 14 Jan 2002 14:09:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48134 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288801AbSANTJR>; Mon, 14 Jan 2002 14:09:17 -0500
Subject: Re: Hardwired drivers are going away?
To: david.lang@digitalinsight.com (David Lang)
Date: Mon, 14 Jan 2002 19:21:01 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), esr@thyrsus.com,
        babydr@baby-dragons.com, cate@debian.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0201141055410.22904-100000@dlang.diginsite.com> from "David Lang" at Jan 14, 2002 10:57:19 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QCfF-0002c8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Urban legend.
> 
> If this is the case then why do I get systemcall undefined error messages
> when I make a mistake and attempt to load a module on a kernel without
> modules enabled?

Because you are using insmod. The guys who break into your computer probably 
are not in their own language "that lame".

> > I defy you to measure it on x86
> 
> during the discussion a few weeks ago there were people pointing out cases
> where this overhead would be a problem.

TLB miss overhead for kernel modules is very very hard to measure, at least
on the x86 platform. It can be an issue in userspace as you address much
larger objects and in certain cases like scanning an element in an array
of objects hit a TLB reload each scan or two (think about vertical line draw
unaccelerated in X11)

> > tar or nfs mount; make modules_install.
> >
> not on my firewalls thank you.

If you are that worried just burn a new root file system on CD when you 
upgrade your firewall. At least I hope if you are going to pretend to be 
so secure that tar is a bad idea you have no writable file store on the
machine ?

Alan
