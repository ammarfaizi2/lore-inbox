Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264489AbTLVViB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 16:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264496AbTLVViB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 16:38:01 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:49404 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S264489AbTLVVh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 16:37:58 -0500
Date: Mon, 22 Dec 2003 13:37:56 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Chris Frey <cdfrey@netdirect.ca>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Maciej Zenczykowski <maze@cela.pl>,
       Arnaud Fontaine <arnaud@andesi.org>, Mike Fedyk <mfedyk@matchmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.4.23
Message-ID: <20031222213756.GB4577@ip68-4-255-84.oc.oc.cox.net>
References: <20031219224402.GA1284@scrappy> <Pine.LNX.4.44.0312200034560.15516-100000@gaia.cela.pl> <20031222021659.GA4857@ip68-4-255-84.oc.oc.cox.net> <20031222120557.A21530@netdirect.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031222120557.A21530@netdirect.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 12:05:57PM -0500, Chris Frey wrote:
> On Sun, Dec 21, 2003 at 06:17:00PM -0800, Barry K. Nathan wrote:
> > On one machine (with a bad power supply, as it turned out) it took
> > memtest86 almost 18 hours to report an error. So 12 hours isn't enough
> > either.
> > 
> > (On a related note, one machine that I tested with mprime's Torture Test
> > <http://www.mersenne.org/> took I think close to 43 hours to show a
> > failure. In that case I don't know if the failure was the CPU or the
> > motherboard, because in the end both failed on that system.)
> 
> At what point do people start suspecting the kernel?
> 
> I mean, I would hope the linux kernel is not so badly written as to stress
> the machine 24/7.  So after 12 hours of running memtest86 with clean
> results, does that not begin to point to a software error rather than
> hardware?

It's not a matter of stressing the machine 24/7. It's a matter of
using (not necessarily stressing, either) the machine in *different*
ways than Windows. Some machines with broken hardware can run Linux with
no apparent problems but have lots of corruption under Windows, and some
seem fine under Windows but really flake out under Linux.

You can trip over hardware flaws with a split second of just the
unluckiest usage -- there doesn't need to be any stress. The purpose of
the stress-testing is to make latent faults show up more quickly and
more consistently than they might under real-world usage.

(Sometimes you even need to combine stress tests in order to make
problems trigger. One machine I tested, which had a bad motherboard,
could run mprime alone without failing for I think several days, but if
I left a shell script running in the background to repeatedly extract
and compare a tar file, then mprime would fail in well under 5 minutes.
The testing was in response to occasional waves of bluescreens under
both Win2K and WinXP, so the Linux kernel was already cleared of any
responsibility.)

The point of my last e-mail was to show that 12 hours is not enough to
point to a software error. I guess personally I try to aim for a minimum
of 18 hours for memtest and 48 hours for mprime. I usually let memtest
go to at least 24 hours if I can.

-Barry K. Nathan <barryn@pobox.com>

