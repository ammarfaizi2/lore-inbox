Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276350AbRJCPPD>; Wed, 3 Oct 2001 11:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276351AbRJCPOx>; Wed, 3 Oct 2001 11:14:53 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:28658 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S276350AbRJCPOj>; Wed, 3 Oct 2001 11:14:39 -0400
Date: Wed, 3 Oct 2001 11:15:04 -0400 (EDT)
From: Alex Larsson <alexl@redhat.com>
X-X-Sender: <alexl@devserv.devel.redhat.com>
To: Ulrich Drepper <drepper@cygnus.com>
cc: Andi Kleen <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Finegrained a/c/mtime was Re: Directory notification problem
In-Reply-To: <m3r8slywp0.fsf@myware.mynet>
Message-ID: <Pine.LNX.4.33.0110031111470.29619-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Oct 2001, Ulrich Drepper wrote:

> Andi Kleen <ak@suse.de> writes:
> 
> > structure reserved an additional 4 bytes for every timestamp, but these
> > either need to be used to give more seconds for the year 2038 problem
> > or be used for the ms fractions. y2038 is somewhat important too.
> 
> The fields are meant for nanoseconds.  The y2038 will definitely be
> solved by time-shifting or making time_t unsigned.  In any way nothing
> of importance here and now.  Especially since there won't be many
> systems which are running today and which have a 32-bit time_t be used
> then.  For the rest I'm sure that in 37 years there will be the one or
> the other ABI change.

Is a nanoseconds field the right choice though? In reality you might not 
have a nanosecond resolution timer, so you would miss changes that appear
on shorter timescale than the timer resolution. Wouldn't a generation 
counter, increased when ctime was updated, be a better solution?

/ Alex


