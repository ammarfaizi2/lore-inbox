Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277533AbRJJXma>; Wed, 10 Oct 2001 19:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277540AbRJJXmU>; Wed, 10 Oct 2001 19:42:20 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:37640 "EHLO
	mail12.speakeasy.net") by vger.kernel.org with ESMTP
	id <S277533AbRJJXmB>; Wed, 10 Oct 2001 19:42:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Date: Wed, 10 Oct 2001 19:42:31 -0400
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>,
        Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200110100358.NAA17519@isis.its.uow.edu.au> <20011010120009.851921E7C9@Cantor.suse.de> <20011010153653.Q726@athlon.random>
In-Reply-To: <20011010153653.Q726@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011010234211Z277533-761+17907@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 October 2001 09:36, Andrea Arcangeli wrote:
> On Wed, Oct 10, 2001 at 08:00:04AM -0400, safemode wrote:
> > OK, i copied the mp3 into /dev/shm and without any renicing of anything
> > it plays fine during dbench 32.  so the problem is disk access taking too
> > long.
> >
> > Which is strange since i'm running dbench on a separate hdd on a totally
> > different controller.
>
> then if you know it's not disk congestion, it's most probably due the vm
> write throttling.
>
> Andrea

How is it that a process at the same priority as allowed to throttle the 
kernel's vm and starve other processes at the same priority.  That sounds 
like dbench is being allowed to preempt other processes at the same priority. 
 even if it is indirect preemption. The effect is the same. 
