Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262264AbTCWDxz>; Sat, 22 Mar 2003 22:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262271AbTCWDxz>; Sat, 22 Mar 2003 22:53:55 -0500
Received: from packet.digeo.com ([12.110.80.53]:1519 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262264AbTCWDxy>;
	Sat, 22 Mar 2003 22:53:54 -0500
Date: Sat, 22 Mar 2003 20:04:55 -0800
From: Andrew Morton <akpm@digeo.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: smp overhead, and rwlocks considered harmful
Message-Id: <20030322200455.683ef46d.akpm@digeo.com>
In-Reply-To: <20030323035523.GF5981@krispykreme>
References: <20030322175816.225a1f23.akpm@digeo.com>
	<20030323035523.GF5981@krispykreme>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Mar 2003 04:04:52.0929 (UTC) FILETIME=[5B4C0B10:01C2F0F1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
>  
> > One thing is noteworthy: ia32's read_unlock() is buslocked, whereas
> > spin_unlock() is not.  
> 
> Dont forget bitops/atomics used as spinlocks like the rmap pte chain lock.
> 

Did you end up deciding it was worthwhile putting a spinlock in the ppc64
pageframe for that?  Or hashing for it.

