Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262316AbRE0VYK>; Sun, 27 May 2001 17:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262334AbRE0VYA>; Sun, 27 May 2001 17:24:00 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26894 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262320AbRE0VXu>; Sun, 27 May 2001 17:23:50 -0400
Subject: Re: 2.4.5-ac1 won't boot with 4GB bigmem option
To: bentw@chello.nl (Ben Twijnstra)
Date: Sun, 27 May 2001 22:21:37 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01052722010200.01106@beastie> from "Ben Twijnstra" at May 27, 2001 10:01:02 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1547yj-0002Mb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I compiled and booted the 2.4.5-ac1 kernel with the CONFIG_HIGHMEM4G=y option 
> and got an oops in __alloc_pages() (called by alloc_bounce() called by 
> schedule()). Everything works fine if I turn the 4GB mode off.
> Machine is a Dell Precision with 2 Xeons and 2GB of RAM.
> 
> 2.4.5 works fine with the 4GB. Any idea what changed between the two?

The -ac tree has some VM differences for bigmem that really need to be
cleaned up and/or removed now the Linus tree is looking solid. I'll probably
drop those diffs for -ac2 so that folks are working against one set of VM


