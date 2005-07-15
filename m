Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVGOTDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVGOTDz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 15:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVGOTDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 15:03:54 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:9186 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261667AbVGOTCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 15:02:40 -0400
Date: Fri, 15 Jul 2005 21:02:03 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Andrew Morton <akpm@osdl.org>, Jan Blunck <j.blunck@tu-harburg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic_file_sendpage
In-Reply-To: <Pine.LNX.4.58.0507150904110.19183@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0507152100280.12882@yvahk01.tjqt.qr>
References: <42D79468.3050808@tu-harburg.de> <20050715040611.05907f4a.akpm@osdl.org>
 <20050715112255.GC2721@wohnheim.fh-wedel.de> <Pine.LNX.4.61.0507151511220.21786@yvahk01.tjqt.qr>
 <Pine.LNX.4.58.0507150904110.19183@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >With union mount and cowlink, there are two users already.  cp(1)
>> >could use it as well, even if the improvement is quite minimal.
>> 
>> FTP PUT could use this too - ...
>
>No, FTP PUT _cannot_ use it, exactly because sendfile() can't do anything 
>but file sources (and not even all file sources - it can only do regular 
>filesystems that use the page cache).
>
>This is why I want to get rid of sendfile(). It's a fundamentally broken
>interface. Really. In contrast, the pipe buffers _can_ be used for direct
>socket->file interfaces.

How will userspace access these pipe buffers?



Jan Engelhardt
-- 
