Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262304AbSIZJyx>; Thu, 26 Sep 2002 05:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbSIZJyx>; Thu, 26 Sep 2002 05:54:53 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:42891 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S262304AbSIZJyw>; Thu, 26 Sep 2002 05:54:52 -0400
Date: Thu, 26 Sep 2002 12:59:57 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.22 on HP Vectra 90/5: Machine check exception on boot
Message-ID: <20020926095957.GC42048@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <20020925145544.GM41965@niksula.cs.hut.fi> <200209260949.g8Q9nY926516@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209260949.g8Q9nY926516@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 05:49:33AM -0400, you [Alan Cox] wrote:
> > CPU0 Machine check exception 0x  10E2C0 (type 0x    09)
> > 2.0.35 does boot just fine.
> 
> MCE comes from the hardware not the OS. You may have another odd box like
> the compaq ones where it seems the external mce trigger isnt wired properly.
> If so boot with "nomce"

(It's actually Vectra XU 5/90, not 90/5 - now that I have physical access to
the box again. The google is full of horror stories about problems with this
particular model ;).

I tried SMP kernel, and it went a little further (no MCE) but it halted
after "Intel old style machine check architecture supported". For some odd
reason, linux says the box has 2 cpu's during boot, but it afaik only has
one.

The I forced mce_disabled to 1 in bluesmoke.c, and the SMP kernel booted.
During init, it oopsed, however.

I then compiled an UP kernel again, with mce_disabled=1 (same as "nomce" I
gather), and it booted.

The 3c509 appears not to work (but was found), scsi cdrom coughs badly but
it did boot :).

Thanks.


-- v --

v@iki.fi
