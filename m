Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263960AbSJTKd6>; Sun, 20 Oct 2002 06:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263979AbSJTKd6>; Sun, 20 Oct 2002 06:33:58 -0400
Received: from quechua.inka.de ([212.227.14.2]:11084 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S263960AbSJTKd5>;
	Sun, 20 Oct 2002 06:33:57 -0400
From: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: can chroot be made safe for non-root?
In-Reply-To: <200210191942.g9JJg2U26376@marc2.theaimsgroup.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E183DV6-0004ha-00@sites.inka.de>
Date: Sun, 20 Oct 2002 12:40:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200210191942.g9JJg2U26376@marc2.theaimsgroup.com> you wrote:
> directory (I decided against making the chroot call fail, as any software  
> buggy enough to chroot with open directory fds is likely to not check the  
> return value of chroot(2), and blindly continue on failure--even worse).   
> I'd be happy to hear about (and fix ;) anything I've missed.  

One idea would be to sigsegv the program which is doing a chroot with open
fds :)

> IIRC, FreeBSD allow a chroot'ed process to chroot again if and only if 
> the  
> new root is a subdirectory of the initial chroot.  This allows things 
> like  
> traditional, chrooting anonymous FTP to be run under an initial chroot.    

well, you can only changeroot in a subdir anyway, so this is not the point
that freebsd is allowing a chroot in a chroot. As far as I know they simply
solved the break out issue. 

BTW: kill on open fd would solve the breakout issue, too.

Greetings
Bernd
