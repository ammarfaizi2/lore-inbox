Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317648AbSHYX22>; Sun, 25 Aug 2002 19:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317661AbSHYX22>; Sun, 25 Aug 2002 19:28:28 -0400
Received: from chiark.greenend.org.uk ([212.135.138.206]:59400 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S317648AbSHYX22>; Sun, 25 Aug 2002 19:28:28 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: drivers/block/paride/pd.c vs. generic IDE code
Newsgroups: chiark.mail.linux-rutgers.kernel
In-Reply-To: <200208241032.g7OAWOoS006611@mail.mplayerhq.hu>
Organization: Linux Unlimited
Message-Id: <E17j6s7-0004b3-00@chiark.greenend.org.uk>
From: Jonathan Amery <jdamery@chiark.greenend.org.uk>
Date: Mon, 26 Aug 2002 00:32:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200208241032.g7OAWOoS006611@mail.mplayerhq.hu> you write:
>Hi,
>
>I've recently bought an parallel-to-ide interface, and after some kernel
>hacking to get it work i found several problems with the currect (2.4.19)
>paride interface. Actually the files drivers/block/paride/p?.c and pcd.c
>are stripped down ide interface code (duplicate of the generic ide code at
>drivers/ide/*)
>
>As you're on changing/redesigning the IDE code of the 2.5 tree, I would
>consider taking a look at the paride interface and include it into the new
>generic IDE code.
>
>Current problems/limitations of paride code:
>- no support for LBA (>32GB) or big (>128GB) disks
>  (i've hacked LBA support into pd.c to get my 40G hdd work - i'll prepare a
>   patch when i'm statisfied with testing results)

 There appears to be LBA support in 2.5 nowadays - I've backported the
patch (which appears to be working - no guarrentees though!).

 http://www.chiark.greenend.org.uk/~jdamery/pd.lba.patch

 J.
