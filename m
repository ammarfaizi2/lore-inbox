Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262076AbSJZK0Z>; Sat, 26 Oct 2002 06:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262042AbSJZKYm>; Sat, 26 Oct 2002 06:24:42 -0400
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:28940 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262061AbSJZKYB>; Sat, 26 Oct 2002 06:24:01 -0400
X-Envelope-From: pavel@bug.ucw.cz
Date: Sun, 20 Oct 2002 16:18:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Neil Schemenauer <nas@python.ca>
Cc: swan@shockfrosted.org, linux-kernel@vger.kernel.org
Subject: Re: Posix capabilities
Message-ID: <20021020141806.GC6280@elf.ucw.cz>
References: <20021017204317.GA4286@glacier.arctrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017204317.GA4286@glacier.arctrix.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> See my "capwrap" module:
> 
>     http://arctrix.com/nas/linux/capwrap.tar.gz
> 
> To allow SCHED_FIFO you would need to give the process the CAP_SYS_NICE
> capability.  CAP_SYS_NICE is bit 23 (800000 in hex).  Create a text file
> with the following line and make it root suid:
> 
>     &/usr/bin/someprogram 800000
> 
> If the capwrap module is loaded the kernel will recognize the file as a
> "capability wrapper" and grant the specified capabilities to the
> executable while running with the uid of the current user.
> 
> The capwrap module isn't fancy but is works and is simple.  It doesn't
> require any special filesystem.  Since I'm no kernel hacker I don't know
> if it's suitable for inclusion in the main tree.  I would appreciate any
> comments people have regarding it.

I did similar thing using elf .note section... But this seems elegant
too. Perhaps you want to push it for inclusion?
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
