Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276749AbRJCIHS>; Wed, 3 Oct 2001 04:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276794AbRJCIG7>; Wed, 3 Oct 2001 04:06:59 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:56454 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S276749AbRJCIGs>;
	Wed, 3 Oct 2001 04:06:48 -0400
To: Andi Kleen <ak@suse.de>
Cc: Alex Larsson <alexl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Finegrained a/c/mtime was Re: Directory notification problem
In-Reply-To: <Pine.LNX.4.33.0110022206100.29931-100000@devserv.devel.redhat.com.suse.lists.linux.kernel>
	<oupitdx9n2m.fsf@pigdrop.muc.suse.de>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 03 Oct 2001 01:06:19 -0700
In-Reply-To: Andi Kleen's message of "03 Oct 2001 09:53:21 +0200"
Message-ID: <m3r8slywp0.fsf@myware.mynet>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> For stat is also requires a changed glibc ABI -- the glibc/2.4 stat64

Not only stat64, also plain stat.

> structure reserved an additional 4 bytes for every timestamp, but these
> either need to be used to give more seconds for the year 2038 problem
> or be used for the ms fractions. y2038 is somewhat important too.

The fields are meant for nanoseconds.  The y2038 will definitely be
solved by time-shifting or making time_t unsigned.  In any way nothing
of importance here and now.  Especially since there won't be many
systems which are running today and which have a 32-bit time_t be used
then.  For the rest I'm sure that in 37 years there will be the one or
the other ABI change.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
