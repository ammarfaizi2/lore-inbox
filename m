Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273713AbSISW71>; Thu, 19 Sep 2002 18:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273730AbSISW70>; Thu, 19 Sep 2002 18:59:26 -0400
Received: from packet.digeo.com ([12.110.80.53]:31400 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S273713AbSISW70>;
	Thu, 19 Sep 2002 18:59:26 -0400
Message-ID: <3D8A57F8.AFC627AD@digeo.com>
Date: Thu, 19 Sep 2002 16:04:24 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext3 fs: no userspace writes == no disk writes ?
References: <20020920003058.A4850@verdi.et.tudelft.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2002 23:04:24.0588 (UTC) FILETIME=[E58F84C0:01C26030]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob van Nieuwkerk wrote:
> 
> Hi all,
> 
> I have a question about ext3 write activity.
> 
> I am considering using an ext3 fs on a CompactFlash disk for my
> data-logging application (power can disapear anytime).
> The quantity & frequency of the data logged itself is not a
> problem at all considering flash wear.
> 
> But I'm a bit worried about the kernel/ext3 doing regular writes
> by itself even when there are no userspace writes.  (worries are
> partially caused by memories from long time ago about idle laptop
> doing regular writes on disk).

Should be OK - it's a matter of careful monitoring and
tuning of system activity.

There are frequently written areas of an ext3 filesystem - the
journal, the superblock.  Those would wear out pretty quickly.

Increasing the commit interval to the maximum acceptable time
would reduce some of this wear and tear.

There seems to be some interest in doing this.  Might be helpful
to ask on ext3-users: https://listman.redhat.com/mailman/listinfo/ext3-users
