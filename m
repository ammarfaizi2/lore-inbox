Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbVIYFLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbVIYFLq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 01:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVIYFLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 01:11:46 -0400
Received: from xenotime.net ([66.160.160.81]:52173 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751081AbVIYFLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 01:11:45 -0400
Date: Sat, 24 Sep 2005 22:11:43 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: anup badhe <anup_223@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patching kgdb to linux
Message-Id: <20050924221143.73481ea8.rdunlap@xenotime.net>
In-Reply-To: <20050925035539.93945.qmail@web52407.mail.yahoo.com>
References: <20050925035539.93945.qmail@web52407.mail.yahoo.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2005 20:55:39 -0700 (PDT) anup badhe wrote:

> i am trying to debug the linux kernel 2.6.10 using
> kgdb.i have downloaded the kgdb patch 2.6.10-mm2.bz2.
> after bunzip2 it gives me the file 2.6.10-mm2.
> 
> problem:
> 1- which type of file is this?

It's a diff; apply it using 'patch'.

> 2- what patch command should i use(the options) so
> that i can patch it to linux 2.6.10.?
> 3-i have used the following command and it gives me
> some errors:
> 
> root@localhost root]# patch -p1 <2.6.10-mm2
> can't find file to patch at input line 3
> Perhaps you used the wrong -p or --strip option?
> The text leading up to this
> was:--------------------------|---
> linux-2.6.10/arch/alpha/defconfig  2004-10-18
> 16:55:19.000000000 -0700
> |+++ 25/arch/alpha/defconfig    2005-01-05
> 23:22:42.000000000 -0800
> --------------------------
> File to patch:

$ cd linux-2.6.10
$ patch -p1 -b < /path/to/2.6.10-mm2  # wherever you put it
$ make *config


---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
