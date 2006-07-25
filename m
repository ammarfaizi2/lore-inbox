Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWGYS5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWGYS5z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWGYS5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:57:55 -0400
Received: from ns2.suse.de ([195.135.220.15]:37810 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932371AbWGYS5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:57:54 -0400
Date: Tue, 25 Jul 2006 20:57:44 +0200
From: Olaf Hering <olh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>, Albert Cahalan <acahalan@gmail.com>,
       arjan@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>
Subject: Re: utrace vs. ptrace
Message-ID: <20060725185744.GA15844@suse.de>
References: <787b0d920607122243g24f5a003p1f004c9a1779f75c@mail.gmail.com> <200607131437.28727.ak@suse.de> <20060713124316.GA18852@elte.hu> <200607131521.52505.ak@suse.de> <Pine.LNX.4.64.0607131203450.5623@g5.osdl.org> <1153853342.4725.21.camel@localhost> <Pine.LNX.4.64.0607251124080.29649@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607251124080.29649@g5.osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jul 25, Linus Torvalds wrote:

> What you often want is not a core-dump at all, but a "stop the process" 
> thing. It's really irritating that the core-dump is generated and the 
> process is gone, when it would often be a lot nicer if instead of 
> core-dumping, the process was just stopped and then you could attach to it 
> with gdb, and get the whole damn information (including things like access 
> to open file descriptors etc).
> 
> But again, that has nothing to do with core-dumping. 

It would be helpful to have that sort of functionality in mainline.
Would a patch be acceptable that sends SIGSTOP instead of SIGSEGV or
SIGILL if some knob was enabled, either global or per process?
