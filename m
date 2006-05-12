Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWELKhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWELKhb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWELKhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:37:31 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:62344 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751170AbWELKha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:37:30 -0400
Date: Fri, 12 May 2006 12:37:10 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Nishanth Aravamudan <nacc@us.ibm.com>,
       Linux kernel <linux-kernel@vger.kernel.org>, staubach@redhat.com
Subject: Re: Linux poll() <sigh> again
In-Reply-To: <Pine.LNX.4.61.0605111659580.5484@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0605121235140.9918@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0605111023030.3729@chaos.analogic.com>
 <20060511204741.GG22741@us.ibm.com> <Pine.LNX.4.61.0605111659580.5484@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I think that's the problem. A socket isn't a file-system and the
>code won't set either bits if it isn't. Perhaps, the kernel code
>needs to consider a socket as a virtual file of some kind?

I think they are a virtual file of some kind:

[root@mason ~]# ls -l /proc/4361/fd
lrwx------  1 root root 64 May 12 12:35 3 -> socket:[41460]
lr-x------  1 root root 64 May 12 12:35 4 -> pipe:[41496]
l-wx------  1 root root 64 May 12 12:35 5 -> pipe:[41496]

These "files" (socket:[] and pipe:[]) have a dentry in sockfs and 
pipefs (you can't mount the fss, but they are there, see /proc/filesystems)


Jan Engelhardt
-- 
