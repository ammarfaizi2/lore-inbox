Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261978AbSKCPGb>; Sun, 3 Nov 2002 10:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262003AbSKCPGb>; Sun, 3 Nov 2002 10:06:31 -0500
Received: from quechua.inka.de ([193.197.184.2]:4567 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S261978AbSKCPGa>;
	Sun, 3 Nov 2002 10:06:30 -0500
From: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <Pine.GSO.4.21.0211022114280.25010-100000@steklov.math.psu.edu>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E188MQx-0006ww-00@sites.inka.de>
Date: Sun, 3 Nov 2002 16:13:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.21.0211022114280.25010-100000@steklov.math.psu.edu> you wrote:
>        <shrug> that can be done without doing anything to filesystem.
> Namely, turn current "nosuid" of vfsmount into a mask of capabilities.
> Then use bindings instead of links.  *Note* - binary _is_ marked suid,
> mask tells which capabilities _not_ to gain.

the suid bit is important, I agree. this will make most security checks not
fail. Problem: runtime checks depend on euid. PErhaps we should even return
a different effective uid (or 0?) if a program is runnign with increased
capabilities?

Greetings
Bernd
