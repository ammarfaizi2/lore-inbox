Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261444AbRERS6b>; Fri, 18 May 2001 14:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261453AbRERS6V>; Fri, 18 May 2001 14:58:21 -0400
Received: from dl0td.afthd.tu-darmstadt.de ([130.83.113.30]:19204 "EHLO
	dl0td.afthd.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id <S261444AbRERS6G>; Fri, 18 May 2001 14:58:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jens David <dg1kjd@afthd.tu-darmstadt.de>
Organization: AFTHD
To: Santiago Garcia Mantinan <manty@udc.es>
Subject: Re: 8139too on 2.2.19 doesn't close file descriptors
Date: Thu, 3 Aug 2000 03:38:51 +0100
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010518000450.A3755@man.beta.es>
In-Reply-To: <20010518000450.A3755@man.beta.es>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <00080303385100.01193@dg1kjd.ampr.org>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 17 May 2001 23:04, you wrote:
> Hi!
>
> I was tracking down a problem with Debian installation freezing when doing
> the ifconfig of the 8139too driver on 2.2.19 kernel, and found that this
> was caused by 8139too for 2.2.19 not closing it's file descriptors.
>
> The original code by Jeff for the 2.4 series is ok, and searching for the
> cause of the problem I have found a difference in the way rtl8139_thread
> exits on both versions:
>
> 2.2 version:
>         up (&tp->thr_exited);
>         return 0;
>
> 2.4 version:
>         up_and_exit (&tp->thr_exited, 0);
>
> I think the problem must be there, not doing the do_exit on the 2.2
> version, but I may be wrong, can anybody look this up?

I added the exit_files(current) to the version in my source repository. Will 
be contained in the next releases. Thanks!
Btw.: CC'ing me was a good idea, I'm not on linux-kernel, only on linux-net
due to mail volume.

  -- Jens
