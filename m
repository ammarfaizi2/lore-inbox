Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUFRRlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUFRRlP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 13:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266311AbUFRRlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 13:41:14 -0400
Received: from mail.dif.dk ([193.138.115.101]:45967 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266308AbUFRRk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 13:40:56 -0400
Date: Fri, 18 Jun 2004 19:39:58 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Thomas Latzelsberger <tlatzelsberger@gmx.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: limited bandwidth with SiS900 onboard NIC
In-Reply-To: <40D30FE4.1070900@gmx.at>
Message-ID: <8A43C34093B3D5119F7D0004AC56F4BC082C7F94@difpst1a.dif.dk>
References: <40D30FE4.1070900@gmx.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, Thomas Latzelsberger wrote:

> Dear readers,
>
> As mentioned on http://teg.homeunix.org/sis900.html and
> http://www.latzinator.com/acer_aspire_1705SMi.html there is a problem
> with bandwidth for the SiS900 onboard NIC. I allways use vanilla kernels
> and I'm having had this problem from 2.4.22 to 2.4.24 and from 2.6.2 to
> 2.6.6.

Does it work correctly with older or newer kernels - like 2.6.1 or 2.6.7?

> The symptom is easy to explain. I connect the PC to a 100MBit switch and
> no matter which method of transfer (ftp, scp, samba, nfs) I use, I get a
> maximum transfer rate of less than 400kB/s. By accident I found a dirty
> workaround that might be a hint for some tech savvy hackers: if I force
> the NIC to use halfduplex (allthough it's connected to a switch) it
> works like expected (7-8 MB/s).
>
> The only help I can be is that I can test new kernel drivers and send
> you feedback.
>
> Any help highly appreciated,
>

Doesn't have to be kernel related. I've seen plenty of cases over the
years where certain combinations of network hardware have issues like
that.
Sometimes it's a case of the two devices not being able to properly do
auto-negotiating together (even if both claim to support it) - I've seen
several cases of that with older 3COM NIC's hooked up to IBM switches -
forcing the port speed and duplex to the same value at both ends instead of
relying on auto-negotiation usually fix that up.
Sometimes it's a case of some equipment adverticing full duplex and/or
100mb/sec capability without actually being able to handle the dataflow
at that speed or duplex - I've seen that with several Realtek 8139 based
NIC's - the solution there is then often to drop down to half duplex or
10mb/sec speed...
And I've seen a lot of other similar problems when combining equipment
from various vendors in certain combinations.. some NIC's, Switches,
Hub's, Bridges etc just don't like eachother (and some are just plain crap
and don't work as adverticed).
Could also be caused by faulty cabling or too long cables I guess.

Ofcourse it can also be a driver issue, but it certainly does not have to
be. If it works with other kernel versions then I'd say a driver bug is
more likely.

--
Jesper Juhl <juhl-lkml@dif.dk>

