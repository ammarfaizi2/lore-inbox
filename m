Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289793AbSAWLWE>; Wed, 23 Jan 2002 06:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289794AbSAWLVx>; Wed, 23 Jan 2002 06:21:53 -0500
Received: from babel.spoiled.org ([217.13.197.48]:33692 "HELO a.mx.spoiled.org")
	by vger.kernel.org with SMTP id <S289793AbSAWLVi>;
	Wed, 23 Jan 2002 06:21:38 -0500
From: Juri Haberland <juri@koschikode.com>
To: gspujar@hss.hns.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: file system unmount
X-Newsgroups: spoiled.linux.kernel
In-Reply-To: <65256B4A.003D4CD1.00@sandesh.hss.hns.com>
User-Agent: tin/1.4.5-20010409 ("One More Nightmare") (UNIX) (OpenBSD/2.9 (i386))
Message-Id: <20020123112137.5DEE41195E@a.mx.spoiled.org>
Date: Wed, 23 Jan 2002 12:21:37 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <65256B4A.003D4CD1.00@sandesh.hss.hns.com> you wrote:
> 
> 
> Hi,
> I am using softdog in my application. One of the problems I am facing is,
> when the system comes up after the reboot forced by softdog, file system gets
> corrupted and fsck has to check. Some times fsck fails to force check the file
> system and
> the system enters in to run level 1, leading to manual intervention.
> 
> Any idea how to unmount the file system before the system is rebooted by
> softdog, so
> that system always comes up properly without manual intervention.

Bad idea. The point in using a watchdog is that you want to *reliably*
reboot your failed machine. What if your umount hangs for some reason?
(I've seen this...)

Use a journalling filesystem instead.

Juri

-- 
Juri Haberland  <juri@koschikode.com> 

