Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262182AbSIZEdC>; Thu, 26 Sep 2002 00:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262183AbSIZEdB>; Thu, 26 Sep 2002 00:33:01 -0400
Received: from packet.digeo.com ([12.110.80.53]:59352 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262182AbSIZEcF>;
	Thu, 26 Sep 2002 00:32:05 -0400
Message-ID: <3D928EFB.8EA00EB2@digeo.com>
Date: Wed, 25 Sep 2002 21:37:15 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 4/4] increase traffic on linux-kernel
References: <3D928864.23666D93@digeo.com> <20020926043208.GD1790@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2002 04:37:16.0021 (UTC) FILETIME=[63F0DA50:01C26516]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> On Wed, Sep 25, 2002 at 09:09:08PM -0700, Andrew Morton wrote:
> >
> > Infrastructure to detect sleep-inside-spinlock bugs.  Really only
> > useful if compiled with CONFIG_PREEMPT=y.  It prints out a whiny
> > message and a stack backtrace if someone calls a function which might
> > sleep from within an atomic region.
> 
> Why not make this it's own config option, dependent on CONFIG_PREEMPT?
> 

With CONFIG_PREEMPT=n, it'll detect might-sleep-inside-interrupt bugs.

Some value there I guess.
