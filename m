Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276993AbRJCV0F>; Wed, 3 Oct 2001 17:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276991AbRJCVZz>; Wed, 3 Oct 2001 17:25:55 -0400
Received: from ns.suse.de ([213.95.15.193]:23818 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S276989AbRJCVZo>;
	Wed, 3 Oct 2001 17:25:44 -0400
Date: Wed, 3 Oct 2001 23:26:09 +0200
From: Andi Kleen <ak@suse.de>
To: Alex Larsson <alexl@redhat.com>
Cc: Ulrich Drepper <drepper@cygnus.com>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Finegrained a/c/mtime was Re: Directory notification problem
Message-ID: <20011003232609.A11804@gruyere.muc.suse.de>
In-Reply-To: <m3r8slywp0.fsf@myware.mynet> <Pine.LNX.4.33.0110031111470.29619-100000@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0110031111470.29619-100000@devserv.devel.redhat.com>; from alexl@redhat.com on Wed, Oct 03, 2001 at 11:15:04AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2001 at 11:15:04AM -0400, Alex Larsson wrote:
> Is a nanoseconds field the right choice though? In reality you might not 
> have a nanosecond resolution timer, so you would miss changes that appear
> on shorter timescale than the timer resolution. Wouldn't a generation 
> counter, increased when ctime was updated, be a better solution?

Near any CPU has a cycle counter builtin now, which gives you ns like
resolution. In theory you could still get collisions on MP systems, 
but window is small enough that it can be ignored in practice.

-Andi
