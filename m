Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270021AbTGLWmq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 18:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270022AbTGLWmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 18:42:46 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:27871 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270021AbTGLWmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 18:42:44 -0400
Date: Sun, 13 Jul 2003 00:56:14 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030712225614.GC1508@elf.ucw.cz>
References: <1057963547.3207.22.camel@laptop-linux> <20030712140057.GC284@elf.ucw.cz> <1058021722.1687.16.camel@laptop-linux> <20030712153719.GA206@elf.ucw.cz> <1058041211.2007.1.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058041211.2007.1.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Okay, that's sane approach to do it... But where do you store pointer
> > to pagedir?
> 
> I didn't answer this before. Sorry. Initially, you would still be
> expected to have a suspend partition, and hence it would still go in the
> header. Longer term, I'll have to learn more and see if there's a place
> we can use in the partition table or such like.

This needs to be thought out. Partition table is out of question
because you kill the whole system if you get interrupted during
partition table write.

First few KB of each ext2 filesystem are available, but I do not think
we want to introduce such hacks.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
