Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284497AbRLERAY>; Wed, 5 Dec 2001 12:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284498AbRLERAP>; Wed, 5 Dec 2001 12:00:15 -0500
Received: from t2.redhat.com ([199.183.24.243]:59638 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S284497AbRLEQ76>;
	Wed, 5 Dec 2001 11:59:58 -0500
Date: Wed, 5 Dec 2001 08:58:08 -0800
From: Richard Henderson <rth@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, schwab@suse.de, linux-ia64@linuxia64.org,
        marcelo@conectiva.com.br, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: alpha bug in signal handling
Message-ID: <20011205085808.A8634@redhat.com>
In-Reply-To: <20011204171426.B7982@redhat.com> <15373.33622.236872.92057@napali.hpl.hp.com> <20011204190048.B8179@redhat.com> <20011205.032304.102576056.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011205.032304.102576056.davem@redhat.com>; from davem@redhat.com on Wed, Dec 05, 2001 at 03:23:04AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 03:23:04AM -0800, David S. Miller wrote:
> I don't understand why this is even necessary.
> 
> What if the interrupt comes in on another processor.  How does this
> return from trap behavior avoid that interrupt modifying the signal
> and/or scheduling state wrt. the current cpu's task?

It doesn't.  But it also prevents the IPI from being recognized
until we are back in userland.  Apparently DMT had a test case
that failed without disabling interrupts; I didn't see it myself.


r~
