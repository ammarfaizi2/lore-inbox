Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754876AbWKPWh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876AbWKPWh2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 17:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754883AbWKPWh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 17:37:28 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:48796 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1754876AbWKPWh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 17:37:27 -0500
Date: Thu, 16 Nov 2006 17:37:21 -0500
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: How to go about debuging a system lockup?
Message-ID: <20061116223721.GS8236@csclub.uwaterloo.ca>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0D87@USRV-EXCH4.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0D87@USRV-EXCH4.na.uis.unisys.com>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2006 at 04:01:03PM -0600, Protasevich, Natalie wrote:
> If you can't drop in kdb, or no sysreq, then your interrupts are
> disabled. I used to be (with older systems anyway) that NMI button was
> on the system, so one could send an NMI and make the handler to print a
> trace. Newer systems might not have that, so you can built your own PCI
> card to send an NMI :)

I still haven't found a place to send an NMI on the Geode SC1200.  I
really want one for exactly that reason.  I have been suspecting that it
gets stuck somewhere with interrupts disabled, but I can't make sense of
where that could be.  They mention something about the NMI being
implemented by SMM in their VSA.  I don't like their virtual hardware
part very much.

> Another possibility is to use port 80 and make suspicious code print
> something to it. Once we used a small self-built thing with LEDs to
> catch the output to the parallel port while debugging silent boot
> failure. There are some port 80 cards that you can buy:
> http://auctions.yahoo.com/i:Port%2080%20Card%20and%20power%20supply%20te
> ster:102201489
> http://www.amazon.com/gp/product/B000234U3I/ref=pd_cp_e_title/103-887558
> 8-5330221

Hmm, one of those on the PCI bus might work.  Or perhaps the parallel
port will.  Of course if the problem is that somehow the PCI bus is
locked up, then I won't get a message anywhere since all the busses are
connected via PCI it seems.  I don't know if a PCI bus can lock up, but
for now I was assuming anything was possible.

> If your system has a jtag then in target probe would be useful if you
> have one (or can borrow one, those are expensive).

I have asked the system on a board maker if it has jtag anywhere.  Still
waiting on the answer to that.

--
Len Sorensen
