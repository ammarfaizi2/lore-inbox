Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136010AbRDVKDj>; Sun, 22 Apr 2001 06:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136009AbRDVKDU>; Sun, 22 Apr 2001 06:03:20 -0400
Received: from quechua.inka.de ([212.227.14.2]:29500 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S136008AbRDVKDK>;
	Sun, 22 Apr 2001 06:03:10 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Idea: Encryption plugin architecture for file-systems
In-Reply-To: <8766fyt5x3.fsf@xyzzy.adsl.dk> <Pine.LNX.4.30.0104211547470.21994-100000@anime.net>
Organization: private Linux site, southern Germany
Date: Sun, 22 Apr 2001 11:42:50 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14rGOJ-0003yo-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think he wants to avoid the *!!SEVERE!!* performance problems in
> loopback crypto. A crypto plugin directly to filesystems would certainly
> avoid most of it.

I'm currently in the situation where I need to mount an encrypted file
system over NFS (on a slow link), and the performance considerations
pretty much rule out the loop approach. (Currently I'm using CFS
because I found no other choice[1], but it is another loop approach -
stacking one NFS on top of another NFS - and that makes it painfully
slow too.)

The theoretically best solution is TCFS (www.tcfs.it), which builds
encryption into the NFS client alone, but it is not available for
anything newer than Linux 2.2.16.

Olaf

[1] Esp. if the requirement is that it can survive a kernel upgrade.
