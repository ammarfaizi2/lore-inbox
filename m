Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293672AbSCKK0E>; Mon, 11 Mar 2002 05:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293673AbSCKKZv>; Mon, 11 Mar 2002 05:25:51 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:29706 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293672AbSCKKZh>; Mon, 11 Mar 2002 05:25:37 -0500
Date: Mon, 11 Mar 2002 11:26:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Oskar Liljeblad <oskar@osk.mine.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: directory notifications lost after fork?
Message-ID: <20020311112652.E10413@dualathlon.random>
In-Reply-To: <20020310210802.GA1695@oskar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020310210802.GA1695@oskar>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2002 at 10:08:02PM +0100, Oskar Liljeblad wrote:
> The code snipper demonstrates what I consider a bug in the
> dnotify facilities in the kernel. After a fork, all registered
> notifications are lost in the process where they originally
> where registered (the parent process). "lost" here means that
> the signal specified with F_SETSIG fcntl no longer is delivered
> when notified.
> 
> How to reproduce (tested with 2.4.17):
>   gcc -o dnoticebug dnoticebug.c
>   dnoticebug &				# run in background
>   cat dnoticebug.c >/dev/null		# "notified" should now be printed
>   cat dnoticebug.c >/dev/null		# nothing is printed this time
>   
> If you comment out the line with fork below, "notified" *will* be
> printed every time you cat dnoticebug.c.
> 
> I'm not subscribed to the list so I'd appreciate if you CCed me.
> (Otherwise I'd have to use the archives :) Thanks.

this should fix your problem:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre2aa2/00_dnotify-fl_owner-1

Andrea
