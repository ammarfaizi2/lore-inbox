Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132895AbREFF3Y>; Sun, 6 May 2001 01:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132898AbREFF3O>; Sun, 6 May 2001 01:29:14 -0400
Received: from smarty.smart.net ([207.176.80.102]:26121 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S132895AbREFF3B>;
	Sun, 6 May 2001 01:29:01 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200105060357.XAA29873@smarty.smart.net>
Subject: Re: inserting a Forth-like language into the Linux kernel
To: linux-kernel@vger.kernel.org
Date: Sat, 5 May 2001 23:57:01 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kspamd/H3sm is now making continuous writes to tty1 from an 
in-kernel thread. It was locking on a write to /dev/console by
init, so I made /dev/console a plain file. This is after 
hollowing out sys_syslog to be a null routine, and various 
other minor destruction.

I am now typing at you on tty4 or so while the kernel itself 
sends an endless stream of d's to tty1. It will scroll-lock 
and un-scroll-lock, which is how I can tell it's not just a 
static screen of d's.

I don't know about H1 S&M, but the ability to open a tty
normally directly into kernelspace may prove popular, particularly 
with a Forth on that tty in that kernelspace. Persons with actual 
kernel clue may want to look at allowing /dev/console users and 
an in-kernel tty user to play nice. For my purposes I'll do without 
a real /dev/console and syslogging for now. 

Now I get to find out how many worlds of trouble I didn't foresee
in _reading_ a tty from the kernel :o)

If someone knows of another example of interpreter-like behavior 
directly in a unix in-kernel thread I'd like to know about it.  

Rick Hohensee
www.clienux.com
The userland H3sm is in 
ftp://ftp.gwdg.de/pub/linux/include/clienux/interim
