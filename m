Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267890AbTCBKR1>; Sun, 2 Mar 2003 05:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269174AbTCBKR1>; Sun, 2 Mar 2003 05:17:27 -0500
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:11665 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S267890AbTCBKR0>; Sun, 2 Mar 2003 05:17:26 -0500
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200303021026.h22AQALn001315@wildsau.idv.uni.linz.at>
Subject: Re: emm386 hangs when booting from linux
In-Reply-To: <3E5FF7E4.FB290D8F@daimi.au.dk> from Kasper Dupont at "Mar 1, 3 00:59:32 am"
To: kasperd@daimi.au.dk (Kasper Dupont)
Date: Sun, 2 Mar 2003 11:26:10 +0100 (MET)
Cc: kernel@wildsau.idv.uni.linz.at, root@chaos.analogic.com,
       linux-kernel@vger.kernel.org, herp@wildsau.idv.uni.linz.at
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hello again,

I've still not found a solution, but at least I know what's happening
when emm386 or similar crash the system. e.g., when starting "loadlin"
(with no parameters!) the system will hang too. Reason is that loadlin
will generate an int 0x13, which is the general protection fault.
I wonder *why*. Well, the int 0x13 handler I wrote just writes
"int13" on top of the screen and does an iret, so the system will not
crash anymore, but of course, the programs wont work. Another
confusing thing I observed that even simply commands such as "copy <file1>
<file2>" cause an int13!? and that DOS will become unusable quite soon
(directories disappear and so on).

best regards,
herbert


