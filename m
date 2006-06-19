Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbWFSPYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbWFSPYl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWFSPYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:24:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:62860 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932513AbWFSPYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:24:40 -0400
From: Andi Kleen <ak@suse.de>
To: Jesper Dangaard Brouer <hawk@diku.dk>
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Date: Mon, 19 Jun 2006 17:24:31 +0200
User-Agent: KMail/1.9.3
Cc: Harry Edmon <harry@atmos.washington.edu>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
References: <4492D5D3.4000303@atmos.washington.edu> <44948EF6.1060201@atmos.washington.edu> <Pine.LNX.4.61.0606191638550.23553@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.61.0606191638550.23553@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606191724.31305.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If you use "pmtmr" try to reboot with kernel option "clock=tsc".

That's dangerous advice - when the system choses not to use
TSC it often has a reason.

> 
> On my Opteron AMD system i normally can route 400 kpps, but with 
> timesource "pmtmr" i could only route around 83 kpps.  (I found the timer 
> to be the issue by using oprofile).

Unless you're using packet sniffing or any other application
that requests time stamps on a socket then the timer shouldn't 
make much difference. Incoming packets are only time stamped
when someone asks for the timestamps.

-Andi
