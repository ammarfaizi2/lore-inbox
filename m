Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbTDLEuK (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 00:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbTDLEuK (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 00:50:10 -0400
Received: from [12.47.58.73] ([12.47.58.73]:45598 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263146AbTDLEuK (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 00:50:10 -0400
Date: Fri, 11 Apr 2003 22:01:58 -0700
From: Andrew Morton <akpm@digeo.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com, adilger@clusterfs.com
Subject: Re: 2.5.66: slow to friggin slow journal recover
Message-Id: <20030411220158.28f88097.akpm@digeo.com>
In-Reply-To: <20030412044840.GA455@zip.com.au>
References: <20030401100237.GA459@zip.com.au>
	<20030401022844.2dee1fe8.akpm@digeo.com>
	<20030412021638.GA650@zip.com.au>
	<20030411192413.279f0574.akpm@digeo.com>
	<20030412023848.GB650@zip.com.au>
	<20030411195308.11812ee9.akpm@digeo.com>
	<20030412044840.GA455@zip.com.au>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Apr 2003 05:01:47.0645 (UTC) FILETIME=[9EE35AD0:01C300B0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT <cat@zip.com.au> wrote:
>
> Do you still want the alt-sysrq-m stuff? And is there anything else I
> can do? profiling? apply a patch with debugging stuff that'd give you a
> clue? etc...

Can't think of a lot really.

Are you sure that fsck is only running journal recovery?  Is it possible that
it is performing a full fsck for some reason?

Make sure you're running current e2fsprogs?

Boot with `init=/bin/sh', run fsck by hand in the background, poke around
with `ps' to see what it's up to, etc.

