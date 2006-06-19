Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWFSSYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWFSSYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWFSSYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:24:12 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:60572 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751284AbWFSSYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:24:11 -0400
Date: Mon, 19 Jun 2006 20:24:08 +0200 (CEST)
From: Jesper Dangaard Brouer <hawk@diku.dk>
To: Andi Kleen <ak@suse.de>
Cc: Harry Edmon <harry@atmos.washington.edu>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
In-Reply-To: <200606191724.31305.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0606192017370.31662@ask.diku.dk>
References: <4492D5D3.4000303@atmos.washington.edu> <44948EF6.1060201@atmos.washington.edu>
 <Pine.LNX.4.61.0606191638550.23553@ask.diku.dk> <200606191724.31305.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Jun 2006, Andi Kleen wrote:

>> If you use "pmtmr" try to reboot with kernel option "clock=tsc".
>
> That's dangerous advice - when the system choses not to use
> TSC it often has a reason.

Sorry, it was not a general advice, just something to try out.  It really 
solved my network performance issue...


>> On my Opteron AMD system i normally can route 400 kpps, but with
>> timesource "pmtmr" i could only route around 83 kpps.  (I found the timer
>> to be the issue by using oprofile).
>
> Unless you're using packet sniffing or any other application
> that requests time stamps on a socket then the timer shouldn't
> make much difference. Incoming packets are only time stamped
> when someone asks for the timestamps.

I do not know what caused the issue on my machine, but I can look into it 
if you like to know?

I do have VLAN interfaces on the machine and it seems that eth1 runs in 
PROMISC mode (eth1.xxx does not).  Could it be caused by that?

Hilsen
   Jesper Brouer

--
-------------------------------------------------------------------
MSc. Master of Computer Science
Dept. of Computer Science, University of Copenhagen
Author of http://www.adsl-optimizer.dk
-------------------------------------------------------------------
