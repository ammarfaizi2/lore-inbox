Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285000AbRLQFAZ>; Mon, 17 Dec 2001 00:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285007AbRLQFAF>; Mon, 17 Dec 2001 00:00:05 -0500
Received: from marine.sonic.net ([208.201.224.37]:30787 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S285000AbRLQE7z>;
	Sun, 16 Dec 2001 23:59:55 -0500
X-envelope-info: <dhinds@sonic.net>
Date: Sun, 16 Dec 2001 20:59:50 -0800
From: David Hinds <dhinds@sonic.net>
To: David Gibson <hermes@gibson.dropbear.id.au>,
        Ian Morgan <imorgan@webcon.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: in-kernel pcmcia oopsing in SMP
Message-ID: <20011216205950.B21159@sonic.net>
In-Reply-To: <20011201120541.B28295@sonic.net> <Pine.LNX.4.40.0112011513041.2329-100000@light.webcon.net> <20011201124630.A30249@sonic.net> <20011217142400.L30975@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011217142400.L30975@zax>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 02:24:00PM +1100, David Gibson wrote:
> 
> > Your oops, in tasklet code, sounds to me like a locking bug in the
> > driver code for managing the transmit stack vs. interrupt handling.
> > Have there been reports of the driver working well on SMP boxes?
> 
> Well, one of the main features of the driver is that the Tx path and
> the interupt handler (Rx path) are permitted to run concurrently.
> This is an issue even on UP (although not as complex), since the Rx
> patch can interrupt the Tx path.  I believe there has been at least
> some successful operation on SMP machines, but unfortunately I don't
> know any details.

Yes, after I wrote that, I looked at the orinoco code, and the tx and
interrupt paths looked pretty straightforward.  But I don't think I
would be able to catch anything that wasn't really obvious.

-- Dave
