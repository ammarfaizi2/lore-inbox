Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319395AbSIFUxn>; Fri, 6 Sep 2002 16:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319392AbSIFUxW>; Fri, 6 Sep 2002 16:53:22 -0400
Received: from [195.39.17.254] ([195.39.17.254]:12160 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319395AbSIFUwT>;
	Fri, 6 Sep 2002 16:52:19 -0400
Date: Fri, 6 Sep 2002 10:04:06 +0000
From: Pavel Machek <pavel@suse.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Amos Waterland <apw@us.ibm.com>, pwaechtler@mac.com,
       golbi@mat.uni.torun.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] POSIX message queues
Message-ID: <20020906100406.C35@toy.ucw.cz>
References: <20020901015025.A10102@kvasir.austin.ibm.com> <Pine.LNX.4.44.0209041311550.4000-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.44.0209041311550.4000-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Sep 04, 2002 at 01:13:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > That is the fundamental problem with a userspace shared memory
> > implementation: write permissions on a message queue should grant
> > mq_send(), but write permissions on shared memory grant a lot more than
> > just that.
> 
> is it really a problem? As long as the read and write queues are separated
> per sender, all that can happen is that a sender is allowed to read his
> own messages - that is not an exciting capability.

Imagine something that writes data into the que then erases the data and
gets rid of setuid.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

