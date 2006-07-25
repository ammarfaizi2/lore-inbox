Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWGYRr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWGYRr7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 13:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWGYRr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 13:47:59 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:453 "EHLO
	out.lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750806AbWGYRr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 13:47:59 -0400
Subject: Re: utrace vs. ptrace
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Albert Cahalan <acahalan@gmail.com>, arjan@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0607131203450.5623@g5.osdl.org>
References: <787b0d920607122243g24f5a003p1f004c9a1779f75c@mail.gmail.com>
	 <200607131437.28727.ak@suse.de> <20060713124316.GA18852@elte.hu>
	 <200607131521.52505.ak@suse.de>
	 <Pine.LNX.4.64.0607131203450.5623@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Jul 2006 19:49:02 +0100
Message-Id: <1153853342.4725.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-07-13 at 12:05 -0700, Linus Torvalds wrote:
> Doing core-dumping in user space would be insane. It doesn't give _any_ 
> advantages, only disadvantages.

It has a number of very real advantages in certain circumstances and the
only interface the kernel needs to provide is the debugger interface and
something to "kick" the debugger and reparent to it, or for that matter
it might even be viable just to pass the helper the fd of an anonymous
file holding the dump.

Taking out the kernel core dump support would be insane.

We get customers who like to collect/process/do clever stuff with core
dumps and failure cases. We also get people who want to dump a core that
excludes the 14GB shared mmap of the database file as another example
where it helps.

Alan

