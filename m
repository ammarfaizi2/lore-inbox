Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965906AbWKTPVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965906AbWKTPVL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 10:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965899AbWKTPVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 10:21:10 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:54933 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S965904AbWKTPVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 10:21:09 -0500
Date: Mon, 20 Nov 2006 10:20:44 -0500
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: How to go about debuging a system lockup?
Message-ID: <20061120152044.GX8236@csclub.uwaterloo.ca>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0D87@USRV-EXCH4.na.uis.unisys.com> <20061116223721.GS8236@csclub.uwaterloo.ca> <455DBC88.6040701@s5r6.in-berlin.de> <20061117142928.GT8236@csclub.uwaterloo.ca> <20061117224403.GE8238@csclub.uwaterloo.ca> <455E4142.8090202@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455E4142.8090202@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2006 at 12:09:54AM +0100, Stefan Richter wrote:
> Lennart Sorensen wrote:
> > OK, I have now tried connecting with firescope to just follow the dmesg
> > buffer across firewire.  Works great, until the system hangs, then
> > firescope reports that it couldn't perform the read.  I wonder what part
> > of the system has to lock up for the firewire card to no longer be able
> > to read memory on the system.
> 
> I suppose the PCI bus is no longer accessible to the chip.

Sure seems that way.  Makes me wonder if somehow a PCI transfer fails,
and the PCI controller isn't aborting the transfer after a timeout
(quite likely given the timeout timer is never enabled, and whenever I
try to do so, it seems to hang the system).  Time to start scoping the
lines.

--
Len Sorensen
