Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130696AbQKQMIY>; Fri, 17 Nov 2000 07:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132001AbQKQMIP>; Fri, 17 Nov 2000 07:08:15 -0500
Received: from ns.caldera.de ([212.34.180.1]:34321 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130696AbQKQMIK>;
	Fri, 17 Nov 2000 07:08:10 -0500
Date: Fri, 17 Nov 2000 12:37:32 +0100
Message-Id: <200011171137.MAA12632@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: mh15@st-andrews.ac.uk (Mark Hindley)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALS-110 opl3 and mpu401 under 2.4.0-test10
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <l03130300b63ac27dc63a@[138.251.135.28]>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2) The other relates to the uart401 detection. If you build the sb driver
> into the kernel and then pass the commandline uart401=1 this is interpreted
> as the io parameter for the uart401 module not a command for the sb driver.

Of course.  Module parameters are _not_ relevant for builtin drivers.
You have given a command line to the uart401 driver ...

> 
> I have renamed the uart401 detection command to uart401probe. Obviously it
> isn't a problem with a modular driver, but the change shouldn't matter.

That's the wrong fix...
Please look at the __setup call in the sb driver.

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
