Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317458AbSGTSWa>; Sat, 20 Jul 2002 14:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317462AbSGTSWa>; Sat, 20 Jul 2002 14:22:30 -0400
Received: from quechua.inka.de ([212.227.14.2]:13676 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S317458AbSGTSW3>;
	Sat, 20 Jul 2002 14:22:29 -0400
From: Bernd Eckenfels <ecki-news2002-06@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: close return value
In-Reply-To: <000e01c22f5c$dce9c600$da5b903f@starbak.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17Vyv9-00060R-00@sites.inka.de>
Date: Sat, 20 Jul 2002 20:25:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <000e01c22f5c$dce9c600$da5b903f@starbak.net> you wrote:
> It's an issue when it MIGHT be important.  Such as, fprintf to an important
> data file should be checked, fprintf to stderr is usually cool not to check.

well, writing to stdout/stderr can fail with a normal IO Error. It depends
on what kind of data you actually output. If it is a log message and you are
sure you do not need intact audit trails you might ignore it. If you write a
pipe tool (e.g. sort) you better check that write state and terminate.

Greetings
Bernd
yy
