Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263772AbREYPnI>; Fri, 25 May 2001 11:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263773AbREYPm6>; Fri, 25 May 2001 11:42:58 -0400
Received: from voyager.powersurfr.com ([24.109.67.8]:43538 "EHLO
	unity.starfire") by vger.kernel.org with ESMTP id <S263772AbREYPmv>;
	Fri, 25 May 2001 11:42:51 -0400
From: Maciek Nowacki <maciek@Voyager.powersurfr.com>
Date: Fri, 25 May 2001 09:42:45 -0600
To: Scott Murray <scott@spiteful.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Busy on BLKFLSBUF w/initrd
Message-ID: <20010525094245.A858@wintermute.starfire>
In-Reply-To: <20010524123943.A797@wintermute.starfire> <Pine.LNX.4.33.0105250040520.15501-100000@godzilla.spiteful.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.33.0105250040520.15501-100000@godzilla.spiteful.org>; from scott@spiteful.org on Fri, May 25, 2001 at 01:20:00AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 01:20:00AM -0400, Scott Murray wrote:
> On Thu, 24 May 2001, Maciek Nowacki wrote:
> 
> > This method depends on the change_root() mechanism which I had assumed is
> > becoming obsolete. It works, and there is no need to mess with
> > /proc/sys/kernel/real_root_dev if the root is specified on the command line.
> > Trying to use only pivot_root did not work as /dev/rd/0 could never be
> > flushed (see previous messages in this thread).
> 
> I was having similiar problems a few months back.  I was also trying
> to pivot_root out of an initial ramdisk and then unmount it.  I got it
> working, but kept forgetting to post one of the fixes that I found
> necessary to make it work when using auto-mounted devfs.
>
> [patch to init/main.c]

Cool, that did it. change_root doesn't occur anymore and BLKFLSBUF clears
things out of memory without any muckage. I will add this one to my patch
directory. Thanks!

Maciek
