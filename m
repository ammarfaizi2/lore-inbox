Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVLUMMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVLUMMS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 07:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVLUMMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 07:12:18 -0500
Received: from wine.ocn.ne.jp ([220.111.47.146]:8440 "EHLO smtp.wine.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S932387AbVLUMMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 07:12:18 -0500
To: arjan@infradead.org
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: [RFC] TOMOYO Linux released!
From: Tetsuo Handa <from-kernelnewbies@i-love.sakura.ne.jp>
References: <200512212020.FBF94703.XOTMFStFPCJNSFLFOG@I-love.SAKURA.ne.jp>
	<1135164793.3456.9.camel@laptopd505.fenrus.org>
In-Reply-To: <1135164793.3456.9.camel@laptopd505.fenrus.org>
Message-Id: <200512212112.HBH59669.FCNLMTFJFFSSPGtOOX@i-love.sakura.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Wed, 21 Dec 2005 21:12:17 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Arjan van de Ven wrote:
> > A new and easy to master access control for Linux,
> > TOMOYO Linux, is now available.
> very interesting; a few quick questions that I didn't see answered on
> the side
Thank you for your interest.

> 1) where can we download the patches?
You can download from http://sourceforge.jp/projects/tomoyo/ .
Click the links "Download" in the middle of the page.
The ccs-patch is the kernel patch and the ccs-tools is the userland
utilities such as policy editors.

The documentation index page is http://tomoyo.sourceforge.jp/en/doc/ .
The complete installation guide is at
http://tomoyo.sourceforge.jp/en/doc/install.html .
The kickstart installation guide will be added in a several days.

> 2) How does the use of "absolute paths" interact with namespaces?
>    In principle each process can have its own namespace after all!
>    (not many distributions use this today, but that will change soon,
>    per user /tmp is a very attractive feature and all needed
>    infrastructure helpers for this will be in the 2.6.15 kernel)
This is like d_path(), expect that TOMOYO Linux ignores
each process's root directory. TOMOYO Linux uses global namespace.
For example, if a process accesses to /foo/bar which has already
chroot'ed to /jail directory, then TOMOYO Linux regards
as if the process is accessing to /jail/foo/bar .
You can find some example policies at
http://tomoyo.sourceforge.jp/example_policy/ .
You can feel the image of realpath()-based policy files.

Regards...
