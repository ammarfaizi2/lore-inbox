Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132013AbRANKwp>; Sun, 14 Jan 2001 05:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132095AbRANKwf>; Sun, 14 Jan 2001 05:52:35 -0500
Received: from Cantor.suse.de ([194.112.123.193]:49926 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132013AbRANKwV>;
	Sun, 14 Jan 2001 05:52:21 -0500
Date: Sun, 14 Jan 2001 11:52:15 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Igmar Palsenberg <i.palsenberg@jdimedia.nl>,
        Harald Welte <laforge@gnumonks.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 + iproute2
Message-ID: <20010114115215.A22550@gruyere.muc.suse.de>
In-Reply-To: <14945.26991.35849.95234@pizda.ninka.net> <Pine.LNX.4.30.0101141013080.16469-100000@jdi.jdimedia.nl> <14945.28354.209720.579437@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14945.28354.209720.579437@pizda.ninka.net>; from davem@redhat.com on Sun, Jan 14, 2001 at 01:17:54AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 01:17:54AM -0800, David S. Miller wrote:
> 
> Igmar Palsenberg writes:
> 
>  > we might want to consider changing the error the call gives in case
>  > MULTIPLE_TABLES isn't set. -EINVAL is ugly, -ENOSYS should make the error
>  > more clear..
> 
> How do I tell the difference between using the wrong system call
> number to invoke an ioctl or socket option change, and making a
> call for a feature I haven't configured into my kernel?
> 
> I think ENOSYS is just a bad a choice.

In my opinion (rt)netlink would benefit a lot from introducing 5-10 new
errnos and possibly a new socket option to get a string/number with the exact 
error.
Configuring a complex subsystem like CBQ which has dozens of parameters
with only a single ed'esque error message (EINVAL) when something goes
wrong is just bad.


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
