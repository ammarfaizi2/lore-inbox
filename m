Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276297AbRJCNps>; Wed, 3 Oct 2001 09:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276298AbRJCNpi>; Wed, 3 Oct 2001 09:45:38 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39208 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S276297AbRJCNpb>; Wed, 3 Oct 2001 09:45:31 -0400
To: drepper@cygnus.com (Ulrich Drepper)
Cc: Andi Kleen <ak@suse.de>, Alex Larsson <alexl@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Finegrained a/c/mtime was Re: Directory notification problem
In-Reply-To: <Pine.LNX.4.33.0110022206100.29931-100000@devserv.devel.redhat.com.suse.lists.linux.kernel>
	<oupitdx9n2m.fsf@pigdrop.muc.suse.de> <m3r8slywp0.fsf@myware.mynet>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Oct 2001 07:35:46 -0600
In-Reply-To: <m3r8slywp0.fsf@myware.mynet>
Message-ID: <m1k7yc3ky5.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> writes:

> Andi Kleen <ak@suse.de> writes:
> 
> > For stat is also requires a changed glibc ABI -- the glibc/2.4 stat64
> 
> Not only stat64, also plain stat.
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

Right.  Given current uptimes and being optimistic the fix for y2038 
is probably needed by 2030 or just a little later.  But in any case
64 bit systems should be maxing out by then, and the conversion to 128
bit systems should have already happened on the server side.  32 bit
systems will likely be limited to embedded and legacy systems by then.

Eric

