Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277372AbRJENLa>; Fri, 5 Oct 2001 09:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277373AbRJENLU>; Fri, 5 Oct 2001 09:11:20 -0400
Received: from chmls16.mediaone.net ([24.147.1.151]:56483 "EHLO
	chmls16.mediaone.net") by vger.kernel.org with ESMTP
	id <S277372AbRJENLC>; Fri, 5 Oct 2001 09:11:02 -0400
From: andrew@pimlott.ne.mediaone.net (Andrew Pimlott)
Date: Fri, 5 Oct 2001 08:59:35 -0400
To: Padraig Brady <padraig@antefacto.com>
Cc: Andi Kleen <ak@suse.de>, Alex Larsson <alexl@redhat.com>,
        Ulrich Drepper <drepper@cygnus.com>, linux-kernel@vger.kernel.org
Subject: Re: Finegrained a/c/mtime was Re: Directory notification problem
Message-ID: <20011005085935.A1902@pimlott.ne.mediaone.net>
Mail-Followup-To: Padraig Brady <padraig@antefacto.com>,
	Andi Kleen <ak@suse.de>, Alex Larsson <alexl@redhat.com>,
	Ulrich Drepper <drepper@cygnus.com>, linux-kernel@vger.kernel.org
In-Reply-To: <m3r8slywp0.fsf@myware.mynet> <Pine.LNX.4.33.0110031111470.29619-100000@devserv.devel.redhat.com> <20011003232609.A11804@gruyere.muc.suse.de> <3BBDAB24.7000909@antefacto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3BBDAB24.7000909@antefacto.com>; from padraig@antefacto.com on Fri, Oct 05, 2001 at 01:44:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 01:44:20PM +0100, Padraig Brady wrote:
> But the point is you, only ever would want nano second resolution to make
> sure you notice all changes to a file. A more general (and much simpler)
> solution would be to gen_count++ every time a file's modified. What other
> applications would require better than second resolution on files?

Correlating file timestamps with an event log.  Comparing timestamps
on different files (make).  Real time is _much_ more useful (not to
mention convenient) than a generation count; and given that we've
survived with second resolution so far, I think the hypothetical
collisions on a nanosecond scale are ignorable.

Andrew
