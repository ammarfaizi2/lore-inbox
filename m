Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262976AbTCNMEX>; Fri, 14 Mar 2003 07:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262988AbTCNMEX>; Fri, 14 Mar 2003 07:04:23 -0500
Received: from packet.digeo.com ([12.110.80.53]:33779 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262976AbTCNMEW>;
	Fri, 14 Mar 2003 07:04:22 -0500
Date: Fri, 14 Mar 2003 04:14:56 -0800
From: Andrew Morton <akpm@digeo.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.64-mm6
Message-Id: <20030314041456.7ee6b710.akpm@digeo.com>
In-Reply-To: <3E71C47F.1050205@aitel.hist.no>
References: <20030313032615.7ca491d6.akpm@digeo.com>
	<3E71C47F.1050205@aitel.hist.no>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Mar 2003 12:14:56.0733 (UTC) FILETIME=[539CB8D0:01C2EA23]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> wrote:
>
> Andrew Morton wrote:
> >   This might cause weird thing to happen, especially on small-memory machines.
> 
> Weird things happened.
> mm1 (and mm2 on smp) have been running very fine for me. So I decided to 
> try mm6 on UP.  The machine have 512M, and uses soft raid-1 on /  The
> rest is plain ide disk partitions, all using ext2.
> 
> It booted fine.
> I fired up openoffice, a 2x-3x speedup ought to be noticeable.
> It didn't start, but got stuck with the annoying on-top-of-everything 
> splash screen showing.  ps aux showed lpd in D state - perhaps
> oo queries lpd.  I also tried mozilla, and it got stuck in D state too.
> Openoffice was only in sleep so I killed it.  Mozilla was unkillable
> as expected from the D state.

The elevator bug.  I'll make deadline the deefault until we get this sorted.
Booting with "elevator=deadline" should be OK.
