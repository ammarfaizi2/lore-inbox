Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbRGHRdN>; Sun, 8 Jul 2001 13:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266936AbRGHRdD>; Sun, 8 Jul 2001 13:33:03 -0400
Received: from [194.213.32.142] ([194.213.32.142]:18948 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266934AbRGHRcu>;
	Sun, 8 Jul 2001 13:32:50 -0400
Date: Sat, 30 Jun 2001 14:50:37 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: root@chaos.analogic.com,
        Schilling Richard <RSchilling@affiliatedhealth.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: For comment: draft BIOS use document for the kernel
Message-ID: <20010630145036.D255@toy.ucw.cz>
In-Reply-To: <Pine.LNX.3.95.1010622135228.3929C-100000@chaos.analogic.com> <E15DYhb-0004Ba-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E15DYhb-0004Ba-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jun 22, 2001 at 10:42:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Then how does 1.44 megabytes of data from a floppy disk (that won't
> > fit below 1 megabyte), that is accessed in real-mode, ever get to
> > above 1 megabyte where it can be decompressed?
> 
> The limit is about 508K of compressed image with the floppy boot.

Wrong. 0xeffff is limit for floppy boot. Kernel errorneously thinks it
is 0xfffff, and loops if it is 0xf????. We use int15 to copy it. Take a
look, there are ugly hacks around that.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

