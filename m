Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288578AbSANBau>; Sun, 13 Jan 2002 20:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288582AbSANBak>; Sun, 13 Jan 2002 20:30:40 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:60689 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S288578AbSANBag>;
	Sun, 13 Jan 2002 20:30:36 -0500
Date: Sun, 13 Jan 2002 18:14:53 -0700
From: yodaiken@fsmlabs.com
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020113181453.A18218@hq.fsmlabs.com>
In-Reply-To: <20020108142117.F3221@inspiron.school.suse.de> <Pine.LNX.3.96.1020113193700.17441G-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.3.96.1020113193700.17441G-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Sun, Jan 13, 2002 at 07:46:54PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2002 at 07:46:54PM -0500, Bill Davidsen wrote:
> Finally, I doubt that any of this will address my biggest problem with
> Linux, which is that as memory gets cheap a program doing significant disk
> writing can get buffers VERY full (perhaps a while CD worth) before the
> kernel decides to do the write, at which point the system becomes
> non-responsive for seconds at a time while the disk light comes on and
> stays on. That's another problem, and I did play with some patches this
> weekend without making myself really happy :-( Another topic,
> unfortunately.

I think this is a critical problem. I'd like to be able to have some
assurance that a task with a buffer of size N doing read-disk->write-disk
will maintain data flow at some minimal rate over intervals of 1 or 2
seconds or something like that.

